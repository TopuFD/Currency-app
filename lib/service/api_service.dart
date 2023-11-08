import 'dart:convert';
import 'package:currency_app/constant/constant.dart';
import 'package:currency_app/model/api_model.dart';
import 'package:currency_app/ui/reusable/reusable_widget.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ReWidget reWidget = ReWidget();
  Future<List<CurrencyModel>> getCurrency(String baseCurrrency) async {
    List<CurrencyModel> currencyModelList = [];

    String url = '${base_url}apikey=$apiKey&base_currency=$baseCurrrency';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        Map<String, dynamic> body = json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;
      } else {
        return [];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CurrencyModel>> exchangeCurrency(
      String baseCurrrency, String targetCurrency) async {
    List<CurrencyModel> currencyModelList = [];

    String url = '${base_url}apikey=$apiKey&base_currency=$baseCurrrency&currencies=$targetCurrency';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        Map<String, dynamic> body = json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;
      } else {
        return [];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
