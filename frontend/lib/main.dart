import 'package:adminapp/pages/table.dart';
import 'package:adminapp/signout.dart';
import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'pages/dashboard_page.dart';
import 'login.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const Initials(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/logout': (context) => const Signout(),
        '/tab': (context) => const  TablesPageW()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Initials extends StatelessWidget {
  const Initials({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Navbar(pageTitle: 'Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Navbar(pageTitle: 'SignIn Page'),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: LoginScreen(),
                 ), 
                ],
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}



