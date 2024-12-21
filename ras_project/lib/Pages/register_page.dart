import 'package:flutter/material.dart';
import 'package:ras_project/Pages/login_page.dart';
import 'package:ras_project/componement/Text_field.dart';
import 'package:ras_project/Pages/welcome_page.dart';
import 'package:ras_project/services/AuthServices.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();
  bool isRememberMeChecked = false;
  final AuthService auth = AuthService();
  bool isLoading = false;

  Future<void> Register() async {
    if (emailTextController.text == "" &&
        passwordTextController.text == "" &&
        confirmpasswordTextController.text == "") {
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
      if (passwordTextController.text != confirmpasswordTextController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password Should be same confirm password",
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
        final registerOk = await auth.Register(emailTextController.text,
            emailTextController.text, passwordTextController.text);
        setState(() {
          isLoading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1D1D1D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1D1D1D),
          elevation: 0, // Remove shadow
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Create an',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 70),
                  MyTextField(
                    controller: emailTextController,
                    hintText: "User Name or Email",
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
                  const SizedBox(height: 30),
                  MyTextField(
                    controller: confirmpasswordTextController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    prefixIcon: Icons.lock_rounded,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: isRememberMeChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isRememberMeChecked = value!;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 71, 212, 92),
                      ),
                      const Text(
                        'You agree to the public offer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              Register();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 71, 212, 92),
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
                          "Already Have an account? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Login now",
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
          ),
        ));
  }
}
