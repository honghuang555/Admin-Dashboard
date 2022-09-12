class Client {
  String id;
  String name;
  String phone;

  Client({
    required this.id,
     required this.name,
     required this.phone
  });

  factory Client.fromFirebase(var json, String id) => Client(
    id: id,
    name: json['name'] ?? '',
    phone: json['phone']??''
  );

  Map<String, dynamic> toFirebaseMap() => {
    'name': name,
    'phone':phone
  };
}