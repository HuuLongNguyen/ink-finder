import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PremiumSubscriptionScreen extends StatelessWidget {
  const PremiumSubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('UPGRADE TO PRO'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(LucideIcons.gem, size: 80, color: theme.colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              "Unlock InkFinder Premium",
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Get verified, boost your studio visibility, and access advanced analytics.",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            _buildPlanCard(
              context,
              "Monthly",
              "299,000 VND / month",
              ["Verified Badge", "Priority Listing", "Analytics Dashboard"],
              isBestValue: false,
            ),
            const SizedBox(height: 24),
            _buildPlanCard(
              context,
              "Yearly (Save 20%)",
              "2,990,000 VND / year",
              ["All Monthly Features", "Feature on Homepage", "Dedicated Support"],
              isBestValue: true,
            ),
            const SizedBox(height: 40),
            Text(
              "Secured by VietQR",
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(
      BuildContext context, String title, String price, List<String> features,
      {bool isBestValue = false}) {
    final theme = Theme.of(context);
    return ShadCard(
      padding: const EdgeInsets.all(24),
      border: isBestValue ? ShadBorder.all(color: theme.colorScheme.primary, width: 2) : null,
      backgroundColor: isBestValue ? theme.colorScheme.primaryContainer.withOpacity(0.1) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isBestValue)
            Align(
              alignment: Alignment.topRight,
              child: ShadBadge(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                child: const Text("BEST VALUE"),
              ),
            ),
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(price, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 24),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(LucideIcons.check, color: theme.colorScheme.primary, size: 20),
                    const SizedBox(width: 12),
                    Text(f, style: theme.textTheme.bodyMedium),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          ShadButton(
            onPressed: () => _showPaymentDialog(context, price),
            backgroundColor: isBestValue ? theme.colorScheme.primary : theme.colorScheme.secondary,
            foregroundColor: isBestValue ? theme.colorScheme.onPrimary : theme.colorScheme.onSecondary,
            child: const Text("CHOOSE PLAN"),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, String amount) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return ShadDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Scan to Pay", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Open your banking app and scan this QR code.", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: QrImageView(
                  data: "00020101021238570010A00000072701270006970422011312345678901230208QRIBFTTA5303704540410005802VN6304D1BB", // Mock VietQR payload
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              const SizedBox(height: 24),
              CircularProgressIndicator(color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text("Waiting for payment...", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        );
      },
    );
  }
}
