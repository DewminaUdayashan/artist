import 'dart:async';
import 'dart:io';
import 'package:artist/controllers/create_post_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class VideoEditor extends StatefulWidget {
  const VideoEditor({Key? key, required this.file}) : super(key: key);

  final File file;

  @override
  _VideoEditorState createState() => _VideoEditorState();
}

class _VideoEditorState extends State<VideoEditor> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  bool _exported = false;
  String _exportText = "";
  late VideoEditorController _controller;

  @override
  void initState() {
    _controller = VideoEditorController.file(
      widget.file,
      maxDuration: const Duration(seconds: 30),
    )..initialize().then((_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _exportVideo() async {
    _isExporting.value = true;
    bool _firstStat = true;

    setState(() {});

    _exportCover();
    //NOTE: To use [-crf 17] and [VideoExportPreset] you need ["min-gpl-lts"] package
    await _controller.exportVideo(
      // preset: VideoExportPreset.medium,
      // customInstruction: "-crf 17",
      onProgress: (statics) {
        // First statistics is always wrong so if first one skip it

        if (_firstStat) {
          _firstStat = false;
        } else {
          _exportingProgress.value = statics.getTime() /
              _controller.video.value.duration.inMilliseconds;
          print(_exportingProgress.value);
        }
      },
      onCompleted: (file) {
        _isExporting.value = false;
        if (!mounted) return;
        if (file != null) {
          Get.find<CreatePostController>().pickedFiles.last.file = file;
          Get.find<CreatePostController>().update();
          Get.back();
        } else {
          _exportText = "Error on export video :(";
        }
      },
    );
  }

  void _exportCover() async {
    setState(() => _exported = false);
    await _controller.extractCover(
      quality: 50,
      onCompleted: (cover) {
        if (!mounted) return;

        if (cover != null) {
          Get.find<CreatePostController>().pickedFiles.last.thumb = cover;
        } else {
          _exportText = "Error on cover exportation :(";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _exportVideo,
            icon: const Icon(Icons.check_box),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: _controller.initialized
          ? Stack(
              children: [
                Column(
                  children: [
                    if (_isExporting.value) ...[
                      const LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                    // _topNavBar(),
                    Expanded(
                      child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Expanded(
                                  child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Stack(alignment: Alignment.center, children: [
                                    CropGridViewer(
                                      controller: _controller,
                                      showGrid: false,
                                    ),
                                    GestureDetector(
                                      onTap: _controller.video.play,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.play_arrow,
                                            color: Colors.black),
                                      ),
                                    )
                                  ]),
                                  CoverViewer(controller: _controller)
                                ],
                              )),
                              Container(
                                height: 200,
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    TabBar(
                                      indicatorColor: Colors.white,
                                      tabs: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child:
                                                      Icon(Icons.content_cut)),
                                              Text('Trim')
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child:
                                                      Icon(Icons.video_label)),
                                              Text('Cover')
                                            ]),
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: _trimSlider()),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [_coverSelection()]),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      AnimatedBuilder(
        animation: _controller.video,
        builder: (_, __) {
          final duration = _controller.video.value.duration.inSeconds;
          final pos = _controller.trimPosition * duration;
          final start = _controller.minTrim * duration;
          final end = _controller.maxTrim * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: height / 4),
            child: Row(children: [
              Text(
                formatter(Duration(seconds: pos.toInt())),
                style: const TextStyle(color: Colors.white),
              ),
              const Expanded(child: SizedBox()),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text(formatter(Duration(seconds: start.toInt())),
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(width: 10),
                Text(formatter(Duration(seconds: end.toInt())),
                    style: const TextStyle(color: Colors.white)),
              ])
            ]),
          );
        },
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: height / 4),
        child: TrimSlider(
          quality: 7,
          child: TrimTimeline(
            controller: _controller,
            margin: const EdgeInsets.only(top: 10),
          ),
          controller: _controller,
          height: height,
          horizontalMargin: height / 4,
        ),
      )
    ];
  }

  Widget _coverSelection() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: height / 4),
        child: CoverSelection(
          controller: _controller,
          height: height,
          nbSelection: 5,
          quality: 5,
        ));
  }
}
