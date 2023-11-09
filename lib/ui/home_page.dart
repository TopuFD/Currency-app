import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_app/model/api_model.dart';
import 'package:currency_app/service/api_service.dart';
import 'package:currency_app/ui/component/all_currency.dart';
import 'package:currency_app/ui/reusable/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        SizedBox(
          width: 8.w,
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
          Text(
            "Base Currency",
            style: TextStyle(fontSize: 25.sp, color: Colors.purple),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: const EdgeInsets.all(10).w,
            padding: const EdgeInsets.all(8).w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
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
          SizedBox(
            height: 10.h,
          ),
          Text(
            "All currency",
            style: TextStyle(
                fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.h,
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
