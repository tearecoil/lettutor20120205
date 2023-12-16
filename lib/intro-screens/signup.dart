import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/my_button.dart';
import 'package:lettutor20120205/components/my_textfield.dart';
import 'package:lettutor20120205/service-api/auth-services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();

  Future<void> signupCheck() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String confpass = confirmpassController.text;
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmpassController.text.isEmpty)
    // if (usernameController.text.isEmpty || passwordController.text.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up Failed!!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "User's email / Password / Confirm can't be blank",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    } else {
      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: EdgeInsets.all(16),
              height: 90,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign up failed",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Password and Confirm must 6 characters at least. Please reload the app",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      } else {
        if (confpass.trim() == password.trim()) {
          await AuthService.registerWithEmailAndPassword(
            email: username,
            password: password,
            onSuccess: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    padding: EdgeInsets.all(16),
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign up successfully",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          //checkMail,
                          "Heading to login",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              );
              sharedpref.setString('accountType', "/studentprofile");
              Navigator.popAndPushNamed(context, "/login");
            },
            onError: (message) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  padding: EdgeInsets.all(16),
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up failed",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          );
        }
      }
    }
    // } else {
    //   if (username.length < 10) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Container(
    //           padding: EdgeInsets.all(16),
    //           height: 90,
    //           decoration: BoxDecoration(
    //             color: Colors.red,
    //             borderRadius: BorderRadius.all(Radius.circular(20)),
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "Sign Up Failed!!",
    //                 style: TextStyle(
    //                   fontSize: 18,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               Text(
    //                 "Username must be a valid Gmail",
    //                 style: TextStyle(
    //                   fontSize: 12,
    //                   color: Colors.white,
    //                 ),
    //                 maxLines: 2,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //         behavior: SnackBarBehavior.floating,
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //       ),
    //     );
    //   } else {
    //     String checkMail =
    //         username.substring(username.length - 10, username.length);
    //     if (checkMail == "@gmail.com") {
    //       if (confirmpassController.text.trim() ==
    //           passwordController.text.trim()) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             content: Container(
    //               padding: EdgeInsets.all(16),
    //               height: 90,
    //               decoration: BoxDecoration(
    //                 color: Colors.green,
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "YESSSS!!",
    //                     style: TextStyle(
    //                       fontSize: 18,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   Text(
    //                     //checkMail,
    //                     "Sign up successfully",
    //                     style: TextStyle(
    //                       fontSize: 12,
    //                       color: Colors.white,
    //                     ),
    //                     maxLines: 2,
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             behavior: SnackBarBehavior.floating,
    //             backgroundColor: Colors.transparent,
    //             elevation: 0,
    //           ),
    //         );
    //         sharedpref.setString('username', usernameController.text);
    //         sharedpref.setString('password', passwordController.text);

    //         sharedpref.setString('name', "");
    //         sharedpref.setString('aboutMe', "");
    //         sharedpref.setString('avatar', "assets/images/my_ava.jpg");
    //         sharedpref.setString('nation', "VietNam");
    //         Navigator.popAndPushNamed(context, "/login");
    //       } else {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             content: Container(
    //               padding: EdgeInsets.all(16),
    //               height: 90,
    //               decoration: BoxDecoration(
    //                 color: Colors.red,
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Sign Up Failed!!",
    //                     style: TextStyle(
    //                       fontSize: 18,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   Text(
    //                     "Password and Confirm aren't the same",
    //                     style: TextStyle(
    //                       fontSize: 12,
    //                       color: Colors.white,
    //                     ),
    //                     maxLines: 2,
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             behavior: SnackBarBehavior.floating,
    //             backgroundColor: Colors.transparent,
    //             elevation: 0,
    //           ),
    //         );
    //       }
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Container(
    //             padding: EdgeInsets.all(16),
    //             height: 90,
    //             decoration: BoxDecoration(
    //               color: Colors.red,
    //               borderRadius: BorderRadius.all(Radius.circular(20)),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "Sign Up Failed!!",
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 Text(
    //                   //checkMail,
    //                   "Username must be a valid Gmail",
    //                   style: TextStyle(
    //                     fontSize: 12,
    //                     color: Colors.white,
    //                   ),
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           behavior: SnackBarBehavior.floating,
    //           backgroundColor: Colors.transparent,
    //           elevation: 0,
    //         ),
    //       );
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/login_bg.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text('Say hello to your English tutors',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.blue)),
              const Text(
                  'Become fluent faster through one on one video chat lessons tailored to your goals.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black)),
              const SizedBox(height: 20),
              MyTextField(
                controller: usernameController,
                hintText: 'Username - eg: abc@gmail.com',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: confirmpassController,
                hintText: 'Confirm your password',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              MyButton(
                text: "SIGN UP",
                onTap: () {
                  signupCheck();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already got an account? ',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                      child: Text(
                        "Back to Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(context, "/login");
                      }),
                  // const Text(
                  //   'Sign up',
                  //   style: TextStyle(
                  //     color: Colors.blue,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
