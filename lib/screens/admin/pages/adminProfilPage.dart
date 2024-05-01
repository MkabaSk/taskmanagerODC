import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taskmanager/auth/login.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({Key? key}) : super(key: key);



  Future<void> disconnectUser(BuildContext context) async {
    try {

      Get.snackbar(
        "Déconexion",
        "Déconnecter avec succès",
        icon: const Icon(
          Icons.logout,
          color: Colors.black,
          size: 25,
        ),
        colorText: Colors.black,
        backgroundColor: Colors.amber,
        isDismissible: true,
        messageText: const Text(
          "Déconnecter avec succès",
          style: TextStyle(color: Colors.black),
        ),
      );
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar(
        "Succès",
        "Erreur de déconexion",
        icon: const Icon(
          Icons.logout,
          color: Colors.black,
          size: 25,
        ),
        colorText: Colors.black,
        backgroundColor: Colors.amber,
        isDismissible: true,
        messageText: const Text(
          "Erreur de déconexion",
          style: TextStyle(color: Colors.black),
        ),
      );

      await Future.delayed(Duration(seconds: 2));
    }
  }


  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Color(0xFF1f1f1f),
      appBar: AppBar(
        backgroundColor: Color(0xFF1f1f1f),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 0, bottom: 4),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xFF6e6f6a),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          /// Menu drow pour modifier le profile
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Modifier') {
                // Code à exécuter lorsque l'utilisateur choisit "Modifier"
                print('Modifier choisi');
              } else if (value == 'Paramètres') {
                // Code à exécuter lorsque l'utilisateur choisit "Paramètres"
                print('Paramètres choisi');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Modifier',
                child: Text(
                  'Modifier',
                  style: TextStyle(
                    color: Colors.yellow,
                      fontWeight: FontWeight.normal,
                      fontSize: 15
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Paramètres',
                child: Text(
                    'Paramètres',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                  ),
                ),
              ),
            ],
            color: Color(0xFF1f1f1f),
            iconColor: Colors.yellow,
          ),
        ],
      ),




      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
            child: Container(
            child: Column(

            children: [
              SizedBox(height: 20,),

              /// Background image and container
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 10),
                      child: Container(
                        height: 210,
                        width: 390,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 15),
                      child: Container(
                        height: 200,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 270,
                                height: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFcad87c),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  width: 100,
                                  height: 100,
                                  "assets/images/Zenitusu.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 0, right: 0, bottom: 0),
                              child: Center(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.yellow,
                                      style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: CircleAvatar(
                                      maxRadius: 50,
                                      backgroundImage: AssetImage(
                                        "assets/images/7.jpeg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),

              /// Prénom
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Prénom :",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mohamed",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              /// Nom
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Nom :",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Kaba",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              /// Email
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Email :",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "kabamohamedauf224@gmail.com",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              /// Tasks
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Task :",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "45",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              /// Users
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Users :",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                               const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "20",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  Get.off(LoginPage());
                  disconnectUser(context);
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.yellow.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 175.0, top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
