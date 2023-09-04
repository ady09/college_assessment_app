

import 'package:cloud_firestore/cloud_firestore.dart';

class Details {
  String city;
  String state;
  String type;
  String college;
  int? pincode;
  int? color;
  int? isCompleted;
  final Timestamp timestamp;

  Details({
    required this.city,
    required this.type,
    required this.state,
    required this.college,
    required this.pincode,
    required this.timestamp,
             this.color,
             this.isCompleted,      
  });

  Map<String, dynamic> toJson() => {
        "city": city,
        "type": type,
        "state": state,
        "college": college,
        "pincode": pincode,
        'timestamp': timestamp,
        "color": color,
        "isCompleted": isCompleted
      };
  

  factory Details.fromJson(Map<String, dynamic> map) {
    int? pincode;
  if (map['pincode'] is int) {
    pincode = map['pincode'];
  } else if (map['pincode'] is String) {
    int? parsedPincode = int.tryParse(map['pincode']);
    if (parsedPincode != null) {
      pincode = parsedPincode;
    }
  }
    return Details(
      city: map['city'],
      type: map['type'],
      state: map['state'],
      college: map['college'],
      pincode: pincode,
      timestamp: map['timestamp'],
      color:map['color'],
      isCompleted: map['isCompleted'],
    );
  }
}
