import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class SosService {
  /// Sends SOS to a list of phone numbers
  static Future<void> sendSOS(List<String> phoneNumbers) async {
    try {
      // 1️⃣ Get current location
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 2️⃣ Compose the SOS message with Google Maps link
      final message =
          'SOS! I am in danger.\nMy location:\nhttps://maps.google.com/?q=${position.latitude},${position.longitude}';

      // 3️⃣ Send SMS to each contact
      for (var phone in phoneNumbers) {
        final smsUri = Uri(
          scheme: 'sms',
          path: phone,
          queryParameters: {'body': message},
        );

        if (await canLaunchUrl(smsUri)) {
          await launchUrl(smsUri);
        } else {
          print('Cannot launch SMS for $phone');
        }
      }
    } catch (e) {
      print('Error sending SOS: $e');
    }
  }
}
