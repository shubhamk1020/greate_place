import 'package:flutter/material.dart';
import 'package:greate_place/Screen/add_place_screen.dart';
import 'package:greate_place/Screen/place_details_screen.dart';
import './Screen/places_list_screen.dart';
import './Providers/great_place.dart';
import 'package:provider/provider.dart';

void main() =>
  runApp( MyApp());


class MyApp extends StatelessWidget {
 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: GreatPalce(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       title: 'Greate Place',
       theme: ThemeData(primaryColor: Colors.indigo,
       accentColor: Colors.amber
       ),
       home: PlaceListScreen(),
       routes: {
        AddPlaceScreen.routeName : (ctx) => AddPlaceScreen(),
        PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
       },
      ),
    );
  }
}
