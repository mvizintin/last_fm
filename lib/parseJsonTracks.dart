import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

// ignore: non_constant_identifier_names
Future<String> Parser() async {
  String? apiKey = dotenv.env["API_KEY"];
  var url = Uri.parse(
      'http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=$apiKey&format=json');
  var response = await http.get(url);
  return response.body;
}

class ParseJsonTracks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Parser(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData && snapshot.data != "no data") {
          final jsonData = snapshot.data;
          final parsedJson = jsonDecode(jsonData!);
          final tracksList = parsedJson["tracks"]["track"];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: Center(child: Text("Top Tracks")),
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(tracksList[index]["name"]),
                              subtitle: Column(
                                children: [
                                  Text("Artist: " +
                                      tracksList[index]["artist"]["name"]),
                                  Text("Listeners: " +
                                      tracksList[index]["listeners"]),
                                  Text("Play count: " +
                                      tracksList[index]["playcount"])
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: Center(child: Text("Top Artists")),
              //toolbarHeight: 88,
            ),
            body: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [Center(child: CircularProgressIndicator())]),
            ),
          );
        }
        return Text("greška");
      },
      initialData: "no data",
    );
  }
}
