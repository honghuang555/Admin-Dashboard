import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Package {
  String service;
  String timestamp;

  Package({required this.service, required this.timestamp});

  factory Package.fromFirebase(var json) {
    Package package = new Package(
      service: json['service'] ?? '',
      timestamp: json['timestamp']??DateTime.now().toString()
    );
    return package;
  }

  Map<String, dynamic> toMap() => {
        'service': service,
        'timestamp':timestamp
      };
}
