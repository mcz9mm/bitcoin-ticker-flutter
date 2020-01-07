import 'package:bitcoin_ticker/network_helper.dart';

const bitcoinURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC';

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

  Future<dynamic> getLastUSDPrice(String currency) async {

    NetworkHelper networkHelper = NetworkHelper('$bitcoinURL$currency');
    var bitcoinData = await networkHelper.getData();
    return bitcoinData;
  }
}
