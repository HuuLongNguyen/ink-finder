import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ink_finder/core/models/studio.dart';
import 'package:ink_finder/screens/studio_profile.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  // Ho Chi Minh City Center
  final LatLng _initialCenter = const LatLng(10.7769, 106.7009);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                // Use CartoDB Dark Matter for that 'Edgy' dark mode look
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                // FOR GOONG MAPS (Vietnam Specific):
                // urlTemplate: 'https://tiles.goong.io/assets/goong_map_dark/{z}/{x}/{y}.png?api_key=YOUR_GOONG_API_KEY',
              ),
              MarkerLayer(
                markers: mockStudios.map((studio) {
                  return Marker(
                    point: LatLng(studio.latitude, studio.longitude),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        _showStudioPreview(studio);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          LucideIcons.flame,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: ShadCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                   Icon(LucideIcons.search, color: theme.colorScheme.onSurfaceVariant),
                   const SizedBox(width: 12),
                   Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search studios, style, or artist...",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.slidersHorizontal, color: theme.colorScheme.primary),
                    onPressed: () {
                      // Show filters bottom sheet
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStudioPreview(Studio studio) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ShadCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(studio.imageUrl),
                  radius: 30,
                ),
                title: Text(studio.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(studio.address, maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: Icon(LucideIcons.chevronRight, color: theme.colorScheme.onSurfaceVariant, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => StudioProfileScreen(studio: studio)),
                  );
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat(LucideIcons.star, "${studio.rating}", "Rating"),
                    _buildStat(LucideIcons.dollarSign, "\$\$", "Price"),
                    _buildStat(LucideIcons.car, "12 min", "Drive"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ShadButton(
                width: double.infinity,
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => StudioProfileScreen(studio: studio)),
                  );
                },
                child: const Text("VIEW PROFILE"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 20),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
