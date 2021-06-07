import 'package:alpha/screens/balance_screen.dart';
import 'package:alpha/utils/alpha_utils.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';

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
  String _walletAddress;
  final _formKey = GlobalKey<FormState>();

  void _checkBalanceAndStake() async {
    String _balance;
    String _stake;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );

    _stake = await getAlphaStake(walletAddress: _walletAddress);
    _balance = await getAlphaBalance(walletAddress: _walletAddress);

    // print(_stake);
    // print(_balance);

    Navigator.of(context).pop();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BalanceScreen(
          alphaBalance: _balance,
          alphaStake: _stake,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    validator: (String val) {
                      if (_walletAddress == null) {
                        return "Please enter wallet address";
                      }
                      if (!isValidEthereumAddress(_walletAddress)) {
                        return "Wallet address incorrect";
                      } else {
                        return null;
                      }
                    },
                    autovalidate: true,
                    decoration: InputDecoration(hintText: "Wallet Address"),
                    onChanged: (value) {
                      _walletAddress = value;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _checkBalanceAndStake();
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.done),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
