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
    String url = "https://blockchain.info/ticker";

    http.Response response = await http.get(Uri.parse(url));
    return json.decode( response. body );

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context, snapshot){


        String resultado;

        //Verificar se deu certo ou não.
        switch( snapshot.connectionState ){
             //Que defini o estado da conexão e null
          case ConnectionState.none :
             //Que aguarda a comunicação com API
          case ConnectionState.waiting :
            print("Conexao waiting");
            resultado = "Carregando...";
            break;
             //Sem necessidade
          case ConnectionState.active :
             //Sem necessidade
          case ConnectionState.done :
          print("Conexao done");
          if ( snapshot.hasError ){
            resultado = "Erro ao carregar os dados";
          }else {
            double valor = snapshot.data! ["BRL"]["buy"];
            resultado = "Preço do bitcoin: ${valor.toString()}";
          };
          break;
        }
        return Center(
          child: Text( resultado )
        );
      },
    );
  }
}
