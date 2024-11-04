import 'package:adminapp/login.dart';
import 'package:adminapp/pages/dashboard_page.dart';
import 'package:adminapp/pages/table.dart';
import 'package:adminapp/signout.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarState createState() => _SidebarState();
}
class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 60, 59, 59),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              child: const Row(
                children: [
                  Icon(Icons.dashboard, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Admin Dashboard',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              index: 0, 
              onTap: () {
                setState(() {
                  _selectedIndex = 0; 
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.table_chart,
              text: 'Tables',
              index: 5,
              onTap: () {
                setState(() {
                  _selectedIndex = 5; 
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TablesPageW()),
                );
              },
            ),
             _buildDrawerItem(
              icon: Icons.login,
              text: 'Sign In',
              index: 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 2; 
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
             _buildDrawerItem(
              icon: Icons.logout,
              text: 'Sign Out',
              index: 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3; 
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Signout()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 11, 114, 198),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('UPGRADE TO PRO'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required int index,
    required VoidCallback onTap,
  }) {
    final isSelected = _selectedIndex == index; 
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.white),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.white,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }
}


















