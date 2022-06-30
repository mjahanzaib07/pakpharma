
import 'organization.dart';

class User {
  final String? loginid;
  final String name;
  final bool admin;
  final Organization organization;


  User( {
    required this.name,
    required this.admin,
    required this.organization,
    this.loginid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      loginid: json["LoginId"].toString(),
      name: json["UserName"].toString(),
      admin: json["Roles"]["Admin"],
      organization: Organization.fromJson(json['organizations']),
      
    );
  }
}

// class User {
//   final String token;
//   final String id;
//   final String datecreate;
//   final String name;
//   final String email;
//   final String password;
//   final String inscriptionNumber;
//   final String dateJoined;
//   final String userAdmin;
//   final String userActive;
//   final String message;
//   final String? errors;
//   final String expireDate;
//   User(
//       {required this.id,
//       required this.datecreate,
//       required this.name,
//       required this.email,
//       required this.password,
//       required this.inscriptionNumber,
//       required this.dateJoined,
//       required this.userAdmin,
//       required this.userActive,
//       required this.token,
//       required this.message,
//       this.errors,
//       required this.expireDate});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       token: json["document"]['access_token'].toString(),
//       message: json['message'].toString(),
//       errors: json['errors'].toString(),
//       expireDate: json["document"]['expires_in'].toString(),
//       email: json["user"]['user_email'].toString(),
//       id: json["user"]['user_id'].toString(),
//       userActive: json["user"]['user_active'].toString(),
//       password: json["user"]['user_password'].toString(),
//       name: json["user"]['user_name'].toString(),
//       dateJoined: json["user"]['user_date_joined'].toString(),
//       inscriptionNumber: json["user"]['user_inscription_number'].toString(),
//       datecreate: json["user"]['user_date_created'].toString(),
//       userAdmin: json["user"]['user_admin'].toString(),
//     );
//   }
// }
//
// // class User {
// //   final String token;
// //   final String message;
// //   final bool isSuccess;
// //   final String? errors;
// //   final String expireDate;
// //
// //   User({required this.token, required this.message,required this.isSuccess, this.errors, required this.expireDate});
// //
// //   factory User.fromJson(Map<String, dynamic> json) {
// //     return User(
// //       token: json['token'],
// //       message: json['message'],
// //       isSuccess: json['isSuccess'],
// //       errors:json['errors'],
// //       expireDate:json['expireDate'],
// //
// //     );
// //   }
// //
// // }
