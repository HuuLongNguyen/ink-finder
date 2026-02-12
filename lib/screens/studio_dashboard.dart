import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ink_finder/screens/premium_subscription.dart';

class StudioDashboardScreen extends StatelessWidget {
  const StudioDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('STUDIO DASHBOARD'),
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [
          ShadButton.ghost(
            child: const Icon(LucideIcons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPremiumBanner(context),
            const SizedBox(height: 24),
            Text("Overview", style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, "Profile Views", "1,204", LucideIcons.eye, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, "Zalo Clicks", "86", LucideIcons.messageCircle, Colors.green)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, "Favorites", "42", LucideIcons.heart, Colors.pink)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, "Rating", "4.8", LucideIcons.star, Colors.amber)),
              ],
            ),
            const SizedBox(height: 32),
            Text("Quick Actions", style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            _buildActionTile(context, LucideIcons.camera, "Upload New Work", "Add photos to your portfolio"),
            _buildActionTile(context, LucideIcons.pencil, "Edit Profile", "Update studio details"),
            _buildActionTile(context, LucideIcons.megaphone, "Promote Studio", "Boost visibility with ads"),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBanner(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      padding: const EdgeInsets.all(20),
      backgroundColor: theme.colorScheme.primaryContainer,
      border: ShadBorder.all(color: theme.colorScheme.primary),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Go Premium",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Unlock advanced analytics, verified badge, and priority listing.",
                  style: TextStyle(color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8)),
                ),
                const SizedBox(height: 16),
                ShadButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PremiumSubscriptionScreen()),
                    );
                  },
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  child: const Text("UPGRADE NOW"),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Icon(LucideIcons.gem, size: 60, color: theme.colorScheme.onPrimaryContainer.withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          Text(title, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, IconData icon, String title, String subtitle) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ShadCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: theme.colorScheme.onSurface),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
          trailing: Icon(LucideIcons.chevronRight, size: 16, color: theme.colorScheme.onSurfaceVariant),
          onTap: () {},
        ),
      ),
    );
  }
}
