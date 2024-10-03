class AdvocateCall {
  String uid;
  String userName;
  String phoneNumber;
  String callTime;
  String advocateName;
  String advoacteId;
  bool isVideoCall;
  AdvocateCall({
    required this.uid,
    required this.userName,
    required this.phoneNumber,
    required this.callTime,
    required this.advocateName,
    required this.advoacteId,
    required this.isVideoCall
 
  });

  // Convert a User object to a Map object
  // Map<String, dynamic> toJson() => {
  //       'uid': uid,
  //       'email': email,
  //       'displayName': displayName,
  //       'address':address,
  //       'phoneNumber':phoneNumber,
  //       'barRegistrationNo':barRegistrationNo??"",
  //       'barRegistrationCertificate': barRegistrationCertificate??"",
  //       'isAdvocate':isAdvocate,
  // 'introduction':introduction,
  //       'charges':charges,
  //       'skills':skills,
  //       'experience':experience,
  //     };

  // // Create a User object from a Map object
  // factory Advocate.fromJson(Map<String, dynamic> json) {
  //   return Advocate(
  //     uid: json['uid'],
  //     email: json['email'],
  //     displayName: json['displayName'],
  //     phoneNumber: json['phoneNumber'],
  //     barRegistrationNo: json['barRegistrationNo']??"",
  //     barRegistrationCertificate: json['barRegistrationCertificate']??"",
  //     address: json['address'],
  //     isAdvocate:  json['isAdvocate'],
  //          introduction:json ['introduction'],
  //     charges:json['charges'],
  //     skills: json['skills'],
  //     experience:json['experience']
  //   );
  // }
}
AdvocateCall advocateCall= AdvocateCall(uid: "", userName: "", phoneNumber: "", advoacteId: "", advocateName: "", callTime: "",isVideoCall: true);


//store this model in  local storage also and update list in user according to local storafe