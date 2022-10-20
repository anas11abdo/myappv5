// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

class Files {
  final String first_name;
  final String last_name;
  final String file_id;
  final DateTime request_date;
  final DateTime from_date;
  final DateTime to_date;
  final String p_id;
  final String status;
  final String reason_refuse;
  final String app_type;

  const Files({
    required this.first_name,
    required this.last_name,
    required this.file_id,
    required this.request_date,
    required this.from_date,
    required this.to_date,
    required this.p_id,
    required this.status,
    required this.reason_refuse,
    required this.app_type,
  });

  static Files fromJson(json) => Files(
        first_name: json['PER_NAME'],
        last_name : json["PER_LASTNAME"],
        file_id: json['APP_ID'],
        request_date: DateTime.parse(json['REQUEST_DATE'].toString()),
        from_date: DateTime.parse(json['DATE_FROM'].toString()),
        to_date: DateTime.parse(json['DATE_TO'].toString()),
        status: json['STATUS'],
        p_id: json['PERSONAL_ID'],
        reason_refuse: json['REASON_REFUSE'],
        app_type: json['APP_TYPE'],
      );
}
