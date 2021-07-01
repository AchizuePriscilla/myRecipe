import 'package:flutter/material.dart';
import 'package:my_recipe/enums/auth_result_status.dart';
import 'package:my_recipe/routes/route_names.dart';
import 'package:my_recipe/services/auth_exception_handler.dart';
import 'package:my_recipe/services/firebase_auth_helper.dart';
import 'package:my_recipe/shared/constants.dart';
import 'package:my_recipe/shared/widgets/button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1,
                    tileMode: TileMode.repeated,
                    stops: [
                  0.3,
                  1,
                ],
                    colors: [
                  Colors.white,
                  Colors.lightGreenAccent.withOpacity(0.6)
                ])),
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset("assets/images/myRecipeLogo.png"),
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.center,
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: "Enter your Email"),
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                TextField(
                                  controller: passwordController,
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: "Enter your Password"),
                                  onChanged: (value) {
                                    password = value;
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Button(
                                    buttonColor: Colors.green,
                                    buttonText: 'Log in',
                                    onPressed: () async {
                                      setState(() {
                                        showSpinner = true;
                                      });

                                      final status = await FirebaseAuthHelper()
                                          .login(email: email, pass: password);
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      if (status ==
                                          AuthResultStatus.successful) {
                                        emailController.clear();
                                        passwordController.clear();
                                        Navigator.pushNamed(
                                            context, RouteNames.homeScreen);

                                        // Navigator.pushAndRemoveUntil(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             HomeScreen()),
                                        //     (r) => false);
                                      } else {
                                        final errorMsg = AuthExceptionHandler
                                            .generateExceptionMessage(status);
                                        _showAlertDialog(errorMsg);
                                      }
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Login Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }
}
