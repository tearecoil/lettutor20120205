import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/my_button.dart';
import 'package:lettutor20120205/components/my_textfield.dart';
import 'package:lettutor20120205/service-api/auth-services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();

  Future<void> checkReset() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String? savedUsername = sharedpref.getString('username');
    String username = usernameController.text;
    String password = passwordController.text;
    String repass = confirmpassController.text;
    if (username.isEmpty) {
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
                  "Fail to reset password!!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "User's email / Password / Confirm password can't be blank",
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
      await AuthService.forgotPassword(
        email: username,
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
                      "Please check your email",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Check spam if you don't see the reset mail",
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
                    "Fail to reset password",
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
    // if (username.isEmpty || password.isEmpty || repass.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Container(
    //         padding: EdgeInsets.all(16),
    //         height: 90,
    //         decoration: BoxDecoration(
    //           color: Colors.red,
    //           borderRadius: BorderRadius.all(Radius.circular(20)),
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "Fail to reset password!!",
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 color: Colors.white,
    //               ),
    //             ),
    //             Text(
    //               "User's email / Password / Confirm password can't be blank",
    //               style: TextStyle(
    //                 fontSize: 12,
    //                 color: Colors.white,
    //               ),
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ],
    //         ),
    //       ),
    //       behavior: SnackBarBehavior.floating,
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //     ),
    //   );
    // } else {
    //   if (username == savedUsername) {
    //     if (password == repass) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Container(
    //             padding: EdgeInsets.all(16),
    //             height: 90,
    //             decoration: BoxDecoration(
    //               color: Colors.green,
    //               borderRadius: BorderRadius.all(Radius.circular(20)),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "Reset password successfully",
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 Text(
    //                   "Back to login",
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
    //       sharedpref.remove('username');
    //       sharedpref.remove('password');
    //       sharedpref.setString('username', username);
    //       sharedpref.setString('password', password);
    //       Navigator.popAndPushNamed(context, "/login");
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
    //                   "Fail to reset password!!",
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 Text(
    //                   "Password and Confirm password aren't the same",
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
    //   } else {
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
    //                 "Fail to reset password!!",
    //                 style: TextStyle(
    //                   fontSize: 18,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               Text(
    //                 "Wrong username",
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
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                  hintText: 'Insert your username',
                  obscureText: false,
                ),
                // const SizedBox(height: 10),
                // MyTextField(
                //   controller: passwordController,
                //   hintText: 'Insert New Password',
                //   obscureText: true,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // MyTextField(
                //   controller: confirmpassController,
                //   hintText: 'Confirm your password',
                //   obscureText: true,
                // ),
                const SizedBox(height: 25),
                MyButton(
                  text: "RESET PASSWORD",
                  onTap: () {
                    checkReset();
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Suddenly remeber your password? ',
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
                          Navigator.popAndPushNamed(context, "/Login");
                        }),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
