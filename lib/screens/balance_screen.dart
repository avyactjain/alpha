import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  final String alphaBalance;
  final String alphaStake;

  BalanceScreen({@required this.alphaBalance, @required this.alphaStake});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alpha Balance & Stake"),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.poll_outlined,
                  size: 40,
                ),
                title: Text(
                  this.alphaStake,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  "Staked Alpha",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.monetization_on_rounded,
                  size: 40,
                ),
                title: Text(
                  this.alphaBalance,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  "Alpha Balance",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          )),
    );
  }
}
