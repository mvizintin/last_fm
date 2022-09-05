import 'package:flutter/material.dart';
import 'package:last_fm/parseJsonArtists.dart';
import 'package:last_fm/parseJsonTracks.dart';
import 'package:last_fm/search.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Text("testing");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(child: Text("LastFM")),
          //toolbarHeight: 88,
        ),
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[200],
                padding: EdgeInsets.all(20),
              ),
              child: Text("Top Artists"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParseJsonArtists()),
                );
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[300],
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParseJsonTracks()),
                );
              },
              child: Text("Top Tracks"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[200],
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              },
              child: Text("Search"),
            )
          ]),
        ),
      ),
    );
  }
}
