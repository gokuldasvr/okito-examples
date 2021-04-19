import 'dart:convert';

import 'package:okito/okito.dart';
import 'package:http/http.dart' as http;

class ConverterController extends OkitoController {
  final currencyList = [
    'USD',
    'JPY',
    'BGN',
    'CZK',
    'DKK',
    'GBP',
    'HUF',
    'PLN',
    'RON',
    'SEK',
    'CHF',
    'ISK',
    'NOK',
    'HRK',
    'RUB',
    'TRY',
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'KRW',
    'MXN',
    'MYR',
    'NZD',
    'PHP',
    'SGD',
    'THB',
    'ZAR'
  ];

  String? _from;
  String? _to;
  double? _amount;
  String? convertedRate;
  String? lastUpdated;

  @override
  void initState() {
    currencyList.sort((a, b) => a.compareTo(b));
    super.initState();
  }

  void updateFrom(String value) {
    _from = value;
  }

  void updateTo(String value) {
    _to = value;
  }

  void updateAmount(double value) {
    _amount = value;
  }

  Future<void> convertCurrency() async {
    if (_from == null || _to == null || _amount == null) {
      return;
    }
    final url = Uri.parse(
        'https://api.frankfurter.app/latest?amount=$_amount&from=$_from&to=$_to');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      final asJson = jsonDecode(response.body);
      lastUpdated = asJson['date'] as String;
      final newRate = asJson['rates'][_to].toString();
      convertedRate = '''$_amount $_from = $newRate $_to''';
      update();
    } else {
      print('Error while converting currencies');
    }
  }
}
