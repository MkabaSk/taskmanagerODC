import 'package:firebase_database/firebase_database.dart';

class Task {
  late String id;
  late String nom;
  late String description;
  late String dateDebut;
  late String dateFin;

  Task({required this.id, required this.nom, required this.description, required this.dateDebut, required this.dateFin});

  Task.fromMap(Map<dynamic, dynamic> map, String id) {
    this.id = id;
    nom = map['nom'];
    description = map['description'];
    dateDebut = map['date_debut'];
    dateFin = map['date_fin'];
  }
}