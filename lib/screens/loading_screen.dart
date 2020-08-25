import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }
  void getLocation() async{
   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
   Placemark place=placemark[0];
   print(place.locality+" "+place.administrativeArea+" "+place.postalCode+" "+place.name+" "+place.country);
  }
  void deactivate(){
    super.deactivate();
    print("Thank you");
  }
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
