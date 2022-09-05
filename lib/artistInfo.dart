import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'dart:math';

// ignore: non_constant_identifier_names
Future<String> ParseInfo(String mbid) async {
  String? apiKey = dotenv.env["API_KEY"];
  var url = Uri.parse(
      'http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&mbid=$mbid&api_key=$apiKey&format=json');
  var response = await http.get(url);

  return response.body;
}

class ArtistInfo extends StatelessWidget {
  final String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    print(searchTerm);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text("LastFM")),
        //toolbarHeight: 88,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String>(
              future: ParseInfo(searchTerm),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData && snapshot.data != "no data") {
                  final jsonData = snapshot.data;
                  final parsedJson = jsonDecode(jsonData!);
                  final artistsList =
                      parsedJson["results"]["artistmatches"]["artist"];

                  print(parsedJson["results"]["opensearch:totalResults"]);
                  print(parsedJson["results"]["opensearch:itemsPerPage"]);

                  return Expanded(
                    child: ListView.builder(
                        itemCount: min(
                            int.parse(parsedJson["results"]
                                ["opensearch:totalResults"]),
                            int.parse(parsedJson["results"]
                                ["opensearch:itemsPerPage"])),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(artistsList[index]["name"]),
                              subtitle: Column(
                                children: [
                                  Text("Listeners: " +
                                      artistsList[index]["listeners"]),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ()/*ArtistInfo()*/),
                                );*/
                              },
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
                return Text("greška");
              },
              initialData: "no data",
            ),
          ],
        ),
      ),
    );
/*
    return FutureBuilder<String>(
      future: Parser(searchTerm),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData && snapshot.data != "no data") {
          final jsonData = snapshot.data;
          final parsedJson = jsonDecode(jsonData!);
          final artistsList = parsedJson["results"]["artistmatches"]["artist"];

          print(parsedJson["results"]["opensearch:totalResults"]);
          print(parsedJson["results"]["opensearch:itemsPerPage"]);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: Center(child: Text(searchTerm)),
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: min(
                            int.parse(parsedJson["results"]
                                ["opensearch:totalResults"]),
                            int.parse(parsedJson["results"]
                                ["opensearch:itemsPerPage"])),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(artistsList[index]["name"]),
                              subtitle: Column(
                                children: [
                                  Text("Listeners: " +
                                      artistsList[index]["listeners"]),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ()/*ArtistInfo()*/),
                                );*/
                              },
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
    );*/
  }
}
