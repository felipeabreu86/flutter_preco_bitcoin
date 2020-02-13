import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PrecoBitcoinBloc {
  String _preco = "0.0";
  String get preco => _preco;

  // Variável final que inicializa o StreamController
  final _blocController = StreamController<String>();

  // Retorna a Stream para quem deseja observar seus eventos
  Stream<String> get precoBitcoinStream => _blocController.stream;

  void recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> retorno = json.decode(response.body);
      _preco = retorno["BRL"]["buy"].toString();
      _blocController.sink.add(preco);
    } else {
      _blocController.sink.add("0.0");
    }
  }

  // Fecha a Stream
  fecharStream() {
    _blocController.close();
  }
}
