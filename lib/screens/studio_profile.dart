import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ink_finder/core/models/studio.dart';

class StudioProfileScreen extends StatelessWidget {
  final Studio studio;

  const StudioProfileScreen({super.key, required this.studio});

  Future<void> _launchZalo() async {
    // Zalo deep link scheme: https://zalo.me/[phone_number]
    final Uri url = Uri.parse('https://zalo.me/${studio.phone}');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            iconTheme: theme.iconTheme,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: studio.imageUrl,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withOpacity(0.3),
              ),
              title: Text(studio.name, style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white)),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.star, color: theme.colorScheme.primary, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "${studio.rating} (${studio.reviewsCount} Reviews)",
                        style: theme.textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      if (studio.isPremium)
                        ShadBadge(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          child: const Text("Verified Studio"),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ShadButton(
                          onPressed: _launchZalo,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.messageCircle, size: 16),
                              SizedBox(width: 8),
                              Text("Chat on Zalo"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ShadButton.outline(
                          onPressed: () {},
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.bookmark, size: 16),
                              SizedBox(width: 8),
                              Text("Save"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text("About", style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    "Top-tier tattoo studio specializing in Neo-Traditional and Blackwork. Clean, sterile environment with award-winning artists.",
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  Text("Location", style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(LucideIcons.mapPin, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Expanded(child: Text(studio.address, style: theme.textTheme.bodyMedium)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text("Gallery", style: theme.textTheme.titleLarge),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ShadCard(
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: "https://images.unsplash.com/photo-1598371839696-5c5bb00bdc28?q=80&w=2671&auto=format&fit=crop",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                childCount: 9,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}
