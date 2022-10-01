import 'dart:io';
import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String title;
  final PlaceLoaction location;
  final File image;

  Place({
    this.id,
    this.title,
    this.location,
    this.image,
  });
}

class PlaceLoaction {
  final double latitude;
  final double logitude;
  final String address;

 const PlaceLoaction({this.latitude, this.logitude, this.address});
}
