import 'AdvocateCall.dart';

class UserClass {
  String uid;
  String email;
  String phoneNumber;
  String displayName;
  String  address;
  String gender;
  String? barRegistrationNo;
  String? barRegistrationCertificate;
  String?experience;
  String? skills;
  String? charges;
  String?introduction;
  List<AdvocateCall>? advoacateCalls = [];
  //store this model in  local storage also and update list in user according to local storafe
  bool isAdvocate;

  UserClass({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.displayName,
    required this.address,
    required this.gender,
    this.barRegistrationNo,
    this.barRegistrationCertificate,
    this.introduction,
    this.charges,
    this.experience,
    this.skills,
    required this.isAdvocate,
   
  });

  // Convert a User object to a Map object
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'address':address,
        'gender': gender,
        'phoneNumber':phoneNumber,
        'barRegistrationNo':barRegistrationNo??"",
        'barRegistrationCertificate': barRegistrationCertificate??"",
        'isAdvocate':isAdvocate,
        'introduction':introduction,
        'charges':charges,
        'skills':skills,
        'experience':experience,

      };

  // Create a User object from a Map object
  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      barRegistrationNo: json['barRegistrationNo']??"",
      barRegistrationCertificate: json['barRegistrationCertificate']??"",
      address: json['address'],
      isAdvocate:  json['isAdvocate'],
      introduction:json ['introduction'],
      charges:json['charges'],
      skills: json['skills'],
      experience:json['experience']
    );
  }





}
UserClass userClass= UserClass(uid: "", email: "", phoneNumber: "", displayName: "", address: "", gender:"",isAdvocate: true);
