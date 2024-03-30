import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'package:bitcoin_ticker/services/price.dart';

String selectedCurrency = 'AUD';
Map<String, String> coinPriceDict = {};

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Android -------------------------------
  Widget getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      print(currency);
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value.toString();
          });
        });
  }

  // iOS -------------------------------
  Widget iOSPickerItems() {
    List<Widget> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: ((value) async {
          selectedCurrency = currenciesList[value];
          getPrice();
        }),
        children: pickerItems);
  }

  // currencyModel -------------------------------
  priceModel currencyConverter = priceModel();

  // Initialise -------------------------------
  @override
  initState() {
    getPrice();
    super.initState();
  }

  // Get Price -------------------------------
  void getPrice() async {
    Map<String, String> coinPrice = {};

    for (String crypto in cryptoList) {
      var currencyData = await currencyConverter.getPriceData(
          coinType: crypto, currency: selectedCurrency);

      if (currencyData == null) {
        coinPrice[crypto] = '?';
      } else {
        coinPrice[crypto] = currencyData['rate'].toStringAsFixed(0);
      }
    }
    setState(() {
      coinPriceDict = coinPrice;
    });
  }

  // Build screen -------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: getBlueRectangles(
                    coinPriceDict: coinPriceDict,
                    selectedCurrency: selectedCurrency),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 150.0,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.lightBlue,
                    child: Platform.isIOS
                        ? iOSPickerItems()
                        : getAndroidDropdown(),
                  ),
                ],
              ),
            ),
          ],
        ), // bottom
      ]),
    );
  }
}

// getBlueRectanges ------------------------
List<Widget> getBlueRectangles({coinPriceDict, selectedCurrency}) {
  List<Widget> blueRectangleList = [];

  for (String crypto in cryptoList) {
    var currencyValue = coinPriceDict[crypto];
    print(coinPriceDict);
    print(currencyValue);

    var newItem = blueCoinRectangle(
        coinType: crypto,
        currencyValue: currencyValue == null ? '?' : currencyValue,
        selectedCurrency: selectedCurrency);

    blueRectangleList.add(newItem);
  }
  return (blueRectangleList);
}

class blueCoinRectangle extends StatelessWidget {
  const blueCoinRectangle({
    Key? key,
    required this.coinType,
    required this.currencyValue,
    required this.selectedCurrency,
  }) : super(key: key);

  final String coinType;
  final String currencyValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 5, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${coinType} = ${currencyValue} ${selectedCurrency}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          )],
        ),
      ),
    );
  }
}
