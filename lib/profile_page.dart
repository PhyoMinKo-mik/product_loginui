import 'package:flutter/material.dart';
import 'package:product_loginui/user_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserManager.instance.currentUser;
    final personalData = UserManager.instance.personalData;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/image/CatBatman.jpg'),
          ),
          const SizedBox(height: 12),
          // Text(
          //   personalData?['fullName'] ?? user.userName,
          //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(height: 4),
          // Text(
          //   personalData?['email'] ?? user.email,
          //   style: TextStyle(color: Colors.grey[700]),
          // ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: [
                  _buildTile(Icons.edit, 'Edit Profile', () {}),
                  _buildTile(Icons.shopping_bag, 'Order History', () {}),
                  _buildTile(Icons.settings, 'Settings', () {}),
                  _buildTile(Icons.lock, 'Change Password', () {}),
                  _buildTile(Icons.logout, 'Logout', () {
                    UserManager.instance.logout();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/Login',
                      (route) => false,
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 3),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: const Color.fromARGB(
              255,
              110,
              84,
              57,
            ).withOpacity(0.1),
            child: Icon(icon, color: const Color.fromARGB(255, 138, 136, 133)),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
