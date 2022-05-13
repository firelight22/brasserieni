import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<http.Response>(
        future: http.get(Uri.parse("https://api.punkapi.com/v2/beers")),
        builder: (context, snapshot) {
          if(snapshot.hasData){
                  //si la data est null alors return ""
            List<dynamic> listBeers = jsonDecode(snapshot.data?.body ?? "");
            return ListView.separated(
                itemBuilder: (_, index) => ListTile(
                  leading: Image.network(listBeers[index]["image_url"]),
                  title: Text(listBeers[index]["name"]),
                ),
                separatorBuilder: (_,index) => const Divider(),
                itemCount: listBeers.length);
          }else return const CircularProgressIndicator();

        }
      ),
    );
  }
}
