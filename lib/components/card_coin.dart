import 'package:flutter/material.dart';

class CardCoin extends StatelessWidget {
  final String lastPrice;
  final String selectedCurrency;
  final String cryptoCurrency;

  CardCoin(
      {required this.lastPrice,
      required this.selectedCurrency,
      required this.cryptoCurrency});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 100,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 6,
          color: Colors.blueGrey,
          child: Center(
              child: Text(
            '1 $cryptoCurrency = $lastPrice $selectedCurrency',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
      ),
    );
  }
}
