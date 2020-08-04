import 'dart:typed_data';

import 'package:app_flat/pages/Map/pin_data.dart';
import 'package:app_flat/pages/Map/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_flat/pages/Map/MapIcon.dart';

class MyMap extends StatefulWidget {
  final GeoPoint hotelPosition;

  const MyMap({@required this.hotelPosition});
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController _controller;

  Position position;

  Widget _child = Center(
    child: CircularProgressIndicator(),
  );
  Uint8List _sourceIcon;
  Uint8List _hotelIcon;

  Future<void> _setSourceIcon() async {
    _sourceIcon = await MarkerIconMakerMixin.getMakerIconFromAssets(
        'assets/pin.png', 100);

    _hotelIcon = await MarkerIconMakerMixin.getMakerIconFromAssets(
        'assets/hotel-icon.jpg', 180);
    getPermission();
  }

  Future<void> getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    // if (permission == PermissionStatus.denied) {
    //   await PermissionHandler()
    //       .requestPermissions([PermissionGroup.locationAlways]);
    // }

    var geolocator = Geolocator();

    // GeolocationStatus geolocationStatus =
    //     await geolocator.checkGeolocationPermissionStatus();
    // print("geolocationStatus " + geolocationStatus.toString());
    switch (permission) {
      // case PermissionStatus.denied:
      //   showToast('Access denied');
      //   break;
      // case PermissionStatus.disabled:
      //   showToast('Disabled');
      //   break;
      // case PermissionStatus.restricted:
      //   showToast('restricted');
      //   break;
      // case PermissionStatus.unknown:
      //   showToast('Unknown');
      //   break;
      case PermissionStatus.granted:
        {
          showToast('Accesss Granted');
          _getCurrentLocation();
        }
        break;

      default:
        if (mounted) {
          setState(() {
            print("in default");
            _child = _mapWidget();
          });
        }
    }
  }

  void _getCurrentLocation() async {
    print("top");
    Position res = await Geolocator().getCurrentPosition();
    print("post res");

    if (mounted)
      setState(() {
        print("in setState");

        position = res;
        _child = _mapWidget();
      });
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(value);
  }

  Set<Marker> _createMarkerWithUserPos() {
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.fromBytes(_sourceIcon),
          onTap: () {}),
      Marker(
          markerId: MarkerId('hotel'),
          position: LatLng(
              widget.hotelPosition.latitude, widget.hotelPosition.longitude),
          icon: BitmapDescriptor.fromBytes(_hotelIcon),
          onTap: () {}),
    ].toSet();
  }

  Set<Marker> _createMarkerWithoutUserPos() {
    return <Marker>[
      Marker(
          markerId: MarkerId('hotel2'),
          position: LatLng(
              widget.hotelPosition.latitude, widget.hotelPosition.longitude),
          icon: BitmapDescriptor.fromBytes(_hotelIcon),
          onTap: () {}),
    ].toSet();
  }

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    _setSourceIcon();
    super.initState();
  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: position != null
          ? _createMarkerWithUserPos()
          : _createMarkerWithoutUserPos(),
      initialCameraPosition: CameraPosition(
          target: LatLng(
              widget.hotelPosition.latitude, widget.hotelPosition.longitude),
          zoom: 15.0),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        //_setStyle(controller);
      },
      tiltGesturesEnabled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _child);
  }

  // Widget _buildAvatar() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 10),
  //     width: 50,
  //     height: 50,
  //     child: ClipOval(
  //       child: Image.asset(
  //         _currentPinData.avatarPath,
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildLocationInfo() {
  //   return Expanded(
  //     child: Container(
  //       margin: EdgeInsets.only(left: 20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             _currentPinData.locationName,
  //             style: CustomAppTheme().data.textTheme.subtitle,
  //           ),
  //           Text(
  //             'Latitude : ${_currentPinData.location.latitude}',
  //             style: CustomAppTheme().data.textTheme.display1,
  //           ),
  //           Text(
  //             'Longitude : ${_currentPinData.location.longitude}',
  //             style: CustomAppTheme().data.textTheme.display1,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildMarkerType() {
  //   return Padding(
  //     padding: EdgeInsets.all(15),
  //     child: Image.asset(
  //       _currentPinData.pinPath,
  //       width: 50,
  //       height: 50,
  //     ),
  //   );
  // }
}
