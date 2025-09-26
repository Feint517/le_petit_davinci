import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

class Auth0ProfileView extends StatelessWidget {
  const Auth0ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // User Name
                  Text(
                    'User',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // User Email
                  Text(
                    'user@example.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Profile Actions
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person_outline),
                            title: const Text('Edit Profile'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.sync),
                            title: const Text('Sync Profile'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: const Text('Profile Info'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Logout Button
                  CustomButton(
                    label: 'Logout',
                    onPressed: () {},
                    variant: ButtonVariant.warning,
                    isLoading: false,
                  ),
                ],
              ),
            ),
    );
  }

}
