import 'package:flutter/material.dart';
import '../Models/place.dart';
import '../Widget/loaction_input.dart';
import '../Providers/great_place.dart';
import 'package:provider/provider.dart';
import '../Widget/image_input.dart';
import 'dart:io';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add_place';

  const AddPlaceScreen({Key key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pikedImages;
  PlaceLoaction _pickedLocation;

  void _selectImage(File pickedImage) {
    _pikedImages = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLoaction(latitude: lat, logitude: lng);
  }

  void _savedPlace() {
    if (_titleController.text.isEmpty || _pikedImages == null || _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPalce>(context, listen: false)
        .addPlace(_titleController.text, _pikedImages, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new place')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  const SizedBox(
                    height: 10,
                  ),
                  LocationInput(_selectPlace),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
              onPressed: _savedPlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Photo'))
        ],
      ),
    );
  }
}
