import 'package:conversor_moeda/main.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double dolar;
    double euro;

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
                dolar = snapshot.data?['results']['currencies']['USD']['buy'];
                euro = snapshot.data?['results']['currencies']['EUR']['buy'];

                return const SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.amber),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Reais',
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: 'R\$'),
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Dólares',
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: 'US\$'),
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Euros',
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: '€'),
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        )
                      ]),
                );
              }
          }
        },
      ),
    );
  }
}
