import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: SizedBox(width: 0,),
        centerTitle: true,
        backgroundColor: Color(0xFF1f1f1f),
        title: Text(
          "Paramètres",
          style: TextStyle(
          color: Colors.yellow.withOpacity(0.5)
          ),
        ),
      ),
      backgroundColor: Color(0xFF1f1f1f),
      body: ListView(
        children: [
          Divider(
            color: Colors.yellow.withOpacity(0.3),
          ),
          SizedBox(height: 20,),
          ListTile(
            title: Text(
              'Gestion des utilisateurs',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Naviguer vers la page de gestion des utilisateurs
            },
          ),
          Divider(
            color: Colors.yellow.withOpacity(0.3),
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text(
              'Gestion des tâches',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Naviguer vers la page de gestion des tâches
            },
          ),
          Divider(
            color: Colors.yellow.withOpacity(0.3),
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text(
              'Paramètres de notification',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Naviguer vers la page des paramètres de notification
            },
          ),
          Divider(
            color: Colors.yellow.withOpacity(0.3),
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text(
              'Paramètres de l\'application',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Naviguer vers la page des paramètres de l'application
            },
          ),
          Divider(
            color: Colors.yellow.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
