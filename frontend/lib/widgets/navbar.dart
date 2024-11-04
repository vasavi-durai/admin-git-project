import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final String pageTitle;

  const Navbar({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 600; 
        return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pageTitle,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              if (isSmallScreen)
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              if (!isSmallScreen)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}



