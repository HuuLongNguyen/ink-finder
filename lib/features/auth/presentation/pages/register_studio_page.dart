import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterStudioPage extends StatefulWidget {
  const RegisterStudioPage({Key? key}) : super(key: key);

  @override
  _RegisterStudioPageState createState() => _RegisterStudioPageState();
}

class _RegisterStudioPageState extends State<RegisterStudioPage> {
  final _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  // Form Fields
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _studioName = TextEditingController();
  final _ownerName = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _specializations = <String>[];
  String? _selectedLicense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Register Studio'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ShadCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Basic Info", style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  ShadInput(
                    controller: _studioName,
                    placeholder: const Text("Studio Name"),
                    leading: const Padding(padding: EdgeInsets.all(4.0), child: Icon(LucideIcons.store, size: 16)),
                  ),
                  const SizedBox(height: 16),
                  ShadInput(
                    controller: _ownerName,
                    placeholder: const Text("Owner Full Name"),
                    leading: const Padding(padding: EdgeInsets.all(4.0), child: Icon(LucideIcons.user, size: 16)),
                  ),
                  const SizedBox(height: 16),
                  ShadInput(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    placeholder: const Text("Contact Number (VN)"),
                    leading: const Padding(padding: EdgeInsets.all(4.0), child: Icon(LucideIcons.phone, size: 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
             ShadCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location", style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  ShadInput(
                    controller: _address,
                    placeholder: const Text("Studio Address"),
                    minLines: 2,
                    maxLines: 4,
                    leading: const Padding(padding: EdgeInsets.all(4.0), child: Icon(LucideIcons.mapPin, size: 16)),
                  ),
                  const SizedBox(height: 12),
                  ShadButton.outline(
                    width: double.infinity,
                    onPressed: () {
                      // Open Map Dialog Placeholder
                      _showMapPicker(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.map, size: 16),
                        SizedBox(width: 8),
                        Text("Pick on Map"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ShadCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Specialization", style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildChip("Traditional"),
                      _buildChip("Realism"),
                      _buildChip("Fine-line"),
                      _buildChip("Blackwork"),
                      _buildChip("Minimalist"),
                      _buildChip("Japanese"),
                    ],
                  ),
                ],
              ),
            ),
             const SizedBox(height: 16),
            ShadCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Verification", style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text("Upload your Business License or Health Certificate to get verified.", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  ShadButton.outline(
                    width: double.infinity,
                    onPressed: () {
                      // File Picker Logic
                      setState(() {
                         _selectedLicense = "license_doc.pdf";
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(LucideIcons.upload, size: 16),
                        const SizedBox(width: 8),
                        Text(_selectedLicense ?? "Upload Document"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ShadButton(
              width: double.infinity,
              size: ShadButtonSize.lg,
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              onPressed: () {
                // Submit Form
                Navigator.pop(context); // Go back to Login or Dashboard
              },
              child: const Text("Submit Application"),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    final theme = Theme.of(context);
    final isSelected = _specializations.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _specializations.remove(label);
          } else {
            _specializations.add(label);
          }
        });
      },
      child: ShadBadge(
        backgroundColor: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
        foregroundColor: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
        child: Text(label),
      ),
    );
  }

  void _showMapPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text("Select Location"),
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.grey[800],
              child: const Center(child: Text("Map Integration Placeholder (Goong Maps)")),
            ),
            const SizedBox(height: 16),
            ShadButton(
              child: const Text("Confirm Location"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
