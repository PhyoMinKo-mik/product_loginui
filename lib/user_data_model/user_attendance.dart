class UserAttendance {
  final Null log;
  final Null lateMins;
  final bool isCheckOut;

  const UserAttendance({
    required this.log,
    required this.lateMins,
    required this.isCheckOut,
  });

  factory UserAttendance.fromJson(Map<String, dynamic> json) {
    return UserAttendance(
      log: json['log'],
      lateMins: json['lateMins'],
      isCheckOut: json['isCheckOut'],
    );
  }
}
