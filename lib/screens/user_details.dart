import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:safak_sayar_2022_plus/model/countries.dart';
import 'package:safak_sayar_2022_plus/screens/base.dart';
import 'package:safak_sayar_2022_plus/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

late SharedPreferences sharedPreferences;
TextEditingController name = TextEditingController();
TextEditingController giris = TextEditingController();
TextEditingController memleket = TextEditingController();
TextEditingController yer = TextEditingController();
Future<void> initApp() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController _date = TextEditingController();
  String selectedItem = '6 Ay';
  List<String> months = ['6 Ay', '12 Ay', '18 Ay', '24 Ay'];

  late String? labelText;
  Icon nameIcon = Icon(Icons.person);
  Icon countryIcon = Icon(Icons.holiday_village_outlined);
  Icon placeIcon = Icon(Icons.place_outlined);
  bool isFirst = true;

  String selectedCountryItem = "Adana";
  String title = "Şafak Sayar 2022+";

  @override
  void initState() {
    super.initState();
    getValues();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Image.network(
            'https://w0.peakpx.com/wallpaper/506/505/HD-wallpaper-turk-bayragi-bayrak-flag-turk-bayrak-turkish-turkish-flag-thumbnail.jpg'),
        leadingWidth: 80,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 9),
            child: Image.network(
                'https://w0.peakpx.com/wallpaper/506/505/HD-wallpaper-turk-bayragi-bayrak-flag-turk-bayrak-turkish-turkish-flag-thumbnail.jpg'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          CustomTextField("Name", name, nameIcon),
          DateTimePickerTextField("Giriş Tarihi", _date),
          CustomTextField("İzin Hakkı", memleket, countryIcon),
          CustomTextField("Askerlik Yeri", yer, placeIcon),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black54)),
              child: Row(
                children: [
                  Container(
                    child: SizedBox(
                        width: 50, child: Icon(Icons.calendar_month_outlined)),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 35,
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedItem,
                          items: months.map(buildItem).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedItem = value;
                              });
                            }
                          },
                          isExpanded: true,
                          icon: Icon(Icons.arrow_downward_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black54)),
              child: Row(
                children: [
                  Container(
                    child: SizedBox(
                      width: 50,
                      child: Icon(Icons.flag),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 35,
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCountryItem,
                          items: Countries.countries
                              .map(buildItemCountries)
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCountryItem = value ?? '';
                            });
                          },
                          isExpanded: true,
                          icon: Icon(Icons.arrow_downward_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 60,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      save();
                      controller2.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    });
                  },
                  child: SizedBox(
                      height: 50,
                      child: Center(child: const Text('Bilgileri Kaydet')))),
            ),
          ),
        ]),
      ),
    );
  }

  DropdownMenuItem<String> buildItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );

  DropdownMenuItem<String> buildItemCountries(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));

  getValues() {
    preferences.then((SharedPreferences pref) {
      setState(() {
        name.text = pref.getString('name') ?? '';
        _date.text = pref.getString('giris') ?? '';
        memleket.text = pref.getString('memleket') ?? '';
        yer.text = pref.getString('yer') ?? '';
        selectedItem = pref.getString('month') ?? '6 Ay';
        selectedCountryItem = pref.getString('country') ?? 'Adana';
        isFirst = pref.getBool('is_first_loaded') ?? false;
      });
    });
  }

  Widget CustomTextField(String labelText,
      TextEditingController editingController, Icon prefixIcon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: TextField(
          keyboardType: TextInputType.name,
          controller: editingController,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: labelText,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  editingController.clear();
                },
              )),
        ),
      ),
    );
  }

  Widget DateTimePickerTextField(
      String labelText, TextEditingController editingController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: TextField(
          readOnly: true,
          controller: _date,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today_rounded),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: labelText,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  editingController.clear();
                },
              )),
          onTap: () async {
            DateTime? pickDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            if (pickDate != null) {
              setState(() {
                _date.text = DateFormat('dd-MM-yyyy').format(pickDate);
              });
            }
          },
        ),
      ),
    );
  }

  save() {
    initApp();
    sharedPreferences.setString('name', name.text);
    sharedPreferences.setString('giris', _date.text);
    sharedPreferences.setString('memleket', memleket.text);
    sharedPreferences.setString('yer', yer.text);
    sharedPreferences.setString("month", selectedItem);
    sharedPreferences.setString("country", selectedCountryItem);
  }
}
