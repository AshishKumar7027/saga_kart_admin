import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saga_kart_admin/authentication/provider/auth_provider.dart';
import 'package:saga_kart_admin/authentication/view/login_screen.dart';
import 'package:saga_kart_admin/dashboard/view/dashboard_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, child) {
          return Center(
            child: Column(
              children: [
                IconButton(
                  onPressed: () async {
                    await provider.logout();
                    if (context.mounted) {
                      if (provider.errorMessage == null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LogInScreen(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DashboardScreen(),
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 50,
                  ),
                ),
                SizedBox(height: 16),
                Text('Log Out'),
              ],
            ),
          );
        }),
      ),
    );
  }
}
