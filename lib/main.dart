import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok/controller/auth_provider.dart';
import 'package:tik_tok/view/login_screen.dart';
import 'package:tik_tok/view/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: GetMaterialApp(
        title: 'Tik Tok',
        home: SignUpScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          splashColor: Colors.orange,
        ),
      ),
    ),
  );
}
