import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'AUD';
  bool isWaiting = true;
  Map<String, String> coinValues = {};

  CoinData coinData = CoinData();

  DropdownButton<String> androidDropdown() {

    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value;
          getLastPrice();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {

    List<Text> pickerItems = [];

    for (String currency in currenciesList) {

      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        selectedCurrency = currenciesList[selectedIndex];
        getLastPrice();
      },
      children: pickerItems,
    );
  }

  void updateUI(dynamic pricesData) {

    setState(() {

      if (pricesData != null) {
        isWaiting = false;
        coinValues = pricesData;
      } else {
        print('ERROR');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getLastPrice();
  }

  void getLastPrice() async {

    setState(() {
      isWaiting = true;
    });

    var data = await coinData.getLastPrice(selectedCurrency);
    if (data != null) {
      updateUI(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  crypto: 'BTC',
                  price: isWaiting ? '?' : coinValues['BTC'],
                  selectedCurrency: selectedCurrency,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  crypto: 'ETH',
                  price: isWaiting ? '?' : coinValues['ETH'],
                  selectedCurrency: selectedCurrency,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  crypto: 'LTC',
                  price: isWaiting ? '?' : coinValues['LTC'],
                  selectedCurrency: selectedCurrency,
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}


class CryptoCard extends StatelessWidget {

  CryptoCard({
    this.crypto,
    this.price,
    this.selectedCurrency,
  });

  final String price;
  final String crypto;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $price $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

