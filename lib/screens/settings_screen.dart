import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen ({ Key key, this.sharedPreference}): super(key: key);
  SharedPreferences sharedPreference;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: InkWell(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
            onTap: () {
              sharedPreference.remove("token");
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ),
      ],
    );
  }
}
