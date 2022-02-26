import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok/view/confirm_screen.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  pickVideo(context) async {
    var video = await ImagePicker().pickVideo(source: ImageSource.camera);

    if (video != null) {
      Get.to(() => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Upload Video"),
          onPressed: () {
            pickVideo(context);
          },
        ),
      ),
    );
  }
}
