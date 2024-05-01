import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taskmanager/auth/sign.dart';
import 'package:taskmanager/screens/admin/pages/bottomNavigationBarAdmin.dart';
import 'package:taskmanager/screens/users/pages/bottomNavigation.dart';


class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeyLo = GlobalKey<FormBuilderState>();


  void loginUser(BuildContext context) async {
    if (_formKeyLo.currentState!.saveAndValidate()) {
      try {
        // Connectez-vous sans vérification
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _formKeyLo.currentState!.value['email'],
          password: _formKeyLo.currentState!.value['password'],
        );
        // Affichage d'une boîte de dialogue de chargement
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.yellow,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.black,
                ),
                SizedBox(height: 16),
                Text("Connexion"),
              ],
            ),
          ),
        );

        // Simulation d'un délai pour montrer l'indicateur de progression
        await Future.delayed(Duration(seconds: 2));

        // Fermeture de la boîte de dialogue et navigation vers la page principale
        Navigator.of(context).pop();
        // Naviguer vers la page d'accueil après la connexion réussie
        if(userCredential.user!.email == "mk@gmail.com"){
          Get.off(BottomNavigationBarAdminPage());
        }
        else{
          Get.off(BottomNavigationBarPage());
        }

      } catch (e) {
        print(e.toString());
        switch (e.toString()) {
          case 'wrong-password':
            Get.snackbar(
              "Erreur de connexion",
              "Mot de passe incorrect. Veuillez réessayer.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "Mot de passe incorrect. Veuillez réessayer.",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;

          case 'A network error':
            Get.snackbar(
              "Erreur de connexion",
              "Vérifiez votre connexion Internet et réessayez.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "Vérifiez votre connexion Internet et réessayez.",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;

          case 'user-not-found':
            Get.snackbar(
              "Erreur de connexion",
              "Aucun utilisateur trouvé avec cette adresse email.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "Aucun utilisateur trouvé avec cette adresse email.",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;
          case 'invalid-credential':
            Get.snackbar(
              "Erreur de connexion",
              "Le code d'authentification est incorrect, mal formé ou a expiré.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "Le code d'authentification est incorrect, mal formé ou a expiré.",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;
          case 'invalid-email':
            Get.snackbar(
              "Erreur de connexion",
              "L'adresse email est mal formée.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "L'adresse email est mal formée.",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;
          case 'too-many-requests':
            Get.snackbar(
              "Erreur de connexion",
              "Trop de tentatives de connexion infructueuses. Veuillez réessayer plus tard.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "Trop de tentatives de connexion infructueuses. Veuillez réessayer plus tard.",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            Get.snackbar(
              "Erreur de connexion",
              "Problème de connexion Internet. Vérifier votre connexion internet.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "Problème de connexion Internet. Vérifier votre connexion internet",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;
          case 'credential-already-in-use':
            Get.snackbar(
              "Erreur de connexion",
              "Les informations d'identification sont déjà utilisées par un autre utilisateur.",
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: const Text(
                "Les informations d'identification sont déjà utilisées par un autre utilisateur.",
                style: TextStyle(color: Colors.red),
              ),
            );
            break;
          default:
            Get.snackbar(
              "Erreur de connexion",
              e.toString(),
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 25,
              ),
              colorText: Colors.red,
              backgroundColor: Colors.white,
              isDismissible: true,
              messageText: Text(
                e.toString(),
                style: TextStyle(color: Colors.red),
              ),
            );
        }
      }
    }
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFF1f1f1f),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 100.0,),

              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Connexion",
                      style: TextStyle(
                        color: Colors.yellow.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 30.0,),

              Container(
                width: 260,
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
                  "assets/images/loginImae.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              
              SizedBox(height: 20.0,),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                  child: FormBuilder(
                    key: _formKeyLo,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          style: const TextStyle(color: Colors.yellow),
                          autofocus: true,
                          cursorColor: Colors.yellow,
                          name: 'email',
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.yellow
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              size: 24,
                              color: Colors.yellow,
                            ),
                            hintText: 'Addresse mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow, width: 1),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        FormBuilderTextField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.yellow),
                          autofocus: true,
                          cursorColor: Colors.yellow,
                          name: 'password',
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.yellow),
                            prefixIcon: Icon(
                              Icons.password,
                              size: 24,
                              color: Colors.yellow,
                            ),
                            hintText: 'Mot de passe',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow, width: 1),
                            ),
                          ),
                        ),

                        const SizedBox(height: 50),

                        Container(
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.yellow
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              loginUser(context);
                              },
                            child: const SizedBox(
                              child: Text(
                                'Connexion',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              // TextButton pour l'inscription
              TextButton(
                onPressed: () {
                  Get.off(SingPage());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous n'avez pas un Compte? ",
                      style: TextStyle(
                        color:  Colors.grey,
                      ),
                    ),
                    Text(
                      "Inscription",
                      style: TextStyle(
                        color:  Colors.yellow,
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


