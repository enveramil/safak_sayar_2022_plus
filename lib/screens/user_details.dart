import 'package:flutter/material.dart';
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
  List<String> months = ['6 Ay', '12 Ay', '18 Ay', '24 Ay'];
  String? selectedItem = '6 Ay';
  late String? labelText;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          CustomTextField("Name", name),
          CustomTextField("Giriş", giris),
          CustomTextField("Memleket", memleket),
          CustomTextField("Askerlik Yeri", yer),
          Center(
            child: SizedBox(
              width: 200,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: DropdownButton(
                    elevation: 30,
                    borderRadius: BorderRadius.circular(20),
                    iconSize: 40,
                    iconEnabledColor: Colors.red,
                    value: selectedItem,
                    items: months
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ))
                        .toList(),
                    onChanged: (item) => setState(() {
                          selectedItem = item as String?;
                        })),
              ),
            ),
          ),
          Container(
            height: 200,
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    save();
                    controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  });
                },
                child: const Text('Bilgileri Kaydet')),
          ),
          if (sharedPreferences != null)
            Text("Logged -> name: ${sharedPreferences.getString('name')}"),
          Text("Logged -> giriş: ${sharedPreferences.getString('giris')}"),
          Text(
              "Logged -> memleket: ${sharedPreferences.getString('memleket')}"),
          Text("Logged -> askerlik yeri: ${sharedPreferences.getString('yer')}")
        ]),
      ),
    );
  }

  getValues(String value) {
    preferences.then((SharedPreferences pref) {
      setState(() {
        pref.getString(value) ?? '';
      });
    });
  }

  Widget CustomTextField(
      String labelText, TextEditingController editingController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: TextField(
          keyboardType: TextInputType.name,
          controller: editingController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: labelText,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  name.clear();
                },
              )),
        ),
      ),
    );
  }
}

save() {
  initApp();
  sharedPreferences.setString('name', name.text);
  sharedPreferences.setString('giris', giris.text);
  sharedPreferences.setString('memleket', memleket.text);
  sharedPreferences.setString('yer', yer.text);
}
