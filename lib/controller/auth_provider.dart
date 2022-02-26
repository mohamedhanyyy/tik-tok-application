import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:tik_tok/view/home_page.dart';

class AuthProvider with ChangeNotifier {
  var pickedImage;
  var imageUrl;

  ImagePicker imagePicker = ImagePicker();

  pickImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      this.pickedImage = File(pickedImage.path);
      uploadToStorage();
      notifyListeners();

      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture');
    }
  }

  void registerUser({
    required String email,
    required String password,
    required String name,
  }) {
    if (imageUrl.isNotEmpty) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'name': name, 'email': email, 'imageUrl': imageUrl});

        Get.to(() => HomePage());
      }).catchError((error) {
        Get.snackbar('Error', error.message, backgroundColor: Colors.red);
      });
    } else
      Get.snackbar('Error', 'Please choose a profile picture',
          backgroundColor: Colors.red);
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) {
      Get.to(() => HomePage());
    }).catchError((error) {
      Get.snackbar('Error', error.message, backgroundColor: Colors.red);
    });
  }

  uploadToStorage() async {
    String imageName = basename(pickedImage!.path);
    var refStorage = FirebaseStorage.instance.ref('users').child(imageName);

    await refStorage.putFile(File(pickedImage!.path));

    imageUrl = await refStorage.getDownloadURL();

    print(imageUrl);
  }
}
