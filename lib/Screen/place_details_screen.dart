import 'dart:html';

import 'package:flutter/material.dart';
import 'package:greate_place/Providers/great_place.dart';
import 'package:greate_place/Screen/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place_details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectePlace =
        Provider.of<GreatPalce>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(title: Text(selectePlace.title)),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectePlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          selectePlace.location.address,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                      initialLoaction: selectePlace.location,
                      isSelection: false,
                    )));
          },
          child: Text(
            'view on Map',
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ]),
    );
  }
}
