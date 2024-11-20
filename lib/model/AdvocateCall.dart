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
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'callTime':callTime,
        'advocateName':advocateName,
        'advoacteId':advoacteId,
        'isVideoCall': isVideoCall,
      };

  // Create a User object from a Map object
  factory AdvocateCall.fromJson(Map<String, dynamic> json) {
    return AdvocateCall(
      uid: json['uid'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      callTime: json['callTime'],
      advocateName: json['advocateName']??"",
      advoacteId: json['advoacteId']??"",
      isVideoCall: json['isVideoCall'],
     
    );
  }
}
AdvocateCall advocateCall= AdvocateCall(uid: "", userName: "", phoneNumber: "", advocateName: "",advoacteId: "", callTime: "",isVideoCall: true);


//store this model in  local storage also and update list in user according to local storafe