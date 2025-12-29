import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/sos_button.dart';
import '../widgets/action_button.dart';
import '../services/alert_service.dart';
import '../services/location_service.dart';
import 'message_contacts_screen.dart';
import 'safety_tips_screen.dart';
import 'live_map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AlertService _alertService = AlertService();
  final LocationService _locationService = LocationService();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Load username & email from Firestore
  void _loadUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final doc = await _firestore.collection('users').doc(uid).get();
      setState(() {
        username = doc['username'] ?? '';
        email = doc['email'] ?? '';
      });
    }
  }

  /// CENTRAL SOS LOGIC
  Future<void> _handleSOS(BuildContext context) async {
    await _alertService.sendSOSAlert(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LiveMapScreen(),
      ),
    );
  }

  /// LOGOUT USER
  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      appBar: AppBar(
        title: const Text('Safety for All'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (username.isNotEmpty)
                Text(
                  'Hello, $username',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText),
                ),
              const SizedBox(height: 40),

              SOSButton(onPressed: () => _handleSOS(context)),

              const SizedBox(height: 20),
              const Text(
                'Send an alert',
                style: TextStyle(fontSize: 20, color: AppColors.darkText),
              ),

              const SizedBox(height: 50),

              ActionButton(
                icon: Icons.location_on,
                text: 'Share Location',
                onTap: () => _locationService.shareLocation(context),
              ),
              const SizedBox(height: 15),

              ActionButton(
                icon: Icons.message,
                text: 'Message Contacts',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageContactsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),

              ActionButton(
                icon: Icons.phone,
                text: 'Call Hotline',
                onTap: () => _alertService.showHotlineOptions(context),
              ),
              const SizedBox(height: 15),

              ActionButton(
                icon: Icons.info,
                text: 'Safety Tips',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SafetyTipsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
