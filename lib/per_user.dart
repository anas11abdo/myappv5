class PerUser {
  String prs_id;
  String prs_name;
  DateTime DOB;
  PerUser({required this.prs_id,required this.prs_name,required this.DOB});

  static PerUser fromJson(json) => PerUser(
      prs_id : json['PER_ID'],
      prs_name : json['PER_NAME'],
      DOB : DateTime.parse(json['PER_BOD'].toString()));
}
