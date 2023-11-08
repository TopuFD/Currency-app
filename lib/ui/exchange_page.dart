import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency_app/service/api_service.dart';
import 'package:flutter/material.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  ApiService apiService = ApiService();
  var selectedBaseCountry = "USD";
  var targetCountry = "BDT";
  var totalValue = "";
  TextEditingController userText = TextEditingController();

  Widget dropdownItem(Country country) => Row(children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 8,
        ),
        Text("${country.currencyName}")
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                "Base Currency",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white),
                child: CountryPickerDropdown(
                  initialValue: "us",
                  itemBuilder: dropdownItem,
                  onValuePicked: (Country? country) {
                    setState(() {
                      selectedBaseCountry = country?.currencyCode ?? "";
                    });
                  },
                ),
              ),
              TextField(
                controller: userText,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30,color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Write your value",
                  hintStyle: const TextStyle(fontSize: 30, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withAlpha(80),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Change Currency",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white),
                child: CountryPickerDropdown(
                  initialValue: "bd",
                  itemBuilder: dropdownItem,
                  onValuePicked: (Country? country) {
                    setState(() {
                      targetCountry = country?.currencyCode ?? "";
                    });
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    apiData(userText.text);
                  },
                  child: const Text("Click to change")),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total:",style: TextStyle(fontSize: 30,color: Colors.white),),
                  Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(88),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                        child: Text(
                      totalValue,
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white),
                    )),
                  ),
                  const SizedBox(width: 5,),
                  Text(targetCountry,style: const TextStyle(fontSize: 30,color: Colors.white),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  apiData(String value) async {
    if (value.isNotEmpty) {
      await apiService
          .exchangeCurrency(selectedBaseCountry, targetCountry)
          .then((result) {
        double userValue = double.parse(userText.text);
        double changeRate = double.parse(result[0].value.toString());
        double sum = userValue * changeRate;
        totalValue = sum.toStringAsFixed(2);
        setState(() {});
      });
    }
  }
}
