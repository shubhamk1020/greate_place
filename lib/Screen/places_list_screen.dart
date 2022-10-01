import 'package:flutter/material.dart';
import 'package:greate_place/Screen/place_details_screen.dart';
import '../Providers/great_place.dart';
import 'package:provider/provider.dart';
import '../Screen/add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 20),
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPalce>(context, listen: false)
              .fetchAndsetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPalce>(
                  child: const Center(
                      child: Text('Got no places yet, start adding some!')),
                  builder: (ctx, greatPlace, ch) => greatPlace.items.length <= 0
                      ? ch
                      : ListView.builder(
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlace.items[i].image)),
                            title: Text(greatPlace.items[i].title),
                            subtitle:
                                Text(greatPlace.items[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatPlace.items[i].id);
                            },
                          ),
                          itemCount: greatPlace.items.length,
                        ),
                ),
        ));
  }
}
