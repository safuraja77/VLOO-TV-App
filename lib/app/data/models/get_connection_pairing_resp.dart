

import 'pairing_result.dart';

class GetConnectionPairingResponse {
  final bool? status;
  final String? message;
  final PairingResult? result;
  GetConnectionPairingResponse({
    this.status,
    this.message,
    this.result,
  });

  GetConnectionPairingResponse copyWith({
    bool? status,
    String? message,
    PairingResult? result,
  }) {
    return GetConnectionPairingResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }

  factory GetConnectionPairingResponse.fromJson(dynamic map) {
    return GetConnectionPairingResponse(
      status: map['status'],
      message: map['message'],
      result:
          map['result'] != null ? PairingResult.fromJson(map['result']) : null,
    );
  }
}
