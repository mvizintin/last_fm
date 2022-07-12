import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './topArtists.dart';

// ignore: non_constant_identifier_names
Future<TopArtists> Parser() async {
  String? apiKey = dotenv.env["API_KEY"];
  var url = Uri.parse(
      'http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=' +
          apiKey.toString() +
          '&format=json');
  var response = await http.get(url);

  return json.decode(response.body);
}

class ParseJsonArtists extends StatelessWidget {
  final TopArtists artistsList = Parser() as TopArtists;

  @override
  Widget build(BuildContext context) {
    //return Text(Parser());
    Future<TopArtists> list = Parser();

    return FutureBuilder(
      future: list,
      builder: ;
  }
}
