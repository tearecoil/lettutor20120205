import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/my_button.dart';
import 'package:lettutor20120205/components/my_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lettutor20120205/service-api/auth-services.dart';

class MainLogin extends StatefulWidget {
  const MainLogin({super.key});

  @override
  State<MainLogin> createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void initState() {
    super.initState();
    instantLogin();
  }

  Future<void> instantLogin() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String savedUsername = sharedpref.getString('email') ?? "";
    String savedPassword = sharedpref.getString('password') ?? "";
    print(savedUsername);
    print(savedPassword);
    if (savedUsername != "" && savedPassword != "") {
      await AuthService.loginWithEmailAndPassword(
          email: savedUsername,
          password: savedPassword,
          onSuccess: (user) async {
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
                        "Auto log in with saved information",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Welcome to LetTutor",
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
            sharedpref.setString('email', savedUsername);
            sharedpref.setString('password', savedPassword);
            Navigator.popAndPushNamed(context, "/home");
          },
          onError: () {});
    }
  }

  Future<void> checkLogin() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String username = usernameController.text;
    String password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
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
                  "Log in Failed!!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "User's email / Password can't be blank",
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
      await AuthService.loginWithEmailAndPassword(
        email: username,
        password: password,
        onSuccess: (user) async {
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
                      "Log in successfully",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Welcome to LetTutor",
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
          sharedpref.setString('email', username);
          sharedpref.setString('password', password);
          Navigator.popAndPushNamed(context, "/home");
        },
        onError: () => ScaffoldMessenger.of(context).showSnackBar(
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
                    "Log in failed",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Check your username and password again",
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
      // onError: (user) async {
      //   print("Fail");
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Container(
      //         padding: EdgeInsets.all(16),
      //         height: 90,
      //         decoration: BoxDecoration(
      //           color: Colors.green,
      //           borderRadius: BorderRadius.all(Radius.circular(20)),
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Log in successfully",
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 color: Colors.white,
      //               ),
      //             ),
      //             Text(
      //               "Welcome to LetTutor",
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
      // });

      // if (username == savedUsername && password == savedPassword) {

      // } else {
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
      //               "Log in Failed!!",
      //               style: TextStyle(
      //                 fontSize: 18,
      //                 color: Colors.white,
      //               ),
      //             ),
      //             Text(
      //               "Username / Password is incorrect",
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
      // }
    }
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

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.popAndPushNamed(context, "/fgpass");
                        }),
                    // Text(
                    //   'Forgot Password?',
                    //   style: TextStyle(color: Colors.grey[600]),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                text: "LOG IN",
                onTap: () {
                  checkLogin();
                },
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/images/ic-facebook.png')),
                  SizedBox(width: 25),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/images/ic-google.png'))
                ],
              ),

              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member yet? ',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(context, "/signup");
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
