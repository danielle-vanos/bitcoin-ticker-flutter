import 'networking.dart';

const apiKey = '';
const webURL = 'https://rest.coinapi.io/v1/exchangerate/';

//BTC/USD/apikey-

class priceModel {

  priceModel();

  Future<dynamic> getPriceData({coinType, currency}) async {
    String url = '${webURL}${coinType}/${currency}/apikey-${apiKey}';

    NetworkHelper networkHelper = NetworkHelper(url: url);
            
    var priceData = await networkHelper.getData();

    return priceData;
    // print(url);
    // return url;
  }

}

