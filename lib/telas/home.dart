import 'package:flutter/material.dart';
import 'package:flutter_preco_bitcoin/telas/homeBloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    PrecoBitcoinBloc blocBtc = PrecoBitcoinBloc();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.all(30),
                child: StreamBuilder<String>(
                  stream: blocBtc.precoBitcoinStream,
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
              RaisedButton(
                onPressed: blocBtc.recuperarPreco,
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(15),
                child: Text(
                  "Atualizar",
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
