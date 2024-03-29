import 'Result.dart';

class GetConnectionResponse {
  GetConnectionResponse({
      this.status, 
      this.message, 
      this.result,});

  GetConnectionResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? ConnectionResult.fromJson(json['result']) : null;
  }
  bool? status;
  String? message;
  ConnectionResult? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}