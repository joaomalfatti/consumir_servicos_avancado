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
  //Url que o app vai consumir
  String _urlBase = "https://jsonplaceholder.typicode.com";

  //Future que vai fazer as coisas completas
  Future<List<Post>> _recuperarPostagens() async {

    http.Response response = await http.get(Uri.parse( _urlBase + "/posts"));
    var dadosJson = jsonDecode( response.body );

    List<Post> postagens = [];

    for ( var post in dadosJson ) {
      print("post: " + post ["title"] );
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add( p );
    }
    return postagens;

    //print(postagens.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviços avançados"),
      ),
      body: FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            // Retorna um indicador de progresso enquanto os dados estão sendo carregados
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                // Retorna uma mensagem de erro caso ocorra um erro ao carregar os dados
                return Center(
                  child: Text("Erro ao carregar os dados"),
                );
              } else {
                print("lista: carregou!! ");
                // Retorna a lista de postagens se os dados foram carregados com sucesso
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    List<Post> lista = snapshot.data ?? [];
                    Post post = lista[index];

                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.id.toString()),
                    );
                  },
                );
              }
          }
          // Retorna um widget vazio como último recurso
          return Container();
        },
      ),
    );
  }

}
