import 'package:flutter/cupertino.dart';

class UserInfo {
  final String employeeId;
  final String userName;
  final String fullName;
  final String joinDate;
  final String dateOfBirth;
  final String gender;
  final String nrc;
  final String phoneNumber;
  final String otherPhone;
  final String email;
  final String houseNo;
  final String detailAddress;
  final String? profile;
  final String? drivingLicense;
  final bool isSignAgreement;
  final String? resignDate;
  final int salary;
  final int loanAmt;
  final int status;
  final String companyId;
  final String companyName;
  final int branchId;
  final String branchName;
  final int deptId;
  final String deptName;
  final int positionId;
  final String positionName;

  const UserInfo({
    required this.employeeId,
    required this.userName,
    required this.fullName,
    required this.joinDate,
    required this.dateOfBirth,
    required this.gender,
    required this.nrc,
    required this.phoneNumber,
    required this.otherPhone,
    required this.email,
    required this.houseNo,
    required this.detailAddress,
    required this.profile,
    required this.drivingLicense,
    required this.isSignAgreement,
    required this.resignDate,
    required this.salary,
    required this.loanAmt,
    required this.status,
    required this.companyId,
    required this.companyName,
    required this.branchId,
    required this.branchName,
    required this.deptId,
    required this.deptName,
    required this.positionId,
    required this.positionName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      employeeId: json['employeeId'],
      userName: json['userName'],
      fullName: json['fullName'],
      joinDate: json['joinDate'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      nrc: json['nrc'],
      phoneNumber: json['phoneNumber'],
      otherPhone: json['otherPhone'],
      email: json['email'],
      houseNo: json['houseNo'],
      detailAddress: json['detailAddress'],
      profile: json['profile'],
      drivingLicense: json['drivingLicense'],
      isSignAgreement: json['isSignAgreement'],
      resignDate: json['resignDate'],
      salary: json['salary'],
      loanAmt: json['loanAmt'],
      status: json['status'],
      companyId: json['companyId'],
      companyName: json['companyName'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      deptId: json['deptId'],
      deptName: json['deptName'],
      positionId: json['positionId'],
      positionName: json['positionName'],
    );
  }
}
