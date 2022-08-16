import 'package:flutter/material.dart';
import 'package:safak_sayar_2022_plus/screens/home_page.dart';
import 'package:safak_sayar_2022_plus/screens/user_details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

PageController controller = PageController();

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [HomePage(), UserDetails()];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initApp();
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
        controller: controller,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54.withOpacity(0.3),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;

            controller.animateToPage(index,
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
