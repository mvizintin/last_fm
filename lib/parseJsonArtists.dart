import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

//import './topArtists.dart';

// ignore: non_constant_identifier_names
Future<String> Parser() async {
  String? apiKey = dotenv.env["API_KEY"];
  var url = Uri.parse(
      'http://ws.audioscrobbler.com/2.0/?method=chart.gettopartists&api_key=' +
          apiKey.toString() +
          '&format=json');
  var response = await http.get(url);

  //return Text("hello");

  //TopArtists artistsList = json.decode(response.body).cast<TopArtists>();

  return response.body;
}

class ParseJsonArtists extends StatelessWidget {
  //final TopArtists artistsList = Parser() as TopArtists;

  @override
  Widget build(BuildContext context) {
    // return Text("testing");

    return FutureBuilder<String>(
      future: Parser(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData && snapshot.data != "no data") {
          final jsonData = snapshot.data;
          final parsedJson = jsonDecode(jsonData!);
          final artistsList = parsedJson["artists"]["artist"];

          print(artistsList[0]["name"]);

          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Top artists",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(artistsList[index]["name"]),
                            subtitle: Column(
                              children: [
                                Text("Listeners: " +
                                    artistsList[index]["listeners"]),
                                Text("Play count: " +
                                    artistsList[index]["playcount"])
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      }
                      //return Text(artistsList[index]["name"]);
                      //return Text("error");
                      ),
                )
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
        return Text("greška");
      },
      initialData: "no data",
    );
  }
}
