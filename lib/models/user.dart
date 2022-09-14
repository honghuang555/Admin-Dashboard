
//user types, pending means account not approved
enum UserType { Admin, Sales, Operations, pending, denied }

class AppUser {
  String id;
  String email;
  String name;
  String phone;
  UserType userType;
  String profileImage;

  AppUser(
      {required this.id,
        required this.email,
        required this.name,
        required this.phone,
        required this.userType,
        required this.profileImage
      });

  factory AppUser.fromFirebase(var json, String id) => AppUser(
    id: id,
    email: json['email'] ?? '',
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
    userType: stringToEnum(json['userType']),
    profileImage: json['profileImage']??''
  );

  static UserType stringToEnum(String userType) {
    if (userType == 'Operations') return UserType.Operations;
    if (userType == 'Sales') return UserType.Sales;
    if (userType == 'Admin') return UserType.Admin;
    if (userType == 'pending') return UserType.pending;
    if (userType == 'denied') return UserType.denied;
    return UserType.Admin;
  }

  String getUserType() {
    return userType.toString().split('.')[1];
  }
}
