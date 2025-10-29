import 'package:flutter/material.dart';
import '../widgets/contact_list_widget.dart';
import '../widgets/contact_form_widget.dart';

class MainContactPage extends StatefulWidget {
  const MainContactPage({super.key});

  @override
  State<MainContactPage> createState() => _MainContactPageState();
}

class _MainContactPageState extends State<MainContactPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    // 0 - Contacts
    Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: ContactListWidget(),
    ),
    // 1 - Create
    SingleChildScrollView(
      child: ContactFormWidget(),
    ),
    // 2 - Parameters
    Center(child: Text('Paramètres (à implémenter)', style: TextStyle(fontSize: 18))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.people),
            icon: Icon(Icons.people_outline),
            label: 'Contacts',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.create),
            icon: Icon(Icons.create_outlined),
            label: 'Create',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Parameters',
          ),
        ],
      ),
    );
  }
}
