
import 'package:adminapp/widgets/navbar.dart';
import 'package:adminapp/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          appBar: isLargeScreen
              ? null
              : const PreferredSize(
                  preferredSize: Size.fromHeight(60.0),
                  child: Navbar(pageTitle: 'Dashboard'),
                ),
          drawer: isLargeScreen ? null : const Sidebar(), 
          body: Row(
            children: [
              if (isLargeScreen) const Sidebar(), 
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to the Dashboard',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 109, 105, 105),
        
        );
      },
    );
  }
}










