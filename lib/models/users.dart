import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


// users.dart

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });



  factory User.fromJson(String key, Map<dynamic, dynamic> json) {
    return User(
      id: key,
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}



Future<List<User>> fetchUsers() async {
  List<User> userList = [];
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child('users');

  var snapshot = await dbRef.once();

  if (snapshot is DataSnapshot) {
    // Traitement des données lorsque le snapshot est un DataSnapshot
    if (snapshot.toString() != null && snapshot.toString() is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> usersMap = snapshot.toString() as Map<dynamic, dynamic>;

      usersMap.forEach((key, value) {
        User user = User.fromJson(key, value);
        userList.add(user);
      });
    }
  } else {
    // Gestion d'un instantané inattendu
    print('Erreur: Instantané inattendu obtenu depuis Firebase.');
  }

  return userList;
}




