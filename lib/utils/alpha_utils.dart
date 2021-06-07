import 'dart:convert';

import 'package:alpha/utils/consts.dart';
import 'package:web3dart/web3dart.dart';

Future<String> getAlphaStake({String walletAddress}) async {
  String tokenomicsContractJson;

  String result = "";

  try {
    tokenomicsContractJson = jsonEncode(tokenomicsContractAbi);

    var alphaTokenomicsContract = DeployedContract(
      ContractAbi.fromJson(tokenomicsContractJson, "AlphaStaking"),
      EthereumAddress.fromHex(tokenomicsContractAddress),
    );

    ContractFunction getStakeValue =
        alphaTokenomicsContract.function('getStakeValue');

    var queryResult = await ethClient.call(
      contract: alphaTokenomicsContract,
      function: getStakeValue,
      params: [EthereumAddress.fromHex(walletAddress)],
    );

    // print(queryResult[0].toString());
    result = queryResult[0].toString();

    double resultDouble = double.parse(result);
    double resultDivided = resultDouble / 1e18;

    result = resultDivided.toString();

    return result;
  } catch (e) {
    return result;
  }
}

Future<String> getAlphaBalance({String walletAddress}) async {
  String alphaContractJson;

  String result = "";

  try {
    alphaContractJson = jsonEncode(alphaAbi);
    var alphaContract = DeployedContract(
      ContractAbi.fromJson(alphaContractJson, "AlphaStaking"),
      EthereumAddress.fromHex(alphaTokenAddress),
    );

    ContractFunction getStakeValue = alphaContract.function('balanceOf');

    var queryResult = await ethClient.call(
      contract: alphaContract,
      function: getStakeValue,
      params: [EthereumAddress.fromHex(walletAddress)],
    );

    // print(queryResult[0].toString());
    result = queryResult[0].toString();

    double resultDouble = double.parse(result);
    double resultDivided = resultDouble / 1e18;

    result = resultDivided.toString();

    return result;
  } catch (e) {
    return result;
  }
}
