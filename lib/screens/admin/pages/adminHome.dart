import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/position/gf_position.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:taskmanager/screens/admin/pages/adminProfilPage.dart';
import 'package:taskmanager/screens/admin/pages/allTaskPage.dart';
import 'package:taskmanager/models/users.dart' show User;

import '../../../models/tasks.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final TextEditingController taskNameTextEditingController = TextEditingController();
  final TextEditingController taskDescriptionTextEditingController = TextEditingController();
  final TextEditingController startDateTextEditingController = TextEditingController();
  final TextEditingController deadlineTextEditingController = TextEditingController();
  final _formKeyTask = GlobalKey<FormBuilderState>();
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  //late DatabaseReference _taskRef;
  /// Une liste de couleur pour les tâches
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



  final List<Task> tasks = [];

  final DatabaseReference data = FirebaseDatabase.instance.ref().child("tasks");




/* Future<void> getData() async {
    await data.get().then((DataSnapshot snapshot) {
      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic>? tasks = snapshot.value as Map<dynamic, dynamic>?; // Ajout de l'annotation de type explicite
        if (tasks != null) {
          tasks.forEach((key, value) {
            print("Nom: ${value['nom']}");
            print("Description: ${value['description']}");
            print("Date de début: ${value['date_debut']}");
            print("Date de fin: ${value['date_fin']}");
            print(""); // Ligne vide pour séparer chaque tâche
          });
        }
      } else {
        print("Aucune donnée disponible.");
      }
    }).catchError((error) {
      print("Erreur lors de la récupération des données: $error");
    });
  }*/

  Future<void> getData() async {
    final DatabaseReference data = FirebaseDatabase.instance.ref().child("tasks");

    await data.get().then((DataSnapshot snapshot) {
      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic>? tasksData = snapshot.value as Map<dynamic, dynamic>?;

        if (tasksData != null) {
          tasksData.forEach((key, value) {
            // Créer une nouvelle tâche et l'ajouter à la liste
            Task task = Task.fromMap(value, key);
            tasks.add(task);
          });

          // Rafraîchir l'interface utilisateur après avoir ajouté toutes les tâches à la liste
          // (ceci déclenchera la reconstruction de la ListView avec les nouvelles données)
          // Si cela ne fonctionne pas correctement, tu peux appeler setState(() {}) ici
        }
      } else {
        print("Aucune donnée disponible.");
      }
    }).catchError((error) {
      print("Erreur lors de la récupération des données: $error");
    });
  }





  @override
  void initState()  {
   print(getData());
    //super.initState();
  }

// a conserver "admins": {
//       ".read": "auth != null",
//       ".write": "auth != null",
//       ".validate": "newData.exists()"

  /// Méthode pour ajouter une tache quand on clique sur le button Creat Task
  void addTask() {
    if (_formKeyTask.currentState != null && _formKeyTask.currentState!.validate()) {
      var formFields = _formKeyTask.currentState!.fields;
      String nomTask = formFields['namTask']!.value as String;
      String descriptionTask = formFields['descriptionTask']!.value as String;
      DateTime startDate = formFields['startDate']!.value as DateTime;
      DateTime endDate = formFields['endDate']!.value as DateTime;
      // Convertir les dates en chaînes de caractères
      String startDateString = startDate.toString();
      String endDateString = endDate.toString();
      addTaskToDatabase(nomTask, descriptionTask, startDateString, endDateString);
      _formKeyTask.currentState!.reset();
    }
  }









  /// Méthode pour ajouter une tache à la base
  void addTaskToDatabase(String nomTask, String descriptionTask, String startDate, String deadDate) {
    try {
      /// Générez une nouvelle clé pour la tâche
      String? taskId = databaseReference.child('tasks').push().key;

      /// Map pour stocker les informations de la tâche
      Map<String, dynamic> taskData = {
        'nom': nomTask,
        'description': descriptionTask,
        'date_debut': startDate,
        'date_fin': deadDate,
        // Ajout d'autres propriétés au besoin comme pour les utilisateurs assigner
      };

      // Ajout de la tâche à la base de données en utilisant sa clé
      databaseReference.child('tasks').child(taskId!).set(taskData);

      // Afficher un message ou effectuer d'autres actions si nécessaire
      Get.snackbar(
        "Succès",'La tâche a été ajoutée à la base de données avec succès.',
        backgroundColor: Colors.yellow,
        messageText: Text("'La tâche a été ajoutée à la base de données avec succès.'"),
      );
    } catch (e) {
      // Message d'erreurs si l'ajout de tâche échoue
      Get.snackbar("Erreur",'Erreur lors de l\'ajout de la tâche : $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f1f1f),
      body: Container(

        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(height: 50),


                ///Add task and imageButton
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 55,
                          width: 220,
                          decoration: const BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.all(Radius.circular(28))),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  /// BottomSheet pour le formulaire de creation de taches
                                  Get.bottomSheet(
                                   SingleChildScrollView(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFec5951),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                        ),
                                        height: MediaQuery.of(context).size.height * 0.8,
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              const ListTile(
                                                title: Text(
                                                  "Hey Create new task",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 23,
                                                  ),
                                                ),
                                              ),


                                              FormBuilder(
                                                key: _formKeyTask,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Task Title",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    FormBuilderTextField(
                                                      name: 'namTask',
                                                      decoration: InputDecoration(
                                                        hintText: 'Enter task title',
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text(
                                                      "Task Details",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    FormBuilderTextField(
                                                      name: 'descriptionTask',
                                                      maxLines: 4,
                                                      decoration: InputDecoration(
                                                        hintText: 'Enter task details',
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text(
                                                      "Start Date",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    FormBuilderDateTimePicker(
                                                      name: 'startDate',
                                                      inputType: InputType.date,
                                                      decoration: InputDecoration(
                                                        hintText: 'Select start date',
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Text(
                                                      "End Date",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    FormBuilderDateTimePicker(
                                                      name: 'endDate',
                                                      inputType: InputType.date,
                                                      decoration: InputDecoration(
                                                        hintText: 'Select end date',
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: 20),

                                                    // Bouton de création de tâche
                                                    Center(
                                                      child: Container(
                                                        width: 250,
                                                        height: 55,
                                                        child: FloatingActionButton(
                                                          elevation: 5,
                                                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                                          backgroundColor: Colors.black,
                                                          onPressed: addTask,
                                                          child: const Text(
                                                            "Create task",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.yellow,
                                    size: 24,
                                  ),
                                ),
                              ),
                              const Text(
                                "Creat New Task",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => AdminProfilePage());
                          },
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(
                              "assets/images/7.jpeg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10,),

                /// Manage your task and See All
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 15.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Manage Your Task",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => AllTaskPage());
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index].nom),
                      subtitle: Text(tasks[index].description),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Start: ${tasks[index].dateDebut}'),
                          Text('End: ${tasks[index].dateFin}'),
                        ],
                      ),
                    );
                  },
                ),


              /*  Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                ),*/





                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }



  /*Widget buildTaskCard(Map<String, dynamic> task, int index, int totalCount) {
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
  }*/

}
