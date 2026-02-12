import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ink_finder/features/auth/presentation/pages/register_studio_page.dart';
import 'package:ink_finder/main.dart'; // To navigate to home after login

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isStudioLogin = false; // Toggle for Customer vs Studio Owner

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colorScheme.primary, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(LucideIcons.droplets, size: 40, color: theme.colorScheme.onPrimaryContainer),
                ),
              ),
              const SizedBox(height: 32),
              
              // Login Card
              ShadCard(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                // Glassmorphism effect via semi-transparent background if desired, keeping it simple heavily themed for now
                backgroundColor: theme.colorScheme.surface.withOpacity(0.9),
                border: ShadBorder.all(color: theme.dividerColor.withOpacity(0.2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _isStudioLogin ? "Studio Access" : "Welcome Back",
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter your details to continue",
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    
                    // Toggle User/Studio
                    Row(
                      children: [
                        Expanded(
                          child: ShadButton(
                            onPressed: () => setState(() => _isStudioLogin = false),
                            backgroundColor: !_isStudioLogin ? theme.colorScheme.primary : theme.colorScheme.surface,
                            foregroundColor: !_isStudioLogin ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                            child: const Text("Customer"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ShadButton(
                            onPressed: () => setState(() => _isStudioLogin = true),
                            backgroundColor: _isStudioLogin ? theme.colorScheme.primary : theme.colorScheme.surface,
                            foregroundColor: _isStudioLogin ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                            child: const Text("Studio Owner"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                  if (_isStudioLogin) ...[
                      ShadInput(
                        controller: _emailController,
                        placeholder: const Text("Email Address"),
                        leading: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(LucideIcons.mail, size: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ShadInput(
                        controller: _passwordController,
                        placeholder: const Text("Password"),
                        obscureText: _obscurePassword,
                        leading: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(LucideIcons.lock, size: 16),
                        ),
                        trailing: ShadButton.ghost(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Icon(
                            _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                            size: 16,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ShadButton.ghost(
                          onPressed: () {},
                          child: const Text("Forgot Password?"),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ShadButton(
                        width: double.infinity,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => MainScreen(isStudio: _isStudioLogin)),
                          );
                        },
                        child: const Text("Enter Studio Dashboard"),
                      ),
                    ] else ...[
                      // Customer Login Options
                      ShadButton.outline(
                        width: double.infinity,
                        onPressed: () {
                          // Mock Google Login
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const MainScreen(isStudio: false)),
                            );
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.globe, size: 16),
                            SizedBox(width: 8),
                            Text("Continue with Google"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: Divider(color: theme.dividerColor.withOpacity(0.5))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text("OR", style: theme.textTheme.labelSmall),
                          ),
                          Expanded(child: Divider(color: theme.dividerColor.withOpacity(0.5))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ShadInput(
                        controller: _emailController, // reusing controller for phone
                        placeholder: const Text("Phone Number (+84)"),
                        keyboardType: TextInputType.phone,
                        leading: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(LucideIcons.phone, size: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ShadButton(
                        width: double.infinity,
                        onPressed: () {
                           // Mock OTP Dialog
                           showDialog(
                             context: context,
                             builder: (context) => ShadDialog(
                               title: const Text("Enter OTP"),
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   const Text("We sent a code to your phone."),
                                   const SizedBox(height: 16),
                                   const ShadInput(placeholder: Text("123456"), textAlign: TextAlign.center),
                                   const SizedBox(height: 16),
                                   ShadButton(
                                     width: double.infinity,
                                     child: const Text("Verify & Login"),
                                     onPressed: () {
                                       Navigator.pop(context);
                                       Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (_) => const MainScreen(isStudio: false)),
                                        );
                                     },
                                   )
                                 ],
                               ),
                             ),
                           );
                        },
                        child: const Text("Send Code"),
                      ),
                    ],
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              if (_isStudioLogin)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have a studio account? ", style: theme.textTheme.bodyMedium),
                    ShadButton.ghost(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterStudioPage()),
                        );
                      },
                      child: Text("Register Here", style: TextStyle(color: theme.colorScheme.primary)),
                    ),
                  ],
                )
              else
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New to InkFinder? ", style: theme.textTheme.bodyMedium),
                    ShadButton.ghost(
                      onPressed: () {
                        // Navigate to generic registration (omitted for brevity)
                      },
                      child: Text("Create Account", style: TextStyle(color: theme.colorScheme.primary)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
