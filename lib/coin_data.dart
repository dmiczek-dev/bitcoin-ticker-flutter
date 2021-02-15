import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'B568F93C-80B6-4F3D-96BE-6F092B3942CF';

class CoinData {
 Future getCoinData(String selectedCurrency) async {
   Map<String, String> cryptoPrices = {};
   for(String crypto in cryptoList) {
     String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apiKey=$apiKey';
     http.Response response = await http.get(requestURL);

     if(response.statusCode == 200) {
       var decodedData = jsonDecode(response.body);
       double lastPrice = decodedData['rate'];
       cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
     } else {
       print(response.statusCode);
       throw 'Problem with the get request';
     }
   }
   return cryptoPrices;
 }
}
