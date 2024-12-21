import 'package:flutter/material.dart';
import 'package:ras_project/Pages/Confirme_request_page.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(58, 84, 51, 1), // Set the background color
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
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
              //----------------------------------------------
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 350,
                    height: 763,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(226, 255, 224, 0.573),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                          bottom: Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            'Request for Autonomous Robot',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Let's start!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Padding(
                          padding: const EdgeInsets.only(right: 230),
                          child: Text(
                            ' User Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFAFAFA),
                            ),
                          ),
                        ),
                        // Generated code for this TextField Widget...
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 280,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                      hintText: 'Entre Your full name here',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(53, 255, 255, 255),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(37, 58, 84, 51),
                                    ),
                                    style: const TextStyle(
                                        fontFamily: 'Popppins',
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: Text(
                            ' Phone Number',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFAFAFA),
                            ),
                          ),
                        ),
                        // Generated code for this TextField Widget...
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 280,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                      hintText: 'Entre Your Phone number here',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(53, 255, 255, 255),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(37, 58, 84, 51),
                                    ),
                                    style: const TextStyle(
                                        fontFamily: 'Popppins',
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        const Padding(
                          padding: const EdgeInsets.only(right: 170),
                          child: Text(
                            ' Entre your location',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFAFAFA),
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Action when button is pressed
                              // print("Pick Location button pressed");
                            },
                            icon: const Icon(Icons.location_on,
                                color: Colors.white),
                            label: const Text(
                              'Pick Location',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 3, 54, 4),
                              // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Rounded corners
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: Text(
                            ' Phone Number',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFAFAFA),
                            ),
                          ),
                        ),

                        // Generated code for this TextField Widget...
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 280,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.expand_circle_down,
                                          color: const Color.fromARGB(
                                              255, 109, 109, 109),
                                        ),
                                      ),
                                      isDense: true,
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                      hintText: 'Task description',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(53, 255, 255, 255),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(37, 58, 84, 51),
                                    ),
                                    style: const TextStyle(
                                        fontFamily: 'Popppins',
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: Text(
                            ' Estimated Time',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFAFAFA),
                            ),
                          ),
                        ),
                        // Generated code for this TextField Widget...
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 280,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(53, 255, 255, 255),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor:
                                          const Color.fromARGB(37, 58, 84, 51),
                                    ),
                                    style: const TextStyle(
                                        fontFamily: 'Popppins',
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 135,
                              height: 60,
                              padding: const EdgeInsets.all(8.0),
                              
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancle',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 135,
                              height: 60,
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Action when button is pressed
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ConfirmeRequestPage()),
                                  );
                                },
                                child: const Text(
                                  'Confirme',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 3, 54, 4),
                                  // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Rounded corners
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
