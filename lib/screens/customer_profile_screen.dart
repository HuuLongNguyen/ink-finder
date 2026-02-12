import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ink_finder/features/auth/presentation/pages/login_page.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ShadButton.ghost(
            child: const Icon(LucideIcons.settings),
            onPressed: () {
              // Navigate to full settings if needed, or keeping it inline
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Profile Header
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://github.com/shadcn.png"), // Placeholder
            ),
            const SizedBox(height: 16),
            Text("Alex Nguyen", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text("Ink Enthusiast", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 24),
            
            // Edit Profile Button
            ShadButton.outline(
              width: double.infinity,
              child: const Text("Edit Profile"),
              onPressed: () {},
            ),
            const SizedBox(height: 32),

            // Settings Sections
            _buildSectionHeader(context, "Preferences"),
            _buildSettingItem(context, LucideIcons.bell, "Notifications", " manage push alerts"),
            _buildSettingItem(context, LucideIcons.palette, "Style DNA", " neo-traditional, blackwork"),
            _buildSettingItem(context, LucideIcons.moon, "Appearance", " Dark Mode"),

            const SizedBox(height: 24),
            _buildSectionHeader(context, "Account"),
            _buildSettingItem(context, LucideIcons.calendar, "Booking History", " Past and upcoming appointments"),
            _buildSettingItem(context, LucideIcons.lock, "Privacy & Security", ""),
            _buildSettingItem(context, LucideIcons.globe, "Language", " English (US)"),

            const SizedBox(height: 24),
            _buildSectionHeader(context, "Support"),
            _buildSettingItem(context, LucideIcons.info, "Help Center", ""),
            _buildSettingItem(context, LucideIcons.messageSquare, "Send Feedback", ""),

            const SizedBox(height: 32),
            ShadButton.destructive(
              width: double.infinity,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.logOut, size: 16),
                  SizedBox(width: 8),
                  Text("Log Out"),
                ],
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title, String subtitle) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ShadCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), // Slim card like a list tile
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: theme.colorScheme.onSurface),
          ),
          title: Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
          subtitle: subtitle.isNotEmpty ? Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)) : null,
          trailing: Icon(LucideIcons.chevronRight, size: 16, color: theme.colorScheme.onSurfaceVariant),
          onTap: () {},
        ),
      ),
    );
  }
}
