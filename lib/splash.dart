import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen.dart';
import 'package:getwidget/components/intro_screen/gf_intro_screen_bottom_navigation_bar.dart';
import 'package:taskmanager/auth/sign.dart';




class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;

  late List<Widget> slideList;

  late int initialPage;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xFF1f1f1f),
    body: SafeArea(
      child: GFIntroScreen(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color:     Color(0xFF1f1f1f),
      borderRadius: BorderRadius.circular(40),

        slides: slides(),
        pageController: _pageController,
        introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(

          pageController: _pageController,
          pageCount: slideList.length,
          currentIndex: initialPage,
          backButtonText: 'Retour',
          forwardButtonText: 'Suivant',
          skipButtonText: 'Quitter',
          doneButtonText: "Connexion",
          onDoneTap: (){
            Get.off(SingPage());
          },
          backButtonTextStyle: TextStyle(
            color: Colors.white
          ),
          forwardButtonTextStyle: TextStyle(
            color: Colors.white,
          ),
          skipButtonTextStyle: TextStyle(
            color: Colors.white
          ),
          doneButtonTextStyle: TextStyle(
            color: Colors.white,
          ),
          navigationBarHeight: 50,
          navigationBarWidth: 300,
          navigationBarShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          navigationBarColor: Color(0xFF1f1f1f),
          showDivider: false,
          dotHeight: 10,
          dotWidth: 16,
          dotShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          activeColor: GFColors.SUCCESS,
          inactiveColor: Colors.grey,
          dotMargin: EdgeInsets.symmetric(horizontal: 6),
          showPagination: true,
        ), currentIndex: 0,
        pageCount: 0,
      ),
    ),
  );

  List<Widget> slides() {
    slideList = [
      Container(
        child: GFImageOverlay(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Text(
                  maxLines: 2,
                  'Welcome to ODC task Manager!',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          color: Colors.orange,
          image: const AssetImage('assets/images/Zenitusu.jpg'),
          boxFit: BoxFit.cover,
          colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
              image: AssetImage('assets/images/7.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
              image: AssetImage('assets/images/Zenitusu.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
              image: AssetImage('assets/images/7.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
      ),
    ];
    return slideList;
  }
}
