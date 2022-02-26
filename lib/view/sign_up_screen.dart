import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok/controller/auth_provider.dart';
import 'package:tik_tok/shared/constants.dart';
import 'package:tik_tok/view/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool passwordVisibility = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Form(
          child: ListView(
            children: [
              SizedBox(height: height * 0.15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Center(
                  child: Text(
                    'Welcome to Tik Tok',
                    style: bigTextStyle(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Provider.of<AuthProvider>(context).pickedImage != null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(
                              Provider.of<AuthProvider>(context).pickedImage!,
                            ),
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
                            ),
                          ),
                    GestureDetector(
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .pickImage();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        )),
                  ],
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
                    prefixIcon: Icon(Icons.email,
                        color: Theme.of(context).primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: TextFormField(
                  onSaved: (val) => nameController.text = val!,
                  validator: (val) {
                    if (val!.isEmpty) return 'Please Enter Your Name';
                    if (val.length > 20) return 'Name at most 20 character';
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (val) => passwordController.text = val!,
                  validator: (val) {
                    if (val!.isEmpty) return 'Please Enter Your Password';
                    if (val.length < 6) return 'Password at least 6 characters';
                  },
                  controller: passwordController,
                  obscureText: passwordVisibility == true ? true : false,
                  decoration: InputDecoration(
                    suffixIcon: passwordVisibility == true
                        ? IconButton(
                            icon: Icon(
                              Icons.visibility_off,
                              color: Colors.red,
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
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                    hintText: 'Enter your password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: ()   {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Provider.of<AuthProvider>(context, listen: false)
                              .registerUser(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                           );
                        }
                      },
                      child: Text('Sign Up'),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Center(
                    child: InkWell(
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Text(
                    'Already have account ? Log in',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      letterSpacing: 1.5,
                    ),
                  ),
                )),
              ),
            ],
          ),
          key: formKey,
        ),
      ),
    );
  }
}
