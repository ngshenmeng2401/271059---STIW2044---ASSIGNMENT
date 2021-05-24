import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:little_cake_story/service/geolocator_service.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();

  Position currentLocation;

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async{
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}