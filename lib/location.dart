import 'package:geolocator/geolocator.dart';
class Location{
  double latitude,longitude;
  Position position;
  Future<void> getCurrentLocation() async{
    try {
     position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude=position.latitude;
      longitude=position.longitude;
    }
    catch(e){
      print(e);
    }
  }

}