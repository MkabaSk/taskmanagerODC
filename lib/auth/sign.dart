import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/auth/login.dart';
import 'package:taskmanager/screens/admin/pages/bottomNavigationBarAdmin.dart';
import 'package:taskmanager/screens/users/pages/bottomNavigation.dart';

class SingPage extends StatefulWidget {
  const SingPage({Key? key}) : super(key: key);

  @override
  State<SingPage> createState() => _SingPageState();
}

class _SingPageState extends State<SingPage> {
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  XFile? imageFile;
  String urlOfUploadedImage = "";

  // Vérifier si une image a été choisie
  void checkIfNetworkIsAvailable() {
    if (imageFile != null) {
      signUpFormValidation();
    } else {
      Get.snackbar(
        "Erreur",
        "Choisissez une photo.",
        backgroundColor: Colors.yellow,
      );
    }
  }

  // Validation du formulaire d'inscription
  void signUpFormValidation() async {
    if (firstNameTextEditingController.text.trim().length < 4) {
      Get.snackbar(
        "Erreur",
        "Votre nom doit comporter au moins 4 caractères.",
        backgroundColor: Colors.yellow,
      );
    } else if (lastNameTextEditingController.text.trim().length < 2) {
      Get.snackbar(
        "Erreur",
        "Donnez votre vrai nom de famille.",
        backgroundColor: Colors.yellow,
      );
    } else if (!emailTextEditingController.text.contains("@")) {
      Get.snackbar(
        "Erreur",
        "Veuillez fournir une adresse e-mail valide.",
        backgroundColor: Colors.yellow,
      );
    } else if (passwordTextEditingController.text.trim().length < 8) {
      Get.snackbar(
        "Erreur",
        "Votre mot de passe doit comporter au moins 8 caractères.",
        backgroundColor: Colors.yellow,
      );
    } else {
      // Vérifier si l'adresse e-mail existe déjà
      List<String> methods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(emailTextEditingController.text.trim());
      if (methods.isNotEmpty) {
        // L'adresse e-mail existe déjà
        Get.snackbar(
          "Erreur",
          "Cette adresse e-mail est déjà associée à un compte.",
          backgroundColor: Colors.yellow,
        );
      } else {
        // L'adresse e-mail n'existe pas encore, continuer avec l'inscription
        uploadImageToStorage();
      }
    }
  }

  // Télécharger l'image vers Firebase Storage
  Future<void> uploadImageToStorage() async {
    try {
      String imageIDName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceImage =
          FirebaseStorage.instance.ref().child("Images").child(imageIDName);

      UploadTask uploadTask = referenceImage.putFile(File(imageFile!.path));
      TaskSnapshot snapshot = await uploadTask;
      urlOfUploadedImage = await snapshot.ref.getDownloadURL();
      registerNewUser();
    } catch (error) {
      Get.snackbar(
        "Erreur",
        error.toString(),
        backgroundColor: Colors.yellow,
      );
    }
  }

  // Enregistrer le nouvel utilisateur dans Firebase Authentication et Real-time Database
  void registerNewUser() async {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.yellow,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.black,
            ),
            SizedBox(height: 16),
            Text("Création..."),
          ],
        ),
      ),
    );

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );

      DatabaseReference usersRef = FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(userCredential.user!.uid);

      Map<String, dynamic> userDataMap = {
        "photo": urlOfUploadedImage,
        "firstName": firstNameTextEditingController.text.trim(),
        "lastName": lastNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "id": userCredential.user!.uid,
        "blockStatus": "no",
      };
      await usersRef.set(userDataMap);

      // Inscription réussie, naviguer vers la page appropriée
      Get.off(
          BottomNavigationBarPage()); // Assurez-vous d'importer la classe BottomNavigation
      // Afficher le SnackBar pour informer l'utilisateur
      Get.snackbar(
        "Succès",
        "Inscription réussie!",
        backgroundColor: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Erreur",
        error.toString(),
        backgroundColor: Colors.yellow,
      );
    } finally {
      Get.back();
    }
  }

  // Choisir une image depuis la galerie
  chooseImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f1f1f),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 80),
              Center(
                child: Text(
                  "Inscription",
                  style: TextStyle(
                    color: Colors.yellow.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Afficher l'image sélectionnée ou une image par défaut si aucune image n'a été sélectionnée
              imageFile == null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/task.jpg"),
                    )
                  : Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: FileImage(
                            File(
                              imageFile!.path,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  chooseImageFromGallery();
                },
                child: Text(
                  "Votre photo",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    // Champs de texte pour le prénom
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: TextField(
                        controller: firstNameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.yellow,
                          ),
                          fillColor: Colors.yellow,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.yellow,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Prenom',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    // Champs de texte pour le nom de famille
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: TextField(
                        controller: lastNameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.yellow,
                          ),
                          fillColor: Colors.yellow,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.yellow,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Nom',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    // Champs de texte pour l'adresse e-mail
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: TextField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                          hintStyle: TextStyle(color: Colors.yellow),
                          fillColor: Colors.yellow,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.yellow,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Addresse mail',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    // Champs de texte pour le mot de passe
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: TextField(
                        controller: passwordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                          hintStyle: TextStyle(color: Colors.yellow),
                          fillColor: Colors.yellow,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.yellow,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Mot de passe',
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    // Bouton d'inscription
                    ElevatedButton(
                      onPressed: () {
                        registerNewUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.withOpacity(0.9),
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      ),
                      child: Text(
                        "Inscription",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bouton de navigation vers la page de connexion
              TextButton(
                onPressed: () {
                  Get.off(LoginPage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous avez un Compte? ",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      "Connexion",
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
