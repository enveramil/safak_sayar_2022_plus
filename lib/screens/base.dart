import 'package:flutter/material.dart';
import 'package:safak_sayar_2022_plus/screens/countdowntimer.dart';
import 'package:safak_sayar_2022_plus/screens/home_page.dart';
import 'package:safak_sayar_2022_plus/screens/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

PageController controller = PageController();
final controller2 = PageController(initialPage: 1);

class _MyHomePageState extends State<MyHomePage> {
  final keyIsFirstLoaded = 'is_first_loaded';
  List<Widget> pages = [HomePage(), const UserDetails()];
  int currentIndex = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      popUp(context);
    });
    super.initState();
    initApp();
  }

  popUp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('!!! UYGULAMAMIZA HOŞGELDİNİZ !!!'),
          content: Text(
              'Uygulamaya başlamak için önünüzdeki ekrandan bilgilerinizi girmeniz gerekmektedir. Lütfen bu bildirim ekranı kapandıktan sonra bilgilerinizi doldurunuz...'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  prefs.setBool(keyIsFirstLoaded, false);
                },
                child: Text('Ok'))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: controller2,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54.withOpacity(0.3),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;

            controller2.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_information_outlined), label: ""),
        ],
      ),
    );
  }
}
