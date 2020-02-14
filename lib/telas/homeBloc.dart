import 'package:flutter_preco_bitcoin/services/bitcoinService.dart';
import 'dart:async';

class PrecoBitcoinBloc {
  // Armazena o preço do bitcoin
  String _preco = "0.0";
  String get preco => _preco;

  // Variável final que inicializa o StreamController
  final _blocController = StreamController<String>();

  // Retorna a Stream para quem deseja observar seus eventos
  Stream<String> get precoBitcoinStream => _blocController.stream;

  // Utiliza o método do bitcoinService para consultar o preço na API
  void recuperarBtcBRL() async {
    _preco = await BitcoinService.recuperarPreco("BRL");
    _blocController.sink.add(_preco);
  }

  // Fecha a Stream
  fecharStream() {
    _blocController.close();
  }
}
