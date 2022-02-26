import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File? videoFile;
  String? videoUrl;

  ConfirmScreen({this.videoFile, this.videoPath});

  final String? videoPath;

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      controller = VideoPlayerController.file(widget.videoFile!);
    });

    controller.initialize();

    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: 400,
              width: 400,
              child: VideoPlayer(controller),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Enter Title for the video',
                prefixIcon: Icon(
                  Icons.title,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: description,
              decoration: InputDecoration(
                hintText: 'Enter Description for the video',
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                child: Text('Upload'),
                onPressed: () async {
                  String imageName = basename(widget.videoFile!.path);
                  var refStorage =
                      FirebaseStorage.instance.ref('users').child(imageName);

                  await refStorage.putFile(File(widget.videoFile!.path));

                  widget.videoUrl = await refStorage.getDownloadURL();

                  print(widget.videoUrl);

                  FirebaseFirestore.instance.collection('videos').doc(FirebaseAuth.instance.currentUser!.uid).set({
                    'video':widget.videoUrl,
                    'title':title.text,
                    'description':description.text
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
