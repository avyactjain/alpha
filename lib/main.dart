
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'consts.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Alpha Finance'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _walletAddress;

  void _checkBalance() async {
    String abi;
    Web3Client ethClient;
    Client httpClient;

    ethClient = Web3Client(rpcUrl, httpClient);

    abi = jsonEncode(alphaAbi);
    print(_walletAddress);
    var alphaTokenInst = DeployedContract(
      ContractAbi.fromJson(abi, "AlphaToken"),
      EthereumAddress.fromHex(alphaTokenAddress),
    );

    ContractFunction getBalanceAmount = alphaTokenInst.function('balanceOf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Wallet Address"),
                onChanged: (value) {
                  _walletAddress = value;
                },
              ),
            )
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkBalance,
        tooltip: 'Increment',
        child: Icon(Icons.done),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
