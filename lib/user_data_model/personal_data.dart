import 'package:product_loginui/user_data_model/user_attendance.dart';
import 'package:product_loginui/user_data_model/user_info.dart';

class PersonalData {
  final UserInfo info;
  final UserAttendance attendance;

  const PersonalData({required this.info, required this.attendance});

  factory PersonalData.fromJson(Map<String, dynamic> json) {
    return PersonalData(
      info: UserInfo.fromJson(json['info']),
      attendance: UserAttendance.fromJson(json['attendance']),
    );
  }

  get fullName => null;

  get email => null;

  get phoneNumber => null;

  get photo => null;
}
