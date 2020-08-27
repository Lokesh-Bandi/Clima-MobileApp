import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'package:clima/location.dart';
import 'package:clima/services/networkdata.dart';
import 'package:geolocator/geolocator.dart';
class LocationScreen extends StatefulWidget {
  final localWeather;
  final city;
  LocationScreen({this.localWeather,this.city});
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  int condition;
  String cityName;
  String conditionMsg;
  String descMsg;
  WeatherModel weatherModel=WeatherModel();
  void initState(){
    super.initState();
    updateUI(widget.localWeather,widget.city);
  }
  void updateUI(dynamic data,String city){
    setState(() {
      if(data==null){
        temperature=0;
        conditionMsg="Error";
        descMsg="Unable to fetch the weather data";
        return;
      }
      var temp1=data['main']['temp'];
      temperature=temp1.toInt();
      condition=data['weather'][0]['id'];
      cityName=city;
      conditionMsg=weatherModel.getWeatherIcon(condition);
      descMsg=weatherModel.getMessage(temperature)+" " +cityName;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/climate.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      setState(() async{
                      Location place= Location();
                      await place.getCurrentLocation();
                      List<Placemark> placeMark = await Geolocator().placemarkFromCoordinates(place.latitude, place.longitude);
                      Placemark city=placeMark[0];
                      NetworkHelper networkHelper= NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${place.latitude}&lon=${place.longitude}&appid=95c19c4cd8800380d725ac767a7e8592&units=metric');
                      var weatherData= await networkHelper.getData();
                      updateUI(weatherData,city.locality);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder :(context){
                        return CityScreen();
                      }),
                      );
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      conditionMsg,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  descMsg,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
