import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok/controller/auth_provider.dart';
import 'package:tik_tok/shared/constants.dart';
import 'package:tik_tok/view/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(height: height * 0.15),
            Center(
              child: Text(
                'Welcome To Tik Tok',
                style: bigTextStyle(),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (val) => emailController.text = val!,
                validator: (val) {
                  if (val!.isEmpty) return 'Please Enter Your Email';
                },
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon:
                      Icon(Icons.email, color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                onSaved: (val) => passwordController.text = val!,
                validator: (val) {
                  if (val!.isEmpty) return 'Please Enter Your Password';
                  if (val.length < 6) return 'Password at least 6 characters';
                },
                obscureText: passwordVisibility == true ? true : false,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  suffixIcon: passwordVisibility == true
                      ? IconButton(
                          icon: Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                             setState(() {
                               passwordVisibility = !passwordVisibility;
                             });
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                          onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                          },
                        ),
                  prefixIcon:
                      Icon(Icons.lock, color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    Provider.of<AuthProvider>(context, listen: false).loginUser(
                        email: emailController.text,
                        password: passwordController.text);
                  }
                },
                child: Text(
                  'Log In',
                  style: mediumTextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Center(
                child: InkWell(
                    onTap: () {
                      Get.to(() => SignUpScreen());
                    },
                    child: Text(
                      'Don\'t have account ? sign up',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          letterSpacing: 1.5),
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
