import 'package:currency_app/model/api_model.dart';
import 'package:flutter/material.dart';

class AllCurrency extends StatelessWidget {
  final CurrencyModel currencyModel;
  const AllCurrency({super.key, required this.currencyModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white.withAlpha(88),
      margin:const EdgeInsets.all(10),
    
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
          Text(
            currencyModel.code.toString(),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            currencyModel.value!.toStringAsFixed(2).toString(),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }
}
