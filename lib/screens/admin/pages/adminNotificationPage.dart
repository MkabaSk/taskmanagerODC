import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/types/gf_button_type.dart';

class AdminNotificationPage extends StatefulWidget {
  const AdminNotificationPage({super.key});

  @override
  State<AdminNotificationPage> createState() => _AdminNotificationPageState();
}

class _AdminNotificationPageState extends State<AdminNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: SizedBox(width: 0,),
        centerTitle: true,
        backgroundColor: Color(0xFF1f1f1f),
        title: Text(
          "Nofications",
          style: TextStyle(color: Colors.yellow.withOpacity(0.5)),
        ),
        actions: <Widget>[
          /// Menu drow pour modifier le profile
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Réinitialiser') {
                // Code à exécuter lorsque l'utilisateur choisit "Modifier"
                print('Réinitialiser choisi');
              } else if (value == 'Afficher') {
                // Code à exécuter lorsque l'utilisateur choisit "Paramètres"
                print('Afficher choisi');
              } else if (value == 'Son') {
                // Code à exécuter lorsque l'utilisateur choisit "Paramètres"
                print('Son choisi');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Réinitialiser',
                child: Text(
                  'Réinitialiser',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Afficher',
                child: Text(
                  'Afficher',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Son',
                child: Text(
                  'Son',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
              ),
            ],
            color: Color(0xFF1f1f1f),
            iconColor: Colors.yellow,
          ),
        ],
      ),
      backgroundColor: Color(0xFF1f1f1f),
      body: Container(
        height: MediaQuery.of(context).size.height, // Utilisez la hauteur de l'écran
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Désactive le défilement du ListView
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    // La clé doit être définie
                    ///key: Key(user.id.toString()),

                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),

                      dismissible: DismissiblePane(onDismissed: () {}),

                      children: [
                        SlidableAction(
                          padding: EdgeInsets.only(top: 18.0),
                          onPressed: (BuildContext context) async {
                            // Action à effectuer lorsque la première action est tapée
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.yellow.withOpacity(0.8),
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                      "Êtes-vous sur le point de rendre ce message nouveau, voulez-vous continuer ?"),
                                  actions: <Widget>[
                                    // Bouton pour annuler la suppression
                                    TextButton(
                                      onPressed: () {
                                        // Action à effectuer lorsque l'utilisateur annule la suppression
                                        // Fermer la boîte de dialogue avec la valeur false
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    // Bouton pour confirmer la suppression
                                    TextButton(
                                      onPressed: () async {
                                        // Confirmer la suppression

                                        // Fermer la boîte de dialogue avec la valeur true
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("Supprimer"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          backgroundColor: Color(0xFF0a84ff),
                          foregroundColor: Colors.white,
                          icon: CupertinoIcons.chat_bubble_fill,
                          label: '',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          // Action à effectuer lorsque l'élément est glissé
                        },
                      ),

                      // All actions are defined in the children parameter.
                      children: [
                        // Première action
                        SlidableAction(
                          padding: EdgeInsets.only(top: 18.0),
                          onPressed: (BuildContext context) async {
                            // Action à effectuer lorsque la première action est tapée
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.yellow.withOpacity(0.8),
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                      "Êtes-vous sûr de vouloir déactiver la notification ?"),
                                  actions: <Widget>[
                                    // Bouton pour annuler la suppression
                                    TextButton(
                                      onPressed: () {
                                        // Action à effectuer lorsque l'utilisateur annule la suppression
                                        // Fermer la boîte de dialogue avec la valeur false
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    // Bouton pour confirmer la suppression
                                    TextButton(
                                      onPressed: () async {
                                        // Confirmer la suppression

                                        // Fermer la boîte de dialogue avec la valeur true
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("Supprimer"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          icon: Icons.notifications_off,
                          label: '',
                        ),

                        // Deuxième action
                        SlidableAction(
                          padding: EdgeInsets.only(top: 18.0),
                          onPressed: (BuildContext context) async {
                            // Action à effectuer lorsque la deuxième action est tapée
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.yellow.withOpacity(0.8),
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                      "Êtes-vous sûr de vouloir supprimer cet élément ?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pop(false), // Annuler la suppression
                                      child: const Text("Annuler"),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text("Supprimer"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          backgroundColor: Color(0xFFff4439),
                          foregroundColor: Colors.white,
                          icon: CupertinoIcons.delete,
                          label: '',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: GFListTile(
                          shadow: BoxShadow(color: Colors.transparent),
                          color: Colors.white.withOpacity(0.5),
                          titleText: "Nouvelle Notification",
                          subTitle: Text(
                            "Contenu de cette notification contenu de cette notification Contenu de contenu de cette notificationcette notificatio",
                            maxLines: 3,
                          ),
                          icon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 30,
                              color: Colors.yellow.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                  height: MediaQuery.of(context)
                      .viewInsets
                      .bottom), // Ajoute un espace pour le clavier virtuel
            ],
          ),
        ),
      ),
    );
  }
}
