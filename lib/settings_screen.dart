import 'package:flutter/material.dart';
import 'package:settings/AppVersionScreen.dart';
import 'package:settings/bank_accounts_screen.dart';
import 'package:settings/biometric_auth_screen.dart';
import 'package:settings/change_password.dart';
import 'package:settings/faq_screen.dart';
import 'package:settings/kyc_verification_screen.dart';
import 'package:settings/privacy_policy_screen.dart';
import 'package:settings/report_issue_screen.dart';
import 'package:settings/terms_conditions_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricPreference();
  }

  Future<void> _loadBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _biometricEnabled = prefs.getBool('biometric_enabled') ?? false;
    });
  }

  void showEmailOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            const Text(
              "Contact via",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: Image.asset('assets/gmail.png', height: 24),
              title: const Text("Gmail", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                launchEmailSupport();
              },
            ),
            ListTile(
              leading: Image.asset('assets/outlook.png', height: 24),
              title: const Text(
                "Outlook",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                launchEmailSupport();
              },
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void launchEmailSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@kube.com',
      query: Uri.encodeFull(
        'subject=Support Request&body=Hi Team,\n\nI need help with...',
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint("Could not launch email");
    }
  }

 
  Widget buildTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    String? subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFB8D8C1)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle:
          subtitle != null
              ? Text(subtitle, style: const TextStyle(color: Colors.grey))
              : null,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: const Color(0xFFB8D8C1),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text("App Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SizedBox(height: 10),
         

          sectionTitle("Account Settings"),
          buildTile(context, Icons.badge, "Verify Identity", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => KycVerificationScreen()),
            );
          }),
          buildTile(context, Icons.account_balance, "Bank Accounts", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BankAccountsScreen()),
            );
          }),
          buildTile(context, Icons.link, "UPI ID Management", () {}),

          sectionTitle("Privacy & App Security"),
          buildTile(
            context,
            Icons.fingerprint,
            "Biometric Authentication",
            () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BiometricAuthScreen()),
              );
              _loadBiometricPreference();
            },
            subtitle: _biometricEnabled ? 'Enabled' : 'Disabled',
          ),
          buildTile(context, Icons.shield, "App Lock", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
            );
          }),
          buildTile(context, Icons.policy, "Privacy Policy", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
            );
          }),
          buildTile(context, Icons.settings_applications, "Permissions", () {}),

          sectionTitle("Notifications"),
          buildTile(context, Icons.notifications, "Payment Alerts", () {}),
          buildTile(context, Icons.system_update, "App Updates", () {}),

          sectionTitle("Help & Support"),
          buildTile(context, Icons.help, "FAQs", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FAQScreen()),
            );
          }),
          buildTile(context, Icons.support_agent, "Contact Support", () {
            showEmailOptions(context);
          }),
          buildTile(context, Icons.report_problem, "Report an Issue", () {
            showModalBottomSheet(
              context: context,
              backgroundColor: const Color(0xFF1E1E1E),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      "Choose a method",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const Divider(color: Colors.grey),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.redAccent),
                      title: const Text(
                        "Send via Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        launchEmailSupport();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.edit, color: Colors.blueAccent),
                      title: const Text(
                        "Report via Form",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReportIssueScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            );
          }),

          sectionTitle("About"),
          buildTile(context, Icons.info, "App Version", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AppVersionScreen()),
            );
          }),
          buildTile(context, Icons.description, "Terms & Conditions", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TermsAndConditionsScreen(),
              ),
            );
          }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
