import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/sos_button.dart';
import '../widgets/action_button.dart';
import '../services/alert_service.dart';
import '../services/location_service.dart';
import 'message_contacts_screen.dart';
import 'safety_tips_screen.dart';
import 'live_map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AlertService _alertService = AlertService();
  final LocationService _locationService = LocationService();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      appBar: AppBar(
        title: const Text('Safety for All'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
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
