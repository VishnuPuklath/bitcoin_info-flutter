import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currencyList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinApi = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'BA935670-4E5B-4057-9C51-1FCC395F10FD';

class CoinData {
  Future getCoinData({required String selectedCurrency}) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      http.Response response = await http
          .get(Uri.parse('$coinApi/$crypto/$selectedCurrency/?apiKey=$apiKey'));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        throw 'something went wrong';
      }
    }
    return cryptoPrices;
  }
}
