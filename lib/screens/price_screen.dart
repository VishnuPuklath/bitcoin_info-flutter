import 'package:bitcoin_info/services/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
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

  void getData(String selectedCurrency) async {
    try {
      double lstPrice =
          await coinData.getCoinData(selectedCurrency: selectedCurrency);
      setState(() {
        lastPrice = lstPrice.toStringAsFixed(0);
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
        title: Text(
          'Bitcoin Ticker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 6,
                  color: Colors.blueGrey,
                  child: Center(
                      child: Text(
                    '1 BTC = $lastPrice $selectedCurrency',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey,
              height: 150,
              child: Center(
                child: Container(
                  child: DropdownButton<dynamic>(
                      value: selectedCurrency,
                      items: getDropDownItems(),
                      onChanged: (value) {
                        getData(value);
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
