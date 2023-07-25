import 'package:conversor_moeda/main.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  double dolar = 0.0;
  double euro = 0.0;

  @override
  Widget build(BuildContext context) {
    final realController = TextEditingController();
    final euroController = TextEditingController();
    final dolarController = TextEditingController();

    void _realChanged(String text) {
      double real = double.parse(text);
      dolarController.text = (real / dolar).toStringAsFixed(2);
      euroController.text = (real / euro).toStringAsFixed(2);
    }

    void _dolarChanged(String text) {
      double dolar = double.parse(text);
      euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
      realController.text = (dolar * this.dolar).toStringAsFixed(2);
    }

    void _euroChanged(String text) {
      double euro = double.parse(text);
      realController.text = (euro * this.euro).toStringAsFixed(2);
      dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    }

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

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.amber),
                        buildTextField(
                            'Reais', 'R\$', realController, _realChanged),
                        Divider(),
                        buildTextField(
                            'Dólares', 'US\$', dolarController, _dolarChanged),
                        Divider(),
                        buildTextField(
                            'Euros', '€', euroController, _euroChanged)
                      ]),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController c,
    void Function(String)? f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
