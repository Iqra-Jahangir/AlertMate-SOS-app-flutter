import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LiveMapScreen extends StatefulWidget {
  const LiveMapScreen({super.key});

  @override
  State<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen> {
  Position? _position;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _position = pos;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live SOS Location')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            _position!.latitude,
            _position!.longitude,
          ),
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mylaststringofsanity',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                  _position!.latitude,
                  _position!.longitude,
                ),
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_pin,
                  size: 50,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
