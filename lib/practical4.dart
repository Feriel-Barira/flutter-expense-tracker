import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact_info_model.dart';
import 'package:provider/provider.dart';
import 'pages/main_contact_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContactInfoModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainContactPage(),
    );
  }
}
