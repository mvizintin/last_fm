import 'package:flutter/material.dart';

import 'searchQuerry.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey();

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text("LastFM")),
      ),
      body: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Enter artist to search',
                        filled: true),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchQuerry(searchTerm: controller.text)),
                        );
                      },
                      child: Text("Search"))
                ],
              ))
        ]),
      ),
    );
  }
}
