import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        SizedBox(
          width: 8.h,
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
              Text(
                "Base Currency",
                style: TextStyle(fontSize: 20.sp, color: Colors.white),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                margin: const EdgeInsets.all(10).w,
                padding: const EdgeInsets.all(8).w,
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
                style: TextStyle(fontSize: 30.sp,color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Write your value",
                  hintStyle: TextStyle(fontSize: 30.sp, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withAlpha(80),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Change Currency",
                style: TextStyle(fontSize: 20.sp, color: Colors.white),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                margin: const EdgeInsets.all(10).w,
                padding: const EdgeInsets.all(8).w,
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
              SizedBox(
                height: 8.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total:",style: TextStyle(fontSize: 30,color: Colors.white),),
                  Container(
                    height: 100.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(88),
                      borderRadius: BorderRadius.circular(15.r)
                    ),
                    child: Center(
                        child: Text(
                      totalValue,
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.white),
                    )),
                  ),
                  SizedBox(width: 5.w,),
                  Text(targetCountry,style: TextStyle(fontSize: 30.sp,color: Colors.white),)
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
