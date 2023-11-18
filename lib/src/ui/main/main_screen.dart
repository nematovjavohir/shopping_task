import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_task/src/ui/main/administration_screen.dart';
import 'package:shopping_task/src/ui/main/category_screen.dart';
import 'package:shopping_task/src/ui/main/favourites_screen.dart';

import '../../color/app_color.dart';
import '../../util/rx_bus.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _registerBus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const CategoryScreen(),
        const FavouriteScreen(),
        const AdministrationScreen(),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.back,
        selectedItemColor: AppColor.white,
        currentIndex: _selectedIndex,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 10,
          letterSpacing: 0.5,
          color: AppColor.white,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: AppColor.white,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (_index) {
          setState(() {
            _selectedIndex = _index;
          });
        },
        unselectedItemColor: AppColor.green,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/menu/home.svg",
              height: 24,
              width: 24,
              color: _selectedIndex == 0 ? AppColor.white : AppColor.green,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/menu/explore.svg",
              height: 24,
              width: 24,
              color: _selectedIndex == 1 ? AppColor.white : AppColor.green,
            ),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/menu/heart.svg",
              height: 24,
              width: 24,
              color: _selectedIndex == 2 ? AppColor.white : AppColor.green,
            ),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/menu/account.svg",
              height: 24,
              width: 24,
              color: _selectedIndex == 3 ? AppColor.white : AppColor.green,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void _registerBus() {
    RxBus.register<int>(tag: "MAIN_POSITION").listen(
      (event) {
        setState(() {
          _selectedIndex = event;
        });
      },
    );
  }
}
