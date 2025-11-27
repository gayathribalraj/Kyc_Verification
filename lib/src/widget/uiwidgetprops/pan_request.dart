import 'package:sysmo_verification/kyc_validation.dart';




class PanidRequest {
  final String pan;
  final String consent;

  const PanidRequest({required this.pan, this.consent = "Y"});

  PanidRequest copyWith({
    String? pan,
    String? consent,
  }) {
    return PanidRequest(
      pan: pan ?? this.pan,
      consent: consent ?? this.consent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'pan': pan, 'consent': consent};
  }

  factory PanidRequest.fromMap(Map<String, dynamic> map) {
    return PanidRequest(
      pan: map['pan'] as String,
      consent: map['consent'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PanidRequest.fromJson(String source) =>
      PanidRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PanidRequest(: $pan, consent: $consent)';

//Added missing equality operator to satisfy dart analyzer

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PanidRequest &&
        other.pan == pan &&
        other.consent == consent;
  }

  @override
  int get hashCode => pan.hashCode ^ consent.hashCode;
}
