// class Advocate {
//   String uid;
//   String email;
//   String phoneNumber;
//   String displayName;
//   String  address;
//   String? barRegistrationNo;
//   String? barRegistrationCertificate;
//   bool isAdvocate;
//   String?experience;
//   String? skills;
//   String? charges;
//   String?introduction
// ;
//   Advocate({
//     required this.uid,
//     required this.email,
//     required this.phoneNumber,
//     required this.displayName,
//     required this.address,
//     this.barRegistrationNo,
//         this.introduction,
//     this.charges,
//     this.experience,
//     this.skills,
//     this.barRegistrationCertificate,
//     required this.isAdvocate
//   });

//   // Convert a User object to a Map object
//   Map<String, dynamic> toJson() => {
//         'uid': uid,
//         'email': email,
//         'displayName': displayName,
//         'address':address,
//         'phoneNumber':phoneNumber,
//         'barRegistrationNo':barRegistrationNo??"",
//         'barRegistrationCertificate': barRegistrationCertificate??"",
//         'isAdvocate':isAdvocate,
//   'introduction':introduction,
//         'charges':charges,
//         'skills':skills,
//         'experience':experience,
//       };

//   // Create a User object from a Map object
//   factory Advocate.fromJson(Map<String, dynamic> json) {
//     return Advocate(
//       uid: json['uid'],
//       email: json['email'],
//       displayName: json['displayName'],
//       phoneNumber: json['phoneNumber'],
//       barRegistrationNo: json['barRegistrationNo']??"",
//       barRegistrationCertificate: json['barRegistrationCertificate']??"",
//       address: json['address'],
//       isAdvocate:  json['isAdvocate'],
//            introduction:json ['introduction'],
//       charges:json['charges'],
//       skills: json['skills'],
//       experience:json['experience']
//     );
//   }
// }
// Advocate advocateClass= Advocate(uid: "", email: "", phoneNumber: "", displayName: "", address: "", isAdvocate: true);
