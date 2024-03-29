class ConnectionResult {
  ConnectionResult({
      this.code, 
      this.qr,});

  ConnectionResult.fromJson(dynamic json) {
    code = json['code'];
    qr = json['qr'];
  }
  String? code;
  String? qr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['qr'] = qr;
    return map;
  }

}