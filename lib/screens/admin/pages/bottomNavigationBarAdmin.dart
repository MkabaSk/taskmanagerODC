import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/screens/admin/pages/adminHome.dart';
import 'package:taskmanager/screens/admin/pages/adminNotificationPage.dart';
import 'package:taskmanager/screens/admin/pages/adminSettings.dart';

class BottomNavigationBarAdminPage extends StatefulWidget {
  const BottomNavigationBarAdminPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarAdminPage> createState() =>
      _BottomNavigationBarAdminPageState();
}

class _BottomNavigationBarAdminPageState
    extends State<BottomNavigationBarAdminPage> {
  int currentPage = 0;

  final List<Widget> mesPages = [
    AdminHomePage(),
    AdminNotificationPage(),
    AdminSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1f1f),
      body: SafeArea(
        child: IndexedStack(
          index: currentPage,
          children: mesPages,
        ),
      ),

      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(bottom: 15.0, left: 50.0, right: 50.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(55), // Bord arrondi
          child: BottomAppBar(
            clipBehavior: Clip.antiAlias, // Ajout du clipBehavior ici
            shape: const CircularNotchedRectangle(),
            notchMargin: 2.0,
            color: Colors.black,
            child: SizedBox(
              height: 56, // Hauteur personnalisée
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == 0 ? Colors.yellow : Colors.transparent,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 25,
                        color: currentPage == 0 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          currentPage = 0;
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == 1 ? Colors.yellow : Colors.transparent,
                      border: Border.all(
                        color: currentPage == 1 ? Colors.yellow : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications,
                        size: 25,
                        color: currentPage == 1 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          currentPage = 1;
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == 2 ? Colors.yellow : Colors.transparent,
                      border: Border.all(
                        color: currentPage == 2 ? Colors.yellow : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        size: 25,
                        color: currentPage == 2 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          currentPage = 2;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),




    );
  }
}
