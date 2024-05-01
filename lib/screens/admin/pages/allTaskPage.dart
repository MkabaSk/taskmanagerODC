import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

import 'adminProfilPage.dart';


class AllTaskPage extends StatefulWidget {
  const AllTaskPage({super.key});

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {

  List<Map<String, dynamic>> tasks = [

  ];



  List<Color> colors = [
    Colors.blue.withOpacity(0.5),
    Colors.green.withOpacity(0.8),
    Color(0xFFcad87c),
    Colors.amberAccent,
    Colors.tealAccent.withOpacity(0.7),
    Color(0xFFec5951),
    Colors.cyan.withOpacity(0.7),
    Colors.greenAccent.withOpacity(0.7),
  ];
  int colorIndex = 0;


  void addTask() {
    Map<String, dynamic> newTask = {
      'title': 'Task ${tasks.length + 1}',
      'date': 'Date',
      'time': 'Time',
      'avatars': [
        AssetImage("assets/images/7.jpeg"),
        AssetImage("assets/images/7.jpeg"),
        AssetImage("assets/images/7.jpeg"),
      ],
      // Ajoutez d'autres propriétés au besoin
    };
    setState(() {
      tasks.add(newTask);
      colorIndex = (colorIndex + 1) % colors.length; // Cycle through colors
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f1f1f),
      floatingActionButton:   FloatingActionButton(
        onPressed: addTask,
        child: Icon(Icons.add),
      ),
      body: Container(
        // Utilisez la hauteur de l'écran
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              ///Button de retour
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF6e6f6a)
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 20,
                                    color: Colors.yellow,
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              /// List Task Message
              const Padding(
                padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),

              /// Card qui va contenir les taches
              /*ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Désactive le défilement du ListView
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildTaskCard(tasks[index],index, index);
                },
              ),*/
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: tasks.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onLongPress: (){
                      Get.bottomSheet(
                        elevation: 15,
                        isScrollControlled: true,
                        SingleChildScrollView(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFec5951),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.8, // Augmentation de la hauteur
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [

                                    /// Message ou entêtre du formulaire
                                    const ListTile(


                                      title: Text(
                                        "Options",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 10,),
                                    ListView(
                                      shrinkWrap: true,
                                      children: [
                                        const Divider(color: Colors.black,),
                                        SizedBox(height: 10,),
                                        ListTile(
                                          title: const Text(
                                            'Supprimer la tâche',
                                            style: TextStyle(
                                                color: Colors.black
                                            ),
                                          ),
                                          trailing: const Icon(
                                              Icons.delete, color:
                                          Colors.black
                                          ),
                                          onTap: () {
                                          /// L'action qu'on veut faire
                                          },
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 10,),
                                        ListTile(
                                          title: const Text(
                                            'Modifier la tâches',
                                            style: TextStyle(
                                                color: Colors.black
                                            ),
                                          ),
                                          trailing: const Icon(
                                              Icons.edit,
                                              color: Colors.black
                                          ),
                                          onTap: () {
                                            // Naviguer vers la page de gestion des tâches
                                          },
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 10,),
                                        ListTile(
                                          title: const Text(
                                            'Voir les détails',
                                            style: TextStyle(
                                                color: Colors.black
                                            ),
                                          ),
                                          trailing: const Icon(
                                              Icons.info_outline,
                                              color: Colors.black
                                          ),
                                          onTap: () {
                                            // Naviguer vers la page de gestion des tâches
                                          },
                                        ),
                                        const Divider(color: Colors.black,),
                                        SizedBox(height: 10,),

                                      ],
                                    ),


                                  ],
                                ),
                              ),

                            ),
                          ),
                        ),
                      );
                    },
                      child: buildTaskCard(
                          tasks[index],
                          index,
                          tasks.length));
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildTaskCard(Map<String, dynamic> task, int index, int totalCount) {
    int colorIndex = index % colors.length; // Sélectionne la couleur en fonction de l'index
    return Positioned(
      left: 10,
      right: 10,
      child: GFCard(
        height: 218,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: colors[colorIndex], // Utilise la couleur correspondante
        borderRadius: BorderRadius.circular(100),
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        showImage: true,
        content: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    task['title'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      size: 22,
                      color: Color(0xFFcad87c),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.date_range),
                      SizedBox(width: 5),
                      Text(
                        task['date'] ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Row(
                    children: [
                      const Icon(Icons.alarm),
                      SizedBox(width: 5),
                      Text(
                        task['time'] ?? '',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: GFAvatar(
                              radius: 20,
                              backgroundImage: task['avatars'][0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: GFAvatar(
                              radius: 20,
                              backgroundImage: task['avatars'][1],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 55.0),
                            child: GFAvatar(
                              radius: 20,
                              backgroundImage: task['avatars'][2],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 85.0),
                            child: GFIconButton(
                              borderShape: CircleBorder(),
                              color: Color(0xFFcbd87e),
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 28,
                              ),
                              onPressed: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, bottom: 7),
                      child: GFButton(
                        color: Color(0xFFcad87c),
                        onPressed: () {},
                        shape: GFButtonShape.pills,
                        child: const Text(
                          "Medium",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




}