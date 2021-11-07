import 'package:artist/controllers/app_controller.dart';
import 'package:artist/controllers/edit_account_controller.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccount extends GetWidget<AppController> {
  const EditAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Edit Profile',
          style: context.textTheme.headline3!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              editAccountController.saveChanges();
            },
            icon: const Icon(
              Icons.check_circle_outlined,
              color: Colors.blue,
              size: 33,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<EditAccountController>(
            init: EditAccountController(),
            builder: (controllerr) {
              return editAccountController.isSaving
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Center(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                editAccountController.pickImage();
                              },
                              child: Stack(
                                children: [
                                  controllerr.file == null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              controller.tempUser!.imageUrl!),
                                          maxRadius: Get.width / 6,
                                        )
                                      : CircleAvatar(
                                          backgroundImage:
                                              FileImage(controllerr.file!),
                                          maxRadius: Get.width / 6,
                                        ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.mode_edit_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: editAccountController.nameController,
                            style: context.textTheme.headline4,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: context.textTheme.headline3,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: editAccountController.bioController,
                            style: context.textTheme.headline4,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 50,
                            decoration: InputDecoration(
                              labelText: 'Bio',
                              labelStyle: context.textTheme.headline3,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: editAccountController.mobileController,
                            style: context.textTheme.headline3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile',
                              labelStyle: context.textTheme.bodyText1,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
