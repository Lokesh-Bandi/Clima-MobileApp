import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networkdata.dart';
import 'package:clima/screens/location_screen.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  void getCityLocation(String city) async{
    NetworkHelper networkHelper= NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=95c19c4cd8800380d725ac767a7e8592&units=metric');
    var weatherData= await networkHelper.getData();
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return LocationScreen(
          localWeather:weatherData,
          city: city
      );
    }),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/neat-blue-background-1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                   color: Colors.black
                  ),
                  decoration: kInputDecoration,
                  onChanged: (value){
                    cityName=value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  getCityLocation(cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
