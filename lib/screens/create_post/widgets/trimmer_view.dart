// import 'dart:io';

// import 'package:artist/controllers/create_post_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_editor/domain/bloc/controller.dart';
// import 'package:video_editor/video_editor.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_trimmer/video_trimmer.dart';

// class TrimmerView extends StatefulWidget {
//   const TrimmerView({Key? key, required this.file}) : super(key: key);

//   final File file;
//   @override
//   _TrimmerViewState createState() => _TrimmerViewState();
// }

// class _TrimmerViewState extends State<TrimmerView> {
//   final Trimmer _trimmer = Trimmer();

//   double _startValue = 0.0;
//   double _endValue = 0.0;

//   bool _isPlaying = false;
//   bool _progressVisibility = false;

//   Future<String?> _saveVideo() async {
//     setState(() {
//       _progressVisibility = true;
//     });

//     String? _value;
//     await _trimmer
//         .saveTrimmedVideo(
//       startValue: _startValue,
//       endValue: _endValue,
//     )
//         .then((value) {
//       setState(() {
//         _progressVisibility = false;
//         _value = value;
//       });
//     });

//     return _value;
//   }

//   void _loadVideo() {
//     _trimmer.loadVideo(videoFile: widget.file);
//   }

//   @override
//   void initState() {
//     super.initState();

//     _loadVideo();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Trimmer"),
//       ),
//       body: Builder(
//         builder: (context) => Center(
//           child: Container(
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.black,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Visibility(
//                   visible: _progressVisibility,
//                   child: const LinearProgressIndicator(
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _progressVisibility
//                       ? null
//                       : () async {
//                           _saveVideo().then((outputPath) {
//                             print('OUTPUT PATH: $outputPath');
//                             Get.find<CreatePostController>()
//                                 .compressVideo(outputPath!);
//                           });
//                         },
//                   child: const Text("Next"),
//                 ),
//                 Expanded(
//                   child: VideoViewer(trimmer: _trimmer),
//                 ),
//                 Center(
//                   child: TrimEditor(
//                     trimmer: _trimmer,
//                     viewerHeight: 50.0,
//                     viewerWidth: MediaQuery.of(context).size.width,
//                     maxVideoLength: Duration(minutes: 1),
//                     onChangeStart: (value) {
//                       _startValue = value;
//                     },
//                     onChangeEnd: (value) {
//                       _endValue = value;
//                     },
//                     onChangePlaybackState: (value) {
//                       setState(() {
//                         _isPlaying = value;
//                       });
//                     },
//                   ),
//                 ),
//                 TextButton(
//                   child: _isPlaying
//                       ? Icon(
//                           Icons.pause,
//                           size: 80.0,
//                           color: Colors.white,
//                         )
//                       : Icon(
//                           Icons.play_arrow,
//                           size: 80.0,
//                           color: Colors.white,
//                         ),
//                   onPressed: () async {
//                     bool playbackState = await _trimmer.videPlaybackControl(
//                       startValue: _startValue,
//                       endValue: _endValue,
//                     );
//                     setState(() {
//                       _isPlaying = playbackState;
//                     });
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTrimmer extends StatefulWidget {
  const VideoTrimmer({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  State<VideoTrimmer> createState() => _VideoTrimmerState();
}

class _VideoTrimmerState extends State<VideoTrimmer> {
  VideoPlayerController? videoPlayerController;
  bool loaded = false;
  RangeValues? _currentRangeValues;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file)
      ..initialize().then((value) {
        setState(() {
          loaded = true;
          videoPlayerController!.play();
          _currentRangeValues = const RangeValues(
            0,
            1,
          );
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: videoPlayerController!.initialize(),
        builder: (context, snapshot) {
          return !loaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController!),
                      ),
                    ),
                    RangeSlider(
                      values: _currentRangeValues!,
                      min: 0,
                      max: videoPlayerController!.value.duration.inSeconds
                          .toDouble(),
                      divisions: 5,
                      labels: RangeLabels(
                        (_currentRangeValues!.start.round() / 60).toString(),
                        (_currentRangeValues!.end.round() / 60).toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                          videoPlayerController!
                              .seekTo(Duration(seconds: values.start.toInt()));
                        });
                      },
                    )
                  ],
                );
        },
      ),
    );
  }
}
