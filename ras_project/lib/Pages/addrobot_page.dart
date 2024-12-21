import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ras_project/services/RobotServices.dart';

class AddRobot extends StatefulWidget {
  const AddRobot({
    super.key,
  });

  @override
  State<AddRobot> createState() => _AddRobotState();
}

class _AddRobotState extends State<AddRobot> {
  final _formKey = GlobalKey<FormState>();

  String id = "";
  String name = "";
  double lat = 0.0;
  LocationData? currentLocation;
  double long = 0.0;
  bool loading = false;
  String battery = "";
  String niveau = "";

  late RobotService _robotService = RobotService();

  Future<void> _getCurrentLocation() async {
    var location = Location();
    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
        long = userLocation.longitude!;
        lat = userLocation.latitude!;
      });
    } on Exception {
      currentLocation = null;
    }
    location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        currentLocation = newLocation;
        long = newLocation.longitude!;
        lat = newLocation.latitude!;
      });
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      await _getCurrentLocation();
      setState(() {
        loading = true;
      });
      bool correctAnswer =
          await _robotService.AddRobot(id, name, lat, long, battery, niveau);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            correctAnswer
                ? "Robot Added With Success"
                : "Id Robot Already Exist",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: !correctAnswer ? Colors.red : Colors.green,
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
      setState(() {
        loading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Robot",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        shadowColor: Colors.blueAccent.withOpacity(0.5),
        elevation: 8,
        backgroundColor: const Color(0xFF50586C),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: const Color(0xFFDCE2F0)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Card(
                      margin: const EdgeInsets.only(top: 80),
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_box,
                                size: 50,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return " Id Required";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    id = val;
                                  });
                                },
                                initialValue: id.toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Id Robot",
                                  hintText: "Enter Id Robot",
                                  prefixIcon: Icon(Icons.numbers),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.blue)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.red)),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return " Name Required";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                                initialValue: name,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    labelText: "Name Robot",
                                    hintText: "Enter Name Robot",
                                    errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red)),
                                    prefixIcon: Icon(Icons.account_box)),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Battery Required";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    battery = val;
                                  });
                                },
                                initialValue: name,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: "Battery Robot",
                                    hintText: "Enter Battery Robot",
                                    errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red)),
                                    prefixIcon: Icon(Icons.account_box)),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Niveau Poubelle Required";
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    niveau =  val;
                                  });
                                },
                                initialValue: niveau.toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: "Niveau Robot",
                                    hintText: "Enter Niveau",
                                    errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.red)),
                                    prefixIcon: Icon(Icons.account_box)),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  elevation: 5,
                                ),
                                onPressed: loading
                                    ? null
                                    : () {
                                        _submit();
                                      },
                                child: loading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : const Text(
                                        "Save",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                              )
                            ],
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
