import 'package:flutter/material.dart';
import 'package:ras_project/componement/Text_field.dart';
import 'package:ras_project/Pages/phoneverification.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final recoveryemailTextController = TextEditingController();



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
                      'Forgot \nPassword?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 50),
                    MyTextField(
                      controller: recoveryemailTextController,
                      hintText: "Entre your email adresse",
                      obscureText: false,
                      prefixIcon: Icons.email_rounded,
                    ),
                    const SizedBox(height: 150),
                    
          
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PhoneVerificationPage(),
                                ),
                              );
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color:  Color.fromARGB(255, 71, 212, 92),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
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
    );
  }
}
