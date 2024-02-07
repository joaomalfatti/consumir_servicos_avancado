import 'package:consumo_servico_avancado/Post.dart';
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

  String _urlBase = "https://jsonplaceholder.typicode.com";


  Future<List<Post>> _recuperarPostagens(){


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviços avançados"),
      ),
      body: FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder: (context, snapshot){

          //Verificar se deu certo ou não.
          switch( snapshot.connectionState ){
          //Que defini o estado da conexão e null
            case ConnectionState.none :
            //Que aguarda a comunicação com API
            case ConnectionState.waiting :
              print("Conexao waiting");
              break;
          //Sem necessidade
            case ConnectionState.active :
            //Apenas que carregue a conexão
            case ConnectionState.done :
              print("Conexao done");
              if ( snapshot.hasError ){
              }else {

              };
              break;
          }
          return Center(
              child: Text( resultado )
          );
        },
      ),
    );
  }
}
