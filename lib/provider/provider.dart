import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashScreen = StateProvider<bool>((state) => true);
final isLogedIn = StateProvider<bool>((state) => false);

final visualProvider = StateProvider<List<Map<String, dynamic>>>((state) {
  return [
    {
      "name": "Front",
      "type": "visual_check",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "name": "Near side",
      "type": "visual_check",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "name": "Rear",
      "type": "visual_check",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "name": "Off-Side",
      "type": "visual_check",
      "image": [],
      "comment": "",
      "status": true
    }
  ];
});
final cabinProvider = StateProvider<List<Map<String, dynamic>>>((state) {
  return [
    {
      "type": "Cabin Checks",
      "name": "Steering",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Cabin Checks",
      "name": "Wipers",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Cabin Checks",
      "name": "Washers",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Cabin Checks",
      "name": "Horn",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Cabin Checks",
      "name": "Mirrors / Glass / Visibility",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Cabin Checks",
      "name": "Truck Interior / Seat Belts",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Cabin Checks",
      "name": "Warning Lamps / MIL",
      "image": [],
      "comment": "",
      "status": true
    },
  ];
});
final vehicleProvider = StateProvider<List<Map<String, dynamic>>>((state) {
  return [
    {
      "type": "Vehicle Checks",
      "name": "Adblue levels",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Vehicle Checks",
      "name": "Fuel/Oil Leaks",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Vehicle Checks",
      "name": "Lights",
      "image": [],
      "comment": "",
      "status": true
    },
    {
      "type": "Vehicle Checks",
      "name": "Indicators / Signals",
      "image": [],
      "comment": "",
      "status": true
    },
  ];
});

final userProvider = StateProvider<List<dynamic>>((state) {
  return [];
});
final vehicleDetailProvider = StateProvider<List<dynamic>>((state) {
  return [];
});
final assignDetailProvider = StateProvider<List<dynamic>>((state) {
  return [];
});
final token = StateProvider<String>((state) {
  return "";
});
final milage = StateProvider<String>((state) {
  return "";
});
