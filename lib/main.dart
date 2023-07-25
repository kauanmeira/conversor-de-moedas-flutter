import 'package:conversor_moeda/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Importe esta linha para poder usar o json.decode() mais tarde

const request =
    "https://v6.exchangerate-api.com/v6/24a7aca965dfe72e909826b7/latest/USD";

void main() async {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}
