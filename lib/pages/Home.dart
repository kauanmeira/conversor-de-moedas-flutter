import 'package:conversor_moeda/main.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('\$ Conversor de moedas \$'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text('Carregando Dados...',
                    style: TextStyle(color: Colors.amber, fontSize: 25.0)),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Erro ao carregar dados :( )',
                      style: TextStyle(color: Colors.red, fontSize: 25.0)),
                );
              } else {
                return Container(
                  color: Colors.green,
                );
              }
          }
        },
      ),
    );
  }
}
