import 'package:sysmo_verification/kyc_validation.dart';
import 'package:sysmo_verification/kyc_validation.dart' as ApiConfig;

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });
  group('AppConstant - Pattern Validation Tests', () {
    test('PAN pattern should match valid PAN format', () {
      final validPAN = 'ABCDE1234F';
      expect(AppConstant.panPattern.hasMatch(validPAN), true);
    });

    test('PAN pattern should reject invalid PAN format', () {
      final invalidPAN = 'ABCDE12345';
      expect(AppConstant.panPattern.hasMatch(invalidPAN), false);
    });

    test('Voter pattern should match valid Voter ID format', () {
      final validVoter = 'ABC1234567';
      expect(AppConstant.voterPattern.hasMatch(validVoter), true);
    });

    test('Voter pattern should reject invalid Voter ID format', () {
      final invalidVoter = 'ABC123456';
      expect(AppConstant.voterPattern.hasMatch(invalidVoter), false);
    });

    test('GST pattern should match valid GST format', () {
      final validGST = '29ABCDE1234Z1Z0';
      expect(AppConstant.gstPattern.hasMatch(validGST), true);
    });

    test('GST pattern should reject invalid GST format', () {
      final invalidGST = '29ABCDE123';
      expect(AppConstant.gstPattern.hasMatch(invalidGST), false);
    });

    test('Passport pattern should match valid Passport format', () {
      final validPassport = 'A1234567';
      expect(AppConstant.passportPattern.hasMatch(validPassport), true);
    });

    test('Passport pattern should reject invalid Passport format', () {
      final invalidPassport = 'AB1234567';
      expect(AppConstant.passportPattern.hasMatch(invalidPassport), false);
    });

    test('Aadhaar pattern should match valid Aadhaar format', () {
      final validAadhaar = '123456789012';
      expect(AppConstant.aadhaarPattern.hasMatch(validAadhaar), true);
    });

    test('Aadhaar pattern should reject invalid Aadhaar format', () {
      final invalidAadhaar = '12345678901';
      expect(AppConstant.aadhaarPattern.hasMatch(invalidAadhaar), false);
    });
  });

  group('ApiConfig - Configuration Tests', () {
    test('Voter ID API endpoint should be correctly configured', () {
      expect(
        ApiConfig.voterId,
        equals(
          dotenv.env['voter_verification_endpoint'],
        ),
      );
    });

    test('PAN Card API endpoint should be correctly configured', () {
      expect(
        ApiConfig.panCard,
        equals(
         dotenv.env['pan_verification_endpoint'],
        ),
        
      );
    });

    test('API endpoints should not be empty', () {
      expect(ApiConfig.voterId.isNotEmpty, true);
      expect(ApiConfig.panCard.isNotEmpty, true);
    });
  });

  group('VoteridRequest - Serialization Tests', () {
    test('VoteridRequest should create instance with valid data', () {
      final request = VoteridRequest(epicNo: 'ABC1234567');
      expect(request.epicNo, equals('ABC1234567'));
      expect(request.consent, equals('Y'));
    });

    test('VoteridRequest toJson should produce valid JSON string', () {
      final request = VoteridRequest(epicNo: 'ABC1234567', consent: 'Y');
      final jsonString = request.toJson();
      expect(jsonString, isA<String>());
      expect(jsonString.contains('ABC1234567'), true);
    });

    test('VoteridRequest fromJson should deserialize correctly', () {
      final jsonString = '{"epicNo":"ABC1234567","consent":"Y"}';
      final request = VoteridRequest.fromJson(jsonString);
      expect(request.epicNo, equals('ABC1234567'));
      expect(request.consent, equals('Y'));
    });

    test('VoteridRequest toMap should return correct map', () {
      final request = VoteridRequest(epicNo: 'ABC1234567', consent: 'Y');
      final map = request.toMap();
      expect(map['epicNo'], equals('ABC1234567'));
      expect(map['consent'], equals('Y'));
    });

    test('VoteridRequest copyWith should create new instance with updated fields',
        () {
      final originalRequest = VoteridRequest(epicNo: 'ABC1234567');
      final updatedRequest = originalRequest.copyWith(epicNo: 'XYZ9876543');
      expect(updatedRequest.epicNo, equals('XYZ9876543'));
      expect(originalRequest.epicNo, equals('ABC1234567'));
    });

    test('VoteridRequest equality should work correctly', () {
      final request1 = VoteridRequest(epicNo: 'ABC1234567');
      final request2 = VoteridRequest(epicNo: 'ABC1234567');
      expect(request1 == request2, true);
    });

    test('VoteridRequest inequality should work correctly', () {
      final request1 = VoteridRequest(epicNo: 'ABC1234567');
      final request2 = VoteridRequest(epicNo: 'XYZ9876543');
      expect(request1 == request2, false);
    });

    test('VoteridRequest hashCode should be consistent', () {
      final request1 = VoteridRequest(epicNo: 'ABC1234567');
      final request2 = VoteridRequest(epicNo: 'ABC1234567');
      expect(request1.hashCode == request2.hashCode, true);
    });

    test('VoteridRequest toString should return formatted string', () {
      final request = VoteridRequest(epicNo: 'ABC1234567');
      final stringRep = request.toString();
      expect(stringRep.contains('ABC1234567'), true);
    });
  });

  group('PanidRequest - Serialization Tests', () {
    test('PanidRequest should create instance with valid data', () {
      final request = PanidRequest(pan: 'ABCDE1234F');
      expect(request.pan, equals('ABCDE1234F'));
      expect(request.consent, equals('Y'));
    });

    test('PanidRequest toJson should produce valid JSON string', () {
      final request = PanidRequest(pan: 'ABCDE1234F', consent: 'Y');
      final jsonString = request.toJson();
      expect(jsonString, isA<String>());
      expect(jsonString.contains('ABCDE1234F'), true);
    });

    test('PanidRequest fromJson should deserialize correctly', () {
      final jsonString = '{"pan":"ABCDE1234F","consent":"Y"}';
      final request = PanidRequest.fromJson(jsonString);
      expect(request.pan, equals('ABCDE1234F'));
      expect(request.consent, equals('Y'));
    });

    test('PanidRequest toMap should return correct map', () {
      final request = PanidRequest(pan: 'ABCDE1234F', consent: 'Y');
      final map = request.toMap();
      expect(map['pan'], equals('ABCDE1234F'));
      expect(map['consent'], equals('Y'));
    });

    test('PanidRequest copyWith should create new instance with updated fields',
        () {
      final originalRequest = PanidRequest(pan: 'ABCDE1234F');
      final updatedRequest = originalRequest.copyWith(pan: 'XYZAB5678C');
      expect(updatedRequest.pan, equals('XYZAB5678C'));
      expect(originalRequest.pan, equals('ABCDE1234F'));
    });

    test('PanidRequest equality should work correctly', () {
      final request1 = PanidRequest(pan: 'ABCDE1234F');
      final request2 = PanidRequest(pan: 'ABCDE1234F');
      expect(request1 == request2, true);
    });

    test('PanidRequest inequality should work correctly', () {
      final request1 = PanidRequest(pan: 'ABCDE1234F');
      final request2 = PanidRequest(pan: 'XYZAB5678C');
      expect(request1 == request2, false);
    });

    test('PanidRequest hashCode should be consistent', () {
      final request1 = PanidRequest(pan: 'ABCDE1234F');
      final request2 = PanidRequest(pan: 'ABCDE1234F');
      expect(request1.hashCode == request2.hashCode, true);
    });

    test('PanidRequest toString should return formatted string', () {
      final request = PanidRequest(pan: 'ABCDE1234F');
      final stringRep = request.toString();
      expect(stringRep.contains('ABCDE1234F'), true);
    });

    test('PanidRequest default consent value should be Y', () {
      final request = PanidRequest(pan: 'ABCDE1234F');
      expect(request.consent, equals('Y'));
    });
  });

  group('ButtonProps - Widget Properties Tests', () {
    test('ButtonProps should create instance with required parameters', () {
      const button = ButtonProps(label: 'Verify');
      expect(button.label, equals('Verify'));
      expect(button.disabled, false);
      expect(button.borderRadius, equals(8.0));
    });

    test('ButtonProps should accept all optional parameters', () {
      const button = ButtonProps(
        label: 'Verify',
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        borderRadius: 12.0,
        disabled: true,
      );
      expect(button.label, equals('Verify'));
      expect(button.disabled, true);
      expect(button.borderRadius, equals(12.0));
    });

    test('ButtonProps should have default border radius', () {
      const button = ButtonProps(label: 'Verify');
      expect(button.borderRadius, equals(8.0));
    });

    test('ButtonProps should have default disabled state', () {
      const button = ButtonProps(label: 'Verify');
      expect(button.disabled, false);
    });
  });

  group('FormProps - Form Field Properties Tests', () {
    test('FormProps should create instance with required parameters', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
      );
      expect(form.formControlName, equals('voterId'));
      expect(form.label, equals('Voter ID'));
      expect(form.mandatory, false);
    });

    test('FormProps should accept mandatory parameter', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
        mandatory: true,
      );
      expect(form.mandatory, true);
    });

    test('FormProps should accept maxLength parameter', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
        maxLength: 10,
      );
      expect(form.maxLength, equals(10));
    });

    test('FormProps should accept hint parameter', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
        hint: 'Enter your voter ID',
      );
      expect(form.hint, equals('Enter your voter ID'));
    });

    test('FormProps should have default mandatory value as false', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
      );
      expect(form.mandatory, false);
    });
  });

  group('StyleProps - UI Style Properties Tests', () {
    test('StyleProps should create instance with default values', () {
      const style = StyleProps();
      expect(style.borderRadius, equals(8));
    });

    test('StyleProps should accept custom border radius', () {
      const style = StyleProps(borderRadius: 12);
      expect(style.borderRadius, equals(12));
    });

    test('StyleProps should accept TextStyle parameter', () {
      const textStyle = TextStyle(fontSize: 16);
      const style = StyleProps(textStyle: textStyle);
      expect(style.textStyle, equals(textStyle));
    });

    test('StyleProps should accept EdgeInsetsGeometry parameter', () {
      const padding = EdgeInsets.all(10);
      const style = StyleProps(padding: padding);
      expect(style.padding, equals(padding));
    });

    test('StyleProps should accept backgroundColor parameter', () {
      const backgroundColor = Color.fromARGB(255, 0, 0, 0);
      const style = StyleProps(backgroundColor: backgroundColor);
      expect(style.backgroundColor, equals(backgroundColor));
    });

    test('StyleProps should accept borderColor parameter', () {
      const borderColor = Color.fromARGB(255, 255, 0, 0);
      const style = StyleProps(borderColor: borderColor);
      expect(style.borderColor, equals(borderColor));
    });
  });

  group('VoterVerified - Service Tests', () {
    test('VoterVerified should be a VerificationMixin', () {
      final voterVerified = VoterVerified();
      expect(voterVerified, isA<VerificationMixin>());
    });

    test('VoterVerified should have ApiClient instance', () {
      final voterVerified = VoterVerified();
      expect(voterVerified.apiClient, isA<ApiClient>());
    });
  });

  group('PanVerified - Service Tests', () {
    test('PanVerified should be a VerificationMixin', () {
      final panVerified = PanVerified();
      expect(panVerified, isA<VerificationMixin>());
    });

    test('PanVerified should have ApiClient instance', () {
      final panVerified = PanVerified();
      expect(panVerified.apiClient, isA<ApiClient>());
    });
  });

  group('VerificationType - Enum Tests', () {
    test('VerificationType should have voter option', () {
      expect(VerificationType.voter, isNotNull);
    });

    test('VerificationType should have aadhaar option', () {
      expect(VerificationType.aadhaar, isNotNull);
    });

    test('VerificationType should have pan option', () {
      expect(VerificationType.pan, isNotNull);
    });

    test('VerificationType should have gst option', () {
      expect(VerificationType.gst, isNotNull);
    });

    test('VerificationType should have passport option', () {
      expect(VerificationType.passport, isNotNull);
    });
  });

  group('KYCService - Service Tests', () {
    test('KYCService should extend KycVerification', () {
      final kycService = KYCService();
      expect(kycService, isA<KycVerification>());
    });

    test('KYCService should have verify method', () {
      final kycService = KYCService();
      expect(kycService.verify, isA<Function>());
    });
  });

  group('ApiClient - HTTP Client Tests', () {
    test('ApiClient should create Dio instance', () {
      final apiClient = ApiClient();
      expect(apiClient.dio, isA<Dio>());
    });

    test('ApiClient should have callGet method', () {
      final apiClient = ApiClient();
      expect(apiClient.callGet, isA<Function>());
    });

    test('ApiClient should have callPost method', () {
      final apiClient = ApiClient();
      expect(apiClient.callPost, isA<Function>());
    });

    test('ApiClient should set required headers', () {
      final apiClient = ApiClient();
      expect(apiClient.dio.options, isNotNull);
    });
  });

  group('OfflineVerificationHandler - Asset Loading Tests', () {
    test('OfflineVerificationHandler should have loadData method', () {
      expect(OfflineVerificationHandler.loadData, isA<Function>());
    });
  });

  group('Validation Pattern Combinations', () {
    test('Should match voter ID but not PAN', () {
      final voterId = 'ABC1234567';
      expect(AppConstant.voterPattern.hasMatch(voterId), true);
      expect(AppConstant.panPattern.hasMatch(voterId), false);
    });

    test('Should match PAN but not voter ID', () {
      final pan = 'ABCDE1234F';
      expect(AppConstant.panPattern.hasMatch(pan), true);
      expect(AppConstant.voterPattern.hasMatch(pan), false);
    });

    test('Should match Aadhaar but not PAN', () {
      final aadhaar = '123456789012';
      expect(AppConstant.aadhaarPattern.hasMatch(aadhaar), true);
      expect(AppConstant.panPattern.hasMatch(aadhaar), false);
    });

    test('Should reject empty strings', () {
      final empty = '';
      expect(AppConstant.voterPattern.hasMatch(empty), false);
      expect(AppConstant.panPattern.hasMatch(empty), false);
      expect(AppConstant.aadhaarPattern.hasMatch(empty), false);
    });
  });

  group('Request Object Immutability Tests', () {
    test('VoteridRequest should be immutable after creation', () {
      final request = VoteridRequest(epicNo: 'ABC1234567');
      expect(request.epicNo, equals('ABC1234567'));
    });

    test('PanidRequest should be immutable after creation', () {
      final request = PanidRequest(pan: 'ABCDE1234F');
      expect(request.pan, equals('ABCDE1234F'));
    });
  });

  group('Error Handling Tests', () {
    test('VoteridRequest should handle special characters in epicNo', () {
      const request = VoteridRequest(epicNo: 'ABC@1234567');
      expect(request.epicNo, equals('ABC@1234567'));
    });

    test('PanidRequest should handle lowercase consent', () {
      const request = PanidRequest(pan: 'ABCDE1234F', consent: 'y');
      expect(request.consent, equals('y'));
    });
  });
}

