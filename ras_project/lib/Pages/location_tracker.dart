import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ras_project/Pages/Robotdetails_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ras_project/Pages/addrobot_page.dart';
import 'package:ras_project/Pages/Request_page.dart';
import 'package:ras_project/Pages/login_page.dart';
import 'package:ras_project/model/BusModel.dart';
import 'package:ras_project/services/AuthServices.dart';
import 'package:ras_project/services/RobotServices.dart';

//-------------------------------------------
class _ExpandableMenu extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _ExpandableMenu({
    required this.icon,
    required this.title,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  State<_ExpandableMenu> createState() => _ExpandableMenuState();
}

class _ExpandableMenuState extends State<_ExpandableMenu> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(widget.icon, color: Colors.black87),
          title:
              Text(widget.title, style: const TextStyle(color: Colors.black87)),
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.black87,
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded) ...widget.children,
      ],
    );
  }
}

//-------------------------------------------

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  _TrackBusState createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double? totalDistance;
  double? totalDuration;
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  double _currentZoom = 13.0;
  Timer? _markerUpdateTimer;
  double lat = 0.0;
  double long = 0.0;
  String username = "";
  late AuthService _authService = AuthService();
  final RobotService _robotSrvice = RobotService();
  List<RobotModel> robots = [];

  FetchRobots() async {
    List<RobotModel> robots_data = await _robotSrvice.getrobots();
    setState(() {
      robots = robots_data;
    });
    _getCurrentLocation();
  }

  Future<void> initializeData() async {
    await _authService.getUserFromStorage();
    setState(() {
      username = _authService.isAuth ? _authService.user.Email : "Guest";
    });
  }

  final String orsApiKey =
      '5b3ce3597851110001cf6248ed49d5d5d50b47c886fa2a8261919d5d';

  void _startMarkerUpdateTimer() {
    _markerUpdateTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _getCurrentLocation();
    });
  }

  @override
  void initState() {
    super.initState();
    FetchRobots();
    initializeData();
    _startMarkerUpdateTimer();
  }

  @override
  void dispose() {
    super.dispose();
    FetchRobots();
  }

  Future<void> _getCurrentLocation() async {
    var location = Location();
    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
        markers.clear();
        markers.add(
          Marker(
            width: 50.0,
            height: 50.0,
            point: LatLng(userLocation.latitude!, userLocation.longitude!),
            child: const Icon(Icons.accessibility_new_outlined,
                color: Colors.blue, size: 40.0),
          ),
        );

        for (var robot in robots) {
          markers.add(
            Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(robot.latitude, robot.longitude),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RobotDetailsPage(),
                    ),
                  );
                },
                child: Image.asset('images/location_robot_signe.png'),
              ),
            ),
          );
        }
      });
    } on Exception {
      setState(() {
        currentLocation = null;
      });
    }
  }

  bool loading = false;

  UpdateEtat(RobotModel _robot) async {
    setState(() {
      loading = true;
    });
    await _robotSrvice.UpdateRobotEtat(_robot.id);
    setState(() {
      loading = false;
    });
    FetchRobots();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _robot.etat == true ? "Robot Not Running" : "Robot Running",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _robot.etat == true ? Colors.red : Colors.green,
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
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;
    final start =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    final response = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];
      setState(() {
        routePoints =
            coords.map((coord) => LatLng(coord[1], coord[0])).toList();
        final props = data['features'][0]['properties']['segments'][0];
        totalDistance = props['distance'] / 1000;
        totalDuration = props['duration'] / 60;
        markers.removeLast();
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: destination,
            child:
                const Icon(Icons.location_pin, color: Colors.red, size: 40.0),
          ),
        );
      });
    } else {
      print('Failed to fetch route');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor:
            const Color.fromRGBO(247, 247, 246, 1), // Background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent for the gradient look
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Replace with your image URL
                  ),
                  SizedBox(height: 10),
                  Text(
                    username.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            _ExpandableMenu(
              icon: Icons.person,
              title: "User Profile",
              children: [
                ListTile(
                  title: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.black54),
                  ),
                  leading:
                      const Icon(Icons.settings_rounded, color: Colors.black54),
                  onTap: () {
                    // Handle Settings tap
                  },
                ),
                ListTile(
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(color: Color.fromARGB(136, 161, 4, 4)),
                  ),
                  leading: const Icon(Icons.logout_rounded,
                      color: Color.fromARGB(136, 161, 4, 4)),
                  onTap: () async {
                    await _authService.logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    // Handle Sign Out tap
                  },
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    initialZoom: _currentZoom,
                    // onTap: (tapPosition, point) => _addDestinationMarker(point),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          strokeWidth: 4.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
                SafeArea(
                  child: Stack(
                    children: [
                      DraggableScrollableSheet(
                        initialChildSize: 0.1,
                        minChildSize: 0.1,
                        maxChildSize: 0.9,
                        builder: (context, scrollController) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 238, 237),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      width: 40,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),

                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: "Search Maps",
                                      prefixIcon:
                                          const Icon(Icons.search_rounded),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Featured Item
                                  _buildFeaturedItem(context),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Others",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 300,
                                    child: ListView.builder(
                                        itemCount: robots.length,
                                        itemBuilder: (context, index) {
                                          RobotModel _robot = robots[index];
                                          return Dismissible(
                                            key: Key(_robot.id.toString()),
                                            background: Container(
                                              color: Colors.red,
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            confirmDismiss: (direction) async {
                                              return await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Confirm Delete"),
                                                    content: Text(
                                                        "Would you like to delete Robot ${_robot.name}?"),
                                                    actions: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red),
                                                        child: const Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .grey),
                                                        child: const Text(
                                                            "Close",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            onDismissed: (direction) async {
                                              await _robotSrvice.DeleteRobot(
                                                  _robot.id);
                                              setState(() {
                                                robots.removeAt(index);
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    " Bike Deleted With Sucess",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  action: SnackBarAction(
                                                    label: "Close",
                                                    textColor: Colors.yellow,
                                                    onPressed: () {
                                                      print(
                                                          "Undo action clicked!");
                                                    },
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 3),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              elevation: 4,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ListTile(
                                                leading: Transform.scale(
                                                    scale: 1.2,
                                                    child: Text(
                                                        _robot.id.toString())),
                                                title: Text(
                                                  "${_robot.name}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  "Battery " +
                                                      _robot.battery.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        UpdateEtat(_robot);
                                                      },
                                                      icon: Icon(
                                                        _robot.etat == true
                                                            ? Icons.lock
                                                            : Icons.lock_open,
                                                        color:
                                                            _robot.etat == true
                                                                ? Colors.blue
                                                                : Colors.grey,
                                                      ),
                                                    ),
                                                    // IconButton(
                                                    //   onPressed: () {
                                                    //     // Navigator.push(
                                                    //     //     context,
                                                    //     //     MaterialPageRoute(
                                                    //     //         builder: (context) =>
                                                    //     //             TrackBike(
                                                    //     //                 bike:
                                                    //     //                     _BikeModel)));
                                                    //   },
                                                    //   icon: const Icon(
                                                    //     Icons.info,
                                                    //     color:
                                                    //         Colors.blueAccent,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  // Other Items
                                  // _buildOtherItem(
                                  //     "Robot A", "350 m away, Sokra"),
                                  // _buildOtherItem(
                                  //     "Robot B", "400 m away, Charguia 2"),
                                  // _buildOtherItem(
                                  //     "Robot C", "628 m away, Airport"),
                                  // _buildOtherItem(
                                  //     "Robot B", "972 m away, Manar"),
                                  const SizedBox(height: 60),

                                  // Center(
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       print('help');
                                  //     },
                                  //     child: const Text(
                                  //       "Help",
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //         color: Colors.grey,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Your stack children
                    ],
                  ),
                ),

                if (totalDistance != null && totalDuration != null)
                  Positioned(
                    top: 40,
                    left: 70,
                    right: 70,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Distance: ${totalDistance!.toStringAsFixed(2)} KM',
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Estimated time: ${totalDuration!.toStringAsFixed(2)} minutes',
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                //--------------------------------------------
                Positioned(
                  top: 90,
                  right: 20,
                  bottom: 50,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RequestPage(),
                            ),
                          );
                        },
                        mini: true,
                        child: const Icon(Icons.bookmark_add_rounded),
                      ),
                    ],
                  ),
                ),

                //---------------------------------

                Positioned(
                  top: 40,
                  right: 20,
                  bottom: 50,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          if (currentLocation != null) {
                            mapController.move(
                              LatLng(currentLocation!.latitude!,
                                  currentLocation!.longitude!),
                              _currentZoom,
                            );
                          }
                        },
                        mini: true,
                        child: const Icon(Icons.my_location),
                      ),
                    ],
                  ),
                ),

                //---------------------------------------
                Positioned(
                    top: 40,
                    left: 20,
                    bottom: 50,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Icon(Icons.space_dashboard_rounded),
                        ),
                      ],
                    ))
                //---------------------------------
              ],
            ),
    );
  }
}

Widget _buildFeaturedItem(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.adb_rounded, color: Colors.white),
      ),
      title: const Text(
        "Add a Robot",
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.add, color: Colors.green),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRobot(),
            ),
          );
        },
      ),
    ),
  );
}

Widget _buildOtherItem(String title, String subtitle) {
  return ListTile(
    leading: const Icon(Icons.search, color: Colors.grey),
    title: Text(title),
    subtitle: Text(subtitle),
    onTap: () {
      // Handle tap action
    },
  );
}
