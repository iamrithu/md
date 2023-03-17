import 'package:flutter_riverpod/flutter_riverpod.dart';

final visualProvider = StateProvider<List<Map<String, dynamic>>>((state) {
  return [
    // {
    //   "type": "visualCheck",
    //   "name":"Front",
    //   "image":[],
    //   "comment":"",
    //     "status":false
    // }
  ];
});
final cabinProvider = StateProvider<List<Map<String, dynamic>>>((state) {
  return [
    // {
    //   "type": "visualCheck",
    //   "name":"Front",
    //   "image":[],
    //   "comment":""
    // }
  ];
});
final vehicleProvider = StateProvider<List<Map<String, dynamic>>>((state) {
  return [
    // {
    //   "type": "visualCheck",
    //   "name":"Front",
    //   "image":[],
    //   "comment":""
    // }
  ];
});
