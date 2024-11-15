class UserClass {
  String uid;
  String email;
  String phoneNumber;
  String displayName;
  String gender;
  String  address;
  String? barRegistrationNo;
  String? barRegistrationCertificate;
  bool isAdvocate;
  UserClass({
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.displayName,
    required this.address,
    this.barRegistrationNo,
    this.barRegistrationCertificate,
    required this.isAdvocate
  });

  // Convert a User object to a Map object
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'gender':gender,
        'address':address,
        'phoneNumber':phoneNumber,
        'barRegistrationNo':barRegistrationNo??"",
        'barRegistrationCertificate': barRegistrationCertificate??"",
        'isAdvocate':isAdvocate,

      };

  // Create a User object from a Map object
  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      gender:json['gender'],
      phoneNumber: json['phoneNumber'],
      barRegistrationNo: json['barRegistrationNo']??"",
      barRegistrationCertificate: json['barRegistrationCertificate']??"",
      address: json['address'],
      isAdvocate:  json['isAdvocate']
    );
  }
}
UserClass userClass= UserClass(uid: "", email: "", phoneNumber: "", displayName: "",gender:"", address: "", isAdvocate: true);
