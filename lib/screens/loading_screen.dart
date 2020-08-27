import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clima/location.dart';
import 'package:http/http.dart' as http;
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Location place= Location();
  double lat;
  double lon;
  void initState() {
    super.initState();
    getLocation();

  }
  void getLocation() async{
    await place.getCurrentLocation();
    lat=place.latitude;
    lon=place.longitude;
    getWeather();
  }
  void getWeather() async{
    http.Response weatherResponse= await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=95c19c4cd8800380d725ac767a7e8592');
    String data=weatherResponse.body;
      var temp1=jsonDecode(data)['main']['temp'];
    var city=jsonDecode(data)['name'];
    var desc=jsonDecode(data)['weather'][0]['description'];
    print(weatherResponse.statusCode);
    print(temp1);
    print(city);
    print(desc);
  }
  void deactivate(){
    super.deactivate();
    print("Thank you");
  }
  Widget build(BuildContext context) {

    return Scaffold();
  }
}
