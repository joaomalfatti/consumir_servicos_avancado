import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<Map> _recuperarPreco() async {
    String url = "htpps://blockchain.info/ticker";

    http.Response response = await http.get(Uri.parse(url));
    return json.decode( response. body );

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context, snapshot){
        snapshot.
      },
    );
  }
}
