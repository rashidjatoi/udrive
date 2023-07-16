import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:udrive/constants/colors.dart';
import 'package:udrive/constants/styles.dart';
import 'package:udrive/helpers/helpers_methods.dart';
import 'package:udrive/utils/utils.dart';
import 'package:udrive/widgets/brand_divider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = 'mainscreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.4181481, 68.362593),
    zoom: 14.4746,
  );

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late GoogleMapController mapController; // Added this line

  double searchSheetHeight = (Platform.isIOS) ? 300 : 275;

  // var geoLocator = GeoLocator();

  // late Position currentPosition;
  // void setPositionLocator() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   currentPosition = position;

  //   LatLng psg = LatLng(position.latitude, position.longitude);
  //   CameraPosition cp = CameraPosition(target: psg, zoom: 14.0);
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  // }

  late Position currentPostion;

  String pickupAddress = 'Address';

  void getUserLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isDenied) {
      Utils.showSnackBar(message: "Permission Denied", context: context);
    } else {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      currentPostion = position;
      setState(() {});
      LatLng pos = LatLng(position.latitude, position.longitude);
      CameraPosition cp = CameraPosition(
        target: pos,
        zoom: 18.4746,
      );
      await mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
      String address =
          await HelperMethods.findCordinateMethod(position, context);
      pickupAddress = address;
      debugPrint(address);
      debugPrint(position.toString());
    }
  }

  // Set<Marker> _markers = {};

  double mapBottomPadding = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // appBar: AppBar(
      //   title: const Text("Main Page"),
      // ),

      drawer: Container(
        width: 250,
        color: Colors.white,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Container(
                height: 160,
                color: Colors.white,
                child: DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/user_icon.png",
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(width: 15),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rashid",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Brand-Bold",
                              ),
                            ),
                            SizedBox(height: 5),
                            Text("View Profile")
                          ],
                        )
                      ],
                    )),
              ),
              const BrandDivider(),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.card_giftcard_outlined),
                title: Text(
                  "Free Rides",
                  style: kDrawerItemStyle,
                ),
              ),
              const ListTile(
                leading: Icon(IconlyLight.wallet),
                title: Text(
                  "Payments",
                  style: kDrawerItemStyle,
                ),
              ),
              const ListTile(
                leading: Icon(IconlyLight.activity),
                title: Text(
                  "Ride History",
                  style: kDrawerItemStyle,
                ),
              ),
              const ListTile(
                leading: Icon(IconlyLight.call),
                title: Text(
                  "Support",
                  style: kDrawerItemStyle,
                ),
              ),
              const ListTile(
                leading: Icon(IconlyLight.info_circle),
                title: Text(
                  "About",
                  style: kDrawerItemStyle,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            // myLocationEnabled: true,

            zoomControlsEnabled: true,
            // markers: _markers  ,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              // _controller.complete(controller);
              mapController = controller;
              setState(() {
                mapBottomPadding = 300;

                //             _markers.add(
                //   Marker(
                //     markerId: MarkerId('currentLocation'),
                //     position: LatLng(currentPostion.latitude, currentPostion.longitude),
                //     icon: BitmapDescriptor.defaultMarker, // Customize the icon as needed
                //     infoWindow: InfoWindow(title: 'My Location'), // Customize the info window as needed
                //   ),
                // );
              });

              // setPositionLocator();
            },
          ),

          // MenuButton
          Positioned(
            top: 44,
            left: 20,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(66, 5, 5, 5),
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      )
                    ]),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          // Search Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                    offset: Offset(0.7, 0.7),
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      "Nice to see you!",
                      style: TextStyle(fontSize: 10),
                    ),
                    const Text(
                      "Where are you going?",
                      style: TextStyle(fontSize: 18, fontFamily: "Brand-Bold"),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7))
                          ]),
                      padding: const EdgeInsets.all(12.0),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.blueAccent),
                          SizedBox(width: 10),
                          Text("Search Destination")
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Icon(IconlyLight.home,
                            color: BrandColors.colorDimText),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pickupAddress),
                            const SizedBox(height: 3),
                            const Text(
                              "Your residential address",
                              style: TextStyle(
                                fontSize: 11,
                                color: BrandColors.colorDimText,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const BrandDivider(),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        getUserLocation();
                      },
                      child: const Row(
                        children: [
                          Icon(IconlyLight.work,
                              color: BrandColors.colorDimText),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Work"),
                              SizedBox(height: 3),
                              Text(
                                "Your Office address",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
