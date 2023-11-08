import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_app/model/api_model.dart';
import 'package:currency_app/service/api_service.dart';
import 'package:currency_app/ui/component/all_currency.dart';
import 'package:currency_app/ui/reusable/reusable_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

ReWidget reWidget = ReWidget();
ApiService apiService = ApiService();
String selectedCurrency = "USD";

class _HomePageState extends State<HomePage> {
  Widget dropdownItem(Country country) => Row(children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 8,
        ),
        Text(
          "${country.currencyName}",
        )
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Text(
            "Base Currency",
            style: TextStyle(fontSize: 25, color: Colors.purple),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: CountryPickerDropdown(
              
              initialValue: "us",
              itemBuilder: dropdownItem,
              onValuePicked: (Country? country) {
                setState(() {
                  selectedCurrency = country?.currencyCode ?? "";
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "All currency",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CurrencyModel> dataList = snapshot.data ?? [];
                return Expanded(
                    child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return AllCurrency(currencyModel: dataList[index]);
                        }));
              } else if (snapshot.hasError) {
                return reWidget.myToast("Error!");
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: apiService.getCurrency(selectedCurrency),
          ),
        ],
      ),
    );
  }
}
