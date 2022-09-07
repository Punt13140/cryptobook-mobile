import 'package:badges/badges.dart';
import 'package:cryptobook/view/dashboard_screen.dart';
import 'package:cryptobook/view/farmings/farmings_screen.dart';
import 'package:cryptobook/view/positions/positions_screen.dart';
import 'package:cryptobook/view/settings_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.position}) : super(key: key);

  final int position;

  BottomNavigationBarItem getBottomNavigationBarItem(MenuItem menuItem) {
    Widget currentIcon = position == menuItem.index ? Icon(menuItem.iconDataSelected) : Icon(menuItem.iconData);

    if (menuItem.showBadge) {
      currentIcon = Badge(
        animationDuration: const Duration(milliseconds: 0),
        badgeContent: Text(
          menuItem.badgeContent!,
          style: const TextStyle(color: Colors.white),
        ),
        badgeColor: Colors.purple,
        child: currentIcon,
      );
    }
    return BottomNavigationBarItem(
      icon: currentIcon,
      label: menuItem.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> mainMenuItems = [
      MenuItem(0, Icons.home_outlined, Icons.home, "Accueil", () {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(pageBuilder: (context, a1, a2) => const DashBoardScreen()), (route) => route.isFirst);
      }),
      MenuItem(1, Icons.currency_bitcoin_outlined, Icons.currency_bitcoin, "Positions", () {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(pageBuilder: (context, a1, a2) => const PositionsScreen()), (route) => route.isFirst);
      }),
      MenuItem(2, Icons.agriculture_outlined, Icons.agriculture, "Farmings", () {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(pageBuilder: (context, a1, a2) => const FarmingsScreen()), (route) => route.isFirst);
      }),
      MenuItem(3, Icons.settings_outlined, Icons.settings, "Paramètres", () {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(pageBuilder: (context, a1, a2) => const SettingsScreen()), (route) => route.isFirst);
      })
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      items: mainMenuItems.map((item) => getBottomNavigationBarItem(item)).toList(),
      currentIndex: position > (mainMenuItems.length - 1) ? (mainMenuItems.length - 1) : position,
      onTap: (int index) {
        mainMenuItems.elementAt(index).onTap();
      },
    );
  }
}

class MenuItem {
  final IconData iconData;
  final IconData iconDataSelected;
  final String text;
  final void Function() onTap;
  final int index;
  final bool showBadge;
  final String? badgeContent;

  MenuItem(this.index, this.iconData, this.iconDataSelected, this.text, this.onTap,
      {this.showBadge = false, this.badgeContent});
}
