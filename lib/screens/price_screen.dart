import 'package:bitcoin_info/components/card_coin.dart';
import 'package:bitcoin_info/services/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> coinValues = {};
  bool isWaiting = true;

  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  String lastPrice = "";

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currencyList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getData() async {
    isWaiting = true;
    try {
      var data = await coinData.getCoinData(selectedCurrency: selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      throw 'went wrong';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          'Bitcoin Ticker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                CardCoin(
                    lastPrice: isWaiting ? '?' : coinValues['BTC'].toString(),
                    selectedCurrency: selectedCurrency,
                    cryptoCurrency: "BTC"),
                CardCoin(
                    lastPrice: isWaiting ? '?' : coinValues['ETH'].toString(),
                    selectedCurrency: selectedCurrency,
                    cryptoCurrency: "ETH"),
                CardCoin(
                    lastPrice: isWaiting ? '?' : coinValues['LTC'].toString(),
                    selectedCurrency: selectedCurrency,
                    cryptoCurrency: "LTC"),
              ],
            ),
            Container(
              color: Colors.blueGrey,
              height: 150,
              child: Center(
                child: Container(
                  child: DropdownButton<dynamic>(
                      dropdownColor: Colors.blueGrey,
                      style: TextStyle(color: Colors.white),
                      value: selectedCurrency,
                      items: getDropDownItems(),
                      onChanged: (value) {
                        getData();
                        setState(() {
                          selectedCurrency = value.toString();
                        });
                      }),
                ),
              ),
            )
          ]),
    );
  }
}
