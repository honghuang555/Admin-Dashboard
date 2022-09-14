import 'package:admin/models/package.dart';

class Client {
  String id;
  String name;
  String phone;
  List<Package> package;

  Client({
    required this.id,
     required this.name,
     required this.phone,
     required this.package
  });

  factory Client.fromFirebase(var json, String id) => Client(
    id: id,
    name: json['name'] ?? '',
    phone: json['phone']??'',
    package: List<Package>.from(
          (json['package'] ?? []).map((x) => Package.fromFirebase(x))),
  );

  Map<String, dynamic> toFirebaseMap() => {
    'name': name,
    'phone':phone,
    'package':package != null
            ? List.from(package.map((x) => x.toMap()))
            : []
  };
}