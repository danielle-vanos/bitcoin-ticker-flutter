import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  late String url;

  NetworkHelper({required this.url});

  Future getData() async {
    Uri parsedURL = Uri.parse(url);
    http.Response response = await http.get(parsedURL);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }
  }
}