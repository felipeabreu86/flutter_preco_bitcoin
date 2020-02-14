import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinService {
  /// Consulta o preço do Bitcoin na API da Blockchain dada a moeda
  static Future<String> recuperarPreco(String moeda) async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    String preco = "0.0";
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> retorno = json.decode(response.body);
        preco = retorno[moeda]["buy"].toString();
      } catch (e) {
        print("Erro: " + e.toString());
      }
    }
    return preco;
  }
}
