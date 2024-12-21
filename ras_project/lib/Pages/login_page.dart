import 'package:flutter/material.dart';
import 'package:ras_project/Pages/register_page.dart';
import 'package:ras_project/componement/Text_field.dart';
import 'package:ras_project/Pages/location_tracker.dart';
import 'package:ras_project/services/AuthServices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isLoading = false;

  final AuthService authService = AuthService();
  bool isRememberMeChecked = false;

  Future<void> Submit() async {
    if (emailTextController.text == "" && passwordTextController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "All Fields Are Required",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: "Close",
            textColor: Colors.yellow,
            onPressed: () {
              print("Undo action clicked!");
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      setState(() {
        isLoading = true;
      });

      final isLoggedIn = await authService.LoginUser(
          emailTextController.text, passwordTextController.text);
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TrackBus()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(authService.errorLogin),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Top Back Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Rest of the Login Page Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Back!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    MyTextField(
                      controller: emailTextController,
                      hintText: "Number or Email",
                      obscureText: false,
                      prefixIcon: Icons.account_circle_rounded,
                    ),
                    const SizedBox(height: 30),
                    MyTextField(
                      controller: passwordTextController,
                      hintText: "Password",
                      obscureText: true,
                      prefixIcon: Icons.lock_rounded,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isRememberMeChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isRememberMeChecked = value!;
                                });
                              },
                              activeColor:
                                  const Color.fromARGB(255, 71, 212, 92),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) =>
                        //             const ForgotPasswordPage(),
                        //       ),
                        //     );
                        //   },
                        //   child: const Text(
                        //     'Forgot Password?',
                        //     style: TextStyle(
                        //       color: Color.fromARGB(255, 71, 212, 92),
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () {
                                Submit();
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 71, 212, 92),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Color.fromARGB(255, 86, 85, 85),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Sign in with Facebook");
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: const Icon(
                              Icons.facebook,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            print("Sign in with Gmail");
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: const Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            print("Sign in with X");
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Not a member? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Color.fromARGB(255, 71, 212, 92),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
