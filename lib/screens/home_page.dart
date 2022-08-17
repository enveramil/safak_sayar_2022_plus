import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

class _HomePageState extends State<HomePage> {
  String name = "";
  String giris = "";
  String izin = "";
  String yer = "";
  String sure = "";
  String country = "";
  String title = "Şafak Sayar 2022+";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
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
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: Card(
                margin: EdgeInsets.only(bottom: 15),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.grey,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListTile(
                    title: Text(
                      'Kalan Şafak'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          decoration: TextDecoration.underline),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 350,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.grey,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListTile(
                    title: Text(
                      'Asker Bilgileri'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                        'User Details sayfasında girmiş olduğunuz bilgiler bu alanda gösterilmektedir',
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: CustomCard(
                  userInfo: "Name: ${name}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: CustomCard(
                  userInfo: "Giriş: ${giris}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: CustomCard(
                  userInfo: "İzin Hakkı: ${izin}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: CustomCard(
                  userInfo: "Askerlik Yeri: ${yer}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: CustomCard(
                  userInfo: "Süre: ${sure}",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                child: CustomCard(
                  userInfo: "Ülke: ${country}",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getValues() {
    preferences.then((SharedPreferences prefs) {
      setState(() {
        name = prefs.getString('name') ?? '';
        giris = prefs.getString('giris') ?? '';
        izin = prefs.getString('memleket') ?? '';
        yer = prefs.getString('yer') ?? '';
        sure = prefs.getString('month') ?? '';
        country = prefs.getString('country') ?? '';
      });
    });
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.userInfo,
  }) : super(key: key);
  final String userInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.grey,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 30,
            child: Text(
              userInfo,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 24,
                  ),
            ),
          ),
        ));
  }
}
