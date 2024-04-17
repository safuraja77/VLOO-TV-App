import 'pairing_result.dart';

class GetConnectionPairingResponse {
  GetConnectionPairingResponse({
      this.status, 
      this.message, 
      this.pairingResult,});

  GetConnectionPairingResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    pairingResult = json['result'] != null ? PairingResult.fromJson(json['result']) : null;
  }
  bool? status;
  String? message;
  PairingResult? pairingResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (pairingResult != null) {
      map['result'] = pairingResult?.toJson();
    }
    return map;
  }

}
//{"status":true,"message":"Screen Details","result":{"id":101,"user_id":16,"title":"qqww","date_of_first_connection":"2023-11-27","orientation":"Portrait Left","status":"Connected","created_at":"2023-11-27T14:01:06.000000Z","updated_at":"2023-11-27T14:01:52.000000Z","screen_code":"1nRrgK","uploadMedias":[{"id":56,"user_id":16,"name":"scaled_images","url":"https://vloo.6lgx.com/media/user_16/scaled_images_1700224735.jpg","type":"Image","format":"jpg","resolution":"162x311","duration":"","filesize":"5.26 KB","created_at":"2023-11-17T12:38:55.000000Z","updated_at":"2023-11-17T12:38:55.000000Z","thumbnail":"https://vloo.6lgx.com/media/user_16/scaled_images_1700224735.jpg","pivot":{"screen_id":101,"screen_contentable_id":56,"screen_contentable_type":"App\\Models\\UploadMedia"}}]}}