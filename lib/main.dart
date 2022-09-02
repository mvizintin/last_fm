import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'parseJsonArtists.dart';
import 'parseJsonTracks.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.red,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("LastFM")),
          //toolbarHeight: 88,
        ),
        body: ParseJsonTracks(),
      ),
    );
  }
}
