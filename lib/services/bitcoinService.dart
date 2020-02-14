import 'package:flutter_preco_bitcoin/util/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinService {
  /// Consulta o preço do Bitcoin na API da Blockchain dada a moeda
  static Future<String> recuperarPreco(String moeda, String oferta) async {
    http.Response response = await http.get(Url.BitcoinTicker);
    String preco = "0.0";
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> retorno = json.decode(response.body);
        var itensMoeda = retorno[moeda];
        var precoOferta = itensMoeda[oferta];
        var simbolo = itensMoeda["symbol"];
        preco = "$simbolo $precoOferta";
      } catch (e) {
        print("Erro: " + e.toString());
      }
    }
    return preco;
  }
}
