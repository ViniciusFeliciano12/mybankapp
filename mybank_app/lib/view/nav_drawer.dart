import 'package:flutter/material.dart';
import 'package:mybank_app/utils/navigation.dart';
import 'package:mybank_app/view/home_page.dart';
import 'package:mybank_app/view/register_page.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 55),
          const Center(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Home page'),
            onTap: () {
              if (index == 0) {
                return;
              }
              navigateWithSlideTransition(context, const MyHomePage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Profile'),
            onTap: () {
              navigateWithSlideTransition(context, const RegisterPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
