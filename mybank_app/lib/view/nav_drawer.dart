import 'package:flutter/material.dart';
import 'package:mybank_app/utils/navigation.dart';
import 'package:mybank_app/view/home_page.dart';
import 'package:mybank_app/view/profile_page.dart';

import '../services/interfaces/irest_service.dart';
import '../services/service_locator.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key, required this.index});
  final int index;

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final IRestService _restService = getIt<IRestService>();
  bool hasAccount = false;

  void liberaNavegacao() {
    setState(() {
      var usuario = _restService.getLoggedInfo();
      if (usuario!.usuario != null) {
        hasAccount = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _restService.addListener(liberaNavegacao);
    setState(() {
      var usuario = _restService.getLoggedInfo();
      if (usuario!.usuario != null) {
        hasAccount = true;
      }
    });
  }

  @override
  void dispose() {
    _restService.removeListener(liberaNavegacao);
    super.dispose();
  }

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
              if (widget.index != 0) {
                navigateWithSlideTransition(context, const MyHomePage(), true);
              }
            },
          ),
          if (hasAccount)
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Profile'),
              onTap: () {
                if (widget.index != 1) {
                  navigateWithSlideTransition(
                      context, const ProfilePage(), true);
                }
              },
            ),
          if (hasAccount)
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          if (hasAccount)
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
