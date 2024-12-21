import 'package:flutter/material.dart';
import 'package:ras_project/Pages/login_page.dart';
import 'package:ras_project/Pages/register_page.dart';


class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isRememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
  
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 100, 0),
                child: Column(
                  children: [
                    const Text(
                      'GET \nSTARTED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 60,),
                    const Align(  
                      alignment:AlignmentDirectional(2, 0),
                      child :Text(
                      'Connecting you to a cleaner future, \none task at a time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w100,
                          ),
                    ),
                    ),
                    const SizedBox(height: 200,),
                    Align(
                      alignment: const AlignmentDirectional(2, 0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                        },
                        child: SafeArea(
                          child: Container(
                            width: 263,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF47D45C), Color(0xFF387D40)],
                                stops: [0, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                                ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            alignment: const AlignmentDirectional(0, 0),
                            child: const Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text('Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: const AlignmentDirectional(2, 0),
                      child: InkWell(splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                      },
                      child: SafeArea(
                        child: Container(
                        width: 263,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Color(0xFF4C6666)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(0, -1),
                            end: AlignmentDirectional(0, 1),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: const Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
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
