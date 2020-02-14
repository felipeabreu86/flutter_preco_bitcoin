import 'package:flutter/material.dart';
import 'package:flutter_preco_bitcoin/services/bitcoinService.dart';
import 'package:flutter_preco_bitcoin/telas/homeBloc.dart';
import 'package:flutter_preco_bitcoin/util/constantes.dart';

class Home extends StatefulWidget {
  final PrecoBitcoinBloc blocBtc = PrecoBitcoinBloc();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Utiliza o método do bitcoinService para consultar o preço na API
  Future<String> _recuperarBtcUSD() async {
    return await BitcoinService.recuperarPreco(
        BitcoinMoeda.USD, BitcoinOferta.Buy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logotipo BTC
              Image.asset("images/bitcoin.png"),
              // Recuperar preço BTC em R$ utilizando BLOC
              Padding(
                padding: EdgeInsets.all(30),
                child: StreamBuilder<String>(
                  stream: widget.blocBtc.precoBitcoinStream,
                  initialData: "0.0",
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Erro');
                    } else {
                      return Text(
                        '${snapshot.data}',
                        style: Theme.of(context).textTheme.display1,
                      );
                    }
                  },
                ),
              ),
              // Recuperar preço BTC em $ utilizando Future
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: FutureBuilder<String>(
                  future: _recuperarBtcUSD(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        break;
                      case ConnectionState.done:
                        break;
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active:
                        break;
                    }
                    return Text(
                      "${snapshot.data}",
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                ),
              ),
              // Botão Atualizar
              RaisedButton(
                onPressed: widget.blocBtc.recuperarBtcBRL,
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text(
                  "Atualizar BTC R\$",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
