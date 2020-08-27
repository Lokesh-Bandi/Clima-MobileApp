import 'package:clima/services/networkdata.dart';
import 'package:flutter/material.dart';
import 'package:clima/location.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location place= Location();
  void initState() {
    super.initState();
    getLocationWeather();

  }
  void getLocationWeather() async{
    await place.getCurrentLocation();
    List<Placemark> placeMark = await Geolocator().placemarkFromCoordinates(place.latitude, place.longitude);
    Placemark city=placeMark[0];
    NetworkHelper networkHelper= NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${place.latitude}&lon=${place.longitude}&appid=95c19c4cd8800380d725ac767a7e8592&units=metric');
    var weatherData= await networkHelper.getData();
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return LocationScreen(
        localWeather:weatherData,
        city: city.locality
      );
    }));
    }
  void deactivate(){
    super.deactivate();
    print("Thank you");
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: SpinKitFadingFour(
          color: Colors.white,
          size: 50.0,
        ),
    );
  }
}
