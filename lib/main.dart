import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ink_finder/core/theme/theme_data.dart';
import 'package:ink_finder/screens/home_screen.dart';
import 'package:ink_finder/screens/map_screen.dart';
import 'package:ink_finder/screens/studio_dashboard.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ink_finder/features/auth/presentation/pages/login_page.dart';
import 'package:ink_finder/screens/customer_profile_screen.dart';

import 'package:ink_finder/core/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

  runApp(const InkFinderApp());
}

class InkFinderApp extends StatelessWidget {
  const InkFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      title: 'InkFinder',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadZincColorScheme.dark(),
      ),
      home: Theme(
        data: AppTheme.darkTheme(),
        child: const LoginPage(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isStudio; // Add flag for user type

  const MainScreen({super.key, this.isStudio = false});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;
  late final List<NavigationDestination> _destinations;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      const MapScreen(),
      Container(), // Placeholder for Favorites/Messages
      if (widget.isStudio) const StudioDashboardScreen() else const CustomerProfileScreen(),
    ];

    _destinations = [
      const NavigationDestination(
        icon: Icon(LucideIcons.house),
        selectedIcon: Icon(LucideIcons.house, color: Colors.white),
        label: 'Explore',
      ),
      const NavigationDestination(
        icon: Icon(LucideIcons.mapPin),
        selectedIcon: Icon(LucideIcons.mapPin, color: Colors.white),
        label: 'Map',
      ),
      const NavigationDestination(
        icon: Icon(LucideIcons.heart),
        selectedIcon: Icon(LucideIcons.heart, color: Colors.white),
        label: 'Saved',
      ),
      if (widget.isStudio)
        const NavigationDestination(
          icon: Icon(LucideIcons.store),
          selectedIcon: Icon(LucideIcons.store, color: Colors.white),
          label: 'Studio',
        )
      else
        const NavigationDestination(
          icon: Icon(LucideIcons.user),
          selectedIcon: Icon(LucideIcons.user, color: Colors.white),
          label: 'Profile',
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(top: BorderSide(color: theme.dividerColor)),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: theme.colorScheme.primary.withOpacity(0.2),
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: _destinations,
        ),
      ),
    );
  }
}
