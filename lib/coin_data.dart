import 'package:bitcoin_ticker/network_helper.dart';

const bitcoinURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

const List<String> currenciesList = [
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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<Map<String, String>> getLastPrice(String currency) async {

    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      NetworkHelper networkHelper = NetworkHelper('$bitcoinURL$crypto$currency');
      var bitcoinData = await networkHelper.getData();
      double price = bitcoinData['last'];
      cryptoPrices[crypto] = price.toStringAsFixed(0);
    }

    return cryptoPrices;
  }
}
