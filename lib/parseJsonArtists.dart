import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

import './topArtists.dart';

// ignore: non_constant_identifier_names
Future<Widget> Parser() async {
  String? apiKey = dotenv.env["API_KEY"];
  var url = Uri.parse(
      'http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=' +
          apiKey.toString() +
          '&format=json');
  var response = await http.get(url);

  //return Text("hello");

  TopArtists artistsList = json.decode(response.body);

  return json.decode(response.body);
}

class ParseJsonArtists extends StatelessWidget {
  //final TopArtists artistsList = Parser() as TopArtists;

  @override
  Widget build(BuildContext context) {
    // return Text("testing");

    return FutureBuilder<Widget>(
        future: Parser(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (true) {
            return Text("returning data");
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
