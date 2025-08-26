import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: const [
            Text(
              "1. Introduction",
              style: TextStyle(
                color: Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We value your privacy and are committed to protecting your personal data. This policy explains how we collect, use, and safeguard your information.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "2. Information We Collect",
              style: TextStyle(
                color: Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "- Personal details (e.g., name, email)\n"
              "- Usage data (e.g., app activity)\n"
              "- Device information (e.g., OS version, model)",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "3. How We Use Your Data",
              style: TextStyle(
                color: Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "- To provide and maintain the app\n"
              "- To improve user experience\n"
              "- To send important notifications\n"
              "- For security and legal compliance",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "4. Data Sharing",
              style: TextStyle(
                color: Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We do not sell or rent your personal information. We may share data with trusted partners for functionality, legal compliance, or app analytics.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "5. Data Security",
              style: TextStyle(
                color: Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We implement reasonable security measures to protect your data from unauthorized access or misuse.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "6. Your Rights",
              style: TextStyle(
                color: Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "You have the right to access, correct, or delete your personal information. You may also request us to stop using your data.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),

            Text(
              "7. Changes to This Policy",
              style: TextStyle(
                color: Color(0xFFB8D8C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "We may update this privacy policy from time to time. You will be notified of any significant changes.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 32),

            Center(
              child: Text(
                "Last updated: June 25, 2025",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
