import 'package:flutter/cupertino.dart';
import '../helpters/location_helper.dart';
import '../helpters/db_helper.dart';
import 'dart:io';
import '../Models/place.dart';

class GreatPalce with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLoaction pickedLocation) async {
    final address = await LocationHelper.getPlaceAdress(
        pickedLocation.latitude, pickedLocation.logitude);
    final updatedLocation = await PlaceLoaction(
        latitude: pickedLocation.latitude,
        logitude: pickedLocation.logitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.logitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndsetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLoaction(
                latitude: item['loc_lat'],
                logitude: item['loc_lng'],
                address: item['address']),
            image: File(
              item['image'],
            )))
        .toList();
    notifyListeners();
  }
}
