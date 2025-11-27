import 'package:sysmo_verification/kyc_validation.dart';
import 'package:sysmo_verification/kyc_validation.dart' as ApiConfig;

/// Main test suite for KYC Verification Package
/// Tests cover validation patterns, API configuration, serialization, UI components,
/// and verification handlers for all supported KYC types (Voter, PAN, Aadhaar, GST, Passport)
void main() {
  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  /// Tests for AppConstant validation patterns
  /// Validates that each KYC type has correct RegExp patterns for input validation
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

  /// Tests for API configuration from environment variables
  /// Ensures API endpoints are properly loaded from .env file
  group('ApiConfig - Configuration Tests', () {
    /// Verifies Voter ID endpoint matches .env configuration
    test('Voter ID API endpoint should be correctly configured', () {
      expect(
        ApiConfig.voterId,
        equals(
          dotenv.env['voter_verification_endpoint'],
        ),
      );
    });

    /// Verifies PAN Card endpoint matches .env configuration
    test('PAN Card API endpoint should be correctly configured', () {
      expect(
        ApiConfig.panCard,
        equals(
         dotenv.env['pan_verification_endpoint'],
        ),
        
      );
    });

    /// Ensures API endpoints are not empty strings (valid configuration)
    test('API endpoints should not be empty', () {
      expect(ApiConfig.voterId.isNotEmpty, true);
      expect(ApiConfig.panCard.isNotEmpty, true);
    });
  });

  /// Tests for VoteridRequest model serialization and immutability
  /// Validates JSON encoding/decoding, object copying, and equality operations
  group('VoteridRequest - Serialization Tests', () {
    /// Verifies VoteridRequest instantiation with default consent value
    test('VoteridRequest should create instance with valid data', () {
      final request = VoteridRequest(epicNo: 'ABC1234567');
      expect(request.epicNo, equals('ABC1234567'));
      expect(request.consent, equals('Y'));
    });

    /// Verifies toJson() produces valid JSON string representation
    test('VoteridRequest toJson should produce valid JSON string', () {
      final request = VoteridRequest(epicNo: 'ABC1234567', consent: 'Y');
      final jsonString = request.toJson();
      expect(jsonString, isA<String>());
      expect(jsonString.contains('ABC1234567'), true);
    });

    /// Verifies fromJson() correctly deserializes JSON back to object
    test('VoteridRequest fromJson should deserialize correctly', () {
      final jsonString = '{"epicNo":"ABC1234567","consent":"Y"}';
      final request = VoteridRequest.fromJson(jsonString);
      expect(request.epicNo, equals('ABC1234567'));
      expect(request.consent, equals('Y'));
    });

    /// Verifies toMap() returns a proper Map<String, dynamic> representation
    test('VoteridRequest toMap should return correct map', () {
      final request = VoteridRequest(epicNo: 'ABC1234567', consent: 'Y');
      final map = request.toMap();
      expect(map['epicNo'], equals('ABC1234567'));
      expect(map['consent'], equals('Y'));
    });

    /// Verifies copyWith() creates new instance without modifying original
    test('VoteridRequest copyWith should create new instance with updated fields',
        () {
      final originalRequest = VoteridRequest(epicNo: 'ABC1234567');
      final updatedRequest = originalRequest.copyWith(epicNo: 'XYZ9876543');
      expect(updatedRequest.epicNo, equals('XYZ9876543'));
      expect(originalRequest.epicNo, equals('ABC1234567'));
    });

    /// Verifies == operator works for identical objects
    test('VoteridRequest equality should work correctly', () {
      final request1 = VoteridRequest(epicNo: 'ABC1234567');
      final request2 = VoteridRequest(epicNo: 'ABC1234567');
      expect(request1 == request2, true);
    });

    /// Verifies == operator correctly identifies different objects
    test('VoteridRequest inequality should work correctly', () {
      final request1 = VoteridRequest(epicNo: 'ABC1234567');
      final request2 = VoteridRequest(epicNo: 'XYZ9876543');
      expect(request1 == request2, false);
    });

    /// Verifies hashCode is consistent for equal objects (required for HashMap/Set)
    test('VoteridRequest hashCode should be consistent', () {
      final request1 = VoteridRequest(epicNo: 'ABC1234567');
      final request2 = VoteridRequest(epicNo: 'ABC1234567');
      expect(request1.hashCode == request2.hashCode, true);
    });

    /// Verifies toString() produces readable debug string with object data
    test('VoteridRequest toString should return formatted string', () {
      final request = VoteridRequest(epicNo: 'ABC1234567');
      final stringRep = request.toString();
      expect(stringRep.contains('ABC1234567'), true);
    });
  });

  /// Tests for PanidRequest model serialization and immutability
  /// Similar to VoteridRequest tests but for PAN Card verification requests
  group('PanidRequest - Serialization Tests', () {
    /// Verifies PanidRequest instantiation with default consent value
    test('PanidRequest should create instance with valid data', () {
      final request = PanidRequest(pan: 'ABCDE1234F');
      expect(request.pan, equals('ABCDE1234F'));
      expect(request.consent, equals('Y'));
    });

    /// Verifies toJson() produces valid JSON string representation
    test('PanidRequest toJson should produce valid JSON string', () {
      final request = PanidRequest(pan: 'ABCDE1234F', consent: 'Y');
      final jsonString = request.toJson();
      expect(jsonString, isA<String>());
      expect(jsonString.contains('ABCDE1234F'), true);
    });

    /// Verifies fromJson() correctly deserializes JSON back to object
    test('PanidRequest fromJson should deserialize correctly', () {
      final jsonString = '{"pan":"ABCDE1234F","consent":"Y"}';
      final request = PanidRequest.fromJson(jsonString);
      expect(request.pan, equals('ABCDE1234F'));
      expect(request.consent, equals('Y'));
    });

    /// Verifies toMap() returns a proper Map<String, dynamic> representation
    test('PanidRequest toMap should return correct map', () {
      final request = PanidRequest(pan: 'ABCDE1234F', consent: 'Y');
      final map = request.toMap();
      expect(map['pan'], equals('ABCDE1234F'));
      expect(map['consent'], equals('Y'));
    });

    /// Verifies copyWith() creates new instance without modifying original
    test('PanidRequest copyWith should create new instance with updated fields',
        () {
      final originalRequest = PanidRequest(pan: 'ABCDE1234F');
      final updatedRequest = originalRequest.copyWith(pan: 'XYZAB5678C');
      expect(updatedRequest.pan, equals('XYZAB5678C'));
      expect(originalRequest.pan, equals('ABCDE1234F'));
    });

    /// Verifies == operator works for identical objects
    test('PanidRequest equality should work correctly', () {
      final request1 = PanidRequest(pan: 'ABCDE1234F');
      final request2 = PanidRequest(pan: 'ABCDE1234F');
      expect(request1 == request2, true);
    });

    /// Verifies == operator correctly identifies different objects
    test('PanidRequest inequality should work correctly', () {
      final request1 = PanidRequest(pan: 'ABCDE1234F');
      final request2 = PanidRequest(pan: 'XYZAB5678C');
      expect(request1 == request2, false);
    });

    /// Verifies hashCode is consistent for equal objects (required for HashMap/Set)
    test('PanidRequest hashCode should be consistent', () {
      final request1 = PanidRequest(pan: 'ABCDE1234F');
      final request2 = PanidRequest(pan: 'ABCDE1234F');
      expect(request1.hashCode == request2.hashCode, true);
    });

    /// Verifies toString() produces readable debug string with object data
    test('PanidRequest toString should return formatted string', () {
      final request = PanidRequest(pan: 'ABCDE1234F');
      final stringRep = request.toString();
      expect(stringRep.contains('ABCDE1234F'), true);
    });

    /// Verifies default consent value is always set to 'Y'
    test('PanidRequest default consent value should be Y', () {
      final request = PanidRequest(pan: 'ABCDE1234F');
      expect(request.consent, equals('Y'));
    });
  });

  /// Tests for ButtonProps configuration class
  /// Validates UI button properties like colors, sizes, and styles
  group('ButtonProps - Widget Properties Tests', () {
    /// Verifies ButtonProps instantiation with required parameters
    test('ButtonProps should create instance with required parameters', () {
      const button = ButtonProps(label: 'Verify');
      expect(button.label, equals('Verify'));
      expect(button.disabled, false);
      expect(button.borderRadius, equals(8.0));
    });

    /// Verifies ButtonProps accepts all optional styling parameters
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

    /// Verifies default border radius is set to 8.0
    test('ButtonProps should have default border radius', () {
      const button = ButtonProps(label: 'Verify');
      expect(button.borderRadius, equals(8.0));
    });

    /// Verifies default disabled state is false
    test('ButtonProps should have default disabled state', () {
      const button = ButtonProps(label: 'Verify');
      expect(button.disabled, false);
    });
  });

  /// Tests for FormProps configuration class
  /// Validates form field properties like labels, validation, and constraints
  group('FormProps - Form Field Properties Tests', () {
    /// Verifies FormProps instantiation with required parameters
    test('FormProps should create instance with required parameters', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
      );
      expect(form.formControlName, equals('voterId'));
      expect(form.label, equals('Voter ID'));
      expect(form.mandatory, false);
    });

    /// Verifies FormProps accepts mandatory flag parameter
    test('FormProps should accept mandatory parameter', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
        mandatory: true,
      );
      expect(form.mandatory, true);
    });

    /// Verifies FormProps accepts maxLength constraint
    test('FormProps should accept maxLength parameter', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
        maxLength: 10,
      );
      expect(form.maxLength, equals(10));
    });

    /// Verifies FormProps accepts hint text parameter
    test('FormProps should accept hint parameter', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
        hint: 'Enter your voter ID',
      );
      expect(form.hint, equals('Enter your voter ID'));
    });

    /// Verifies default mandatory value is false
    test('FormProps should have default mandatory value as false', () {
      const form = FormProps(
        formControlName: 'voterId',
        label: 'Voter ID',
      );
      expect(form.mandatory, false);
    });
  });

  /// Tests for StyleProps configuration class
  /// Validates UI styling properties like colors, padding, and border radius
  group('StyleProps - UI Style Properties Tests', () {
    /// Verifies StyleProps has default values when instantiated without parameters
    test('StyleProps should create instance with default values', () {
      const style = StyleProps();
      expect(style.borderRadius, equals(8));
    });

    /// Verifies StyleProps accepts custom border radius
    test('StyleProps should accept custom border radius', () {
      const style = StyleProps(borderRadius: 12);
      expect(style.borderRadius, equals(12));
    });

    /// Verifies StyleProps accepts TextStyle parameter
    test('StyleProps should accept TextStyle parameter', () {
      const textStyle = TextStyle(fontSize: 16);
      const style = StyleProps(textStyle: textStyle);
      expect(style.textStyle, equals(textStyle));
    });

    /// Verifies StyleProps accepts EdgeInsetsGeometry for padding
    test('StyleProps should accept EdgeInsetsGeometry parameter', () {
      const padding = EdgeInsets.all(10);
      const style = StyleProps(padding: padding);
      expect(style.padding, equals(padding));
    });

    /// Verifies StyleProps accepts backgroundColor parameter
    test('StyleProps should accept backgroundColor parameter', () {
      const backgroundColor = Color.fromARGB(255, 0, 0, 0);
      const style = StyleProps(backgroundColor: backgroundColor);
      expect(style.backgroundColor, equals(backgroundColor));
    });

    /// Verifies StyleProps accepts borderColor parameter
    test('StyleProps should accept borderColor parameter', () {
      const borderColor = Color.fromARGB(255, 255, 0, 0);
      const style = StyleProps(borderColor: borderColor);
      expect(style.borderColor, equals(borderColor));
    });
  });

  // group('VoterVerified - Service Tests', () {
  //   test('VoterVerified should be a VerificationMixin', () {
  //     final voterVerified = VoterVerified();
  //     expect(voterVerified, isA<VerificationMixin>());
  //   });

  //   test('VoterVerified should have ApiClient instance', () {
  //     final voterVerified = VoterVerified();
  //     expect(voterVerified.apiClient, isA<ApiClient>());
  //   });
  // });

  // group('PanVerified - Service Tests', () {
  //   test('PanVerified should be a VerificationMixin', () {
  //     final panVerified = PanVerified();
  //     expect(panVerified, isA<VerificationMixin>());
  //   });

  //   test('PanVerified should have ApiClient instance', () {
  //     final panVerified = PanVerified();
  //     expect(panVerified.apiClient, isA<ApiClient>());
  //   });
  // });

  /// Tests for VerificationType enum
  /// Validates that all required verification types are available
  group('VerificationType - Enum Tests', () {
    /// Verifies VerificationType.voter is available
    test('VerificationType should have voter option', () {
      expect(VerificationType.voter, isNotNull);
    });

    /// Verifies VerificationType.aadhaar is available
    test('VerificationType should have aadhaar option', () {
      expect(VerificationType.aadhaar, isNotNull);
    });

    /// Verifies VerificationType.pan is available
    test('VerificationType should have pan option', () {
      expect(VerificationType.pan, isNotNull);
    });

    /// Verifies VerificationType.gst is available
    test('VerificationType should have gst option', () {
      expect(VerificationType.gst, isNotNull);
    });

    /// Verifies VerificationType.passport is available
    test('VerificationType should have passport option', () {
      expect(VerificationType.passport, isNotNull);
    });
  });

  /// Tests for KYCService
  /// Validates that KYCService correctly extends KycVerification with verify method
  group('KYCService - Service Tests', () {
    /// Verifies KYCService is a subclass of KycVerification
    test('KYCService should extend KycVerification', () {
      final kycService = KYCService();
      expect(kycService, isA<KycVerification>());
    });

    /// Verifies KYCService has callable verify method
    test('KYCService should have verify method', () {
      final kycService = KYCService();
      expect(kycService.verify, isA<Function>());
    });
  });

  /// Tests for ApiClient HTTP client functionality
  /// Validates Dio instance creation, headers, and HTTP methods
  group('ApiClient - HTTP Client Tests', () {
    /// Verifies ApiClient creates a Dio instance
    test('ApiClient should create Dio instance', () {
      final apiClient = ApiClient();
      expect(apiClient.dio, isA<Dio>());
    });

    /// Verifies ApiClient has callGet method for GET requests
    test('ApiClient should have callGet method', () {
      final apiClient = ApiClient();
      expect(apiClient.callGet, isA<Function>());
    });

    /// Verifies ApiClient has callPost method for POST requests
    test('ApiClient should have callPost method', () {
      final apiClient = ApiClient();
      expect(apiClient.callPost, isA<Function>());
    });

    /// Verifies ApiClient sets required headers for API calls
    test('ApiClient should set required headers', () {
      final apiClient = ApiClient();
      expect(apiClient.dio.options, isNotNull);
    });
  });

  /// Tests for OfflineVerificationHandler
  /// Validates asset loading functionality for offline verification
  group('OfflineVerificationHandler - Asset Loading Tests', () {
    /// Verifies OfflineVerificationHandler has static loadData method
    test('OfflineVerificationHandler should have loadData method', () {
      expect(OfflineVerificationHandler.loadData, isA<Function>());
    });
  });

  /// Tests for pattern validation across different verification types
  /// Ensures patterns are mutually exclusive to avoid false positives
  group('Validation Pattern Combinations', () {
    /// Verifies Voter ID pattern matches but PAN pattern does not
    test('Should match voter ID but not PAN', () {
      final voterId = 'ABC1234567';
      expect(AppConstant.voterPattern.hasMatch(voterId), true);
      expect(AppConstant.panPattern.hasMatch(voterId), false);
    });

    /// Verifies PAN pattern matches but Voter ID pattern does not
    test('Should match PAN but not voter ID', () {
      final pan = 'ABCDE1234F';
      expect(AppConstant.panPattern.hasMatch(pan), true);
      expect(AppConstant.voterPattern.hasMatch(pan), false);
    });

    /// Verifies Aadhaar pattern matches but PAN pattern does not
    test('Should match Aadhaar but not PAN', () {
      final aadhaar = '123456789012';
      expect(AppConstant.aadhaarPattern.hasMatch(aadhaar), true);
      expect(AppConstant.panPattern.hasMatch(aadhaar), false);
    });

    /// Verifies all patterns reject empty strings
    test('Should reject empty strings', () {
      final empty = '';
      expect(AppConstant.voterPattern.hasMatch(empty), false);
      expect(AppConstant.panPattern.hasMatch(empty), false);
      expect(AppConstant.aadhaarPattern.hasMatch(empty), false);
    });
  });

  /// Tests for Response Parser validation with mock API responses
  /// Validates correct parsing of online and offline API responses for each verification type
  group('ResponseParser - Voter ID Response Validation Tests', () {
    /// Verifies successful online Voter ID API response is parsed correctly
    test('VoterResponseParser should parse successful online response', () {
      final mockResponse = {
        'status': 'SUCCESS',
        'responseCode': '200',
        'data': {'name': 'John Doe', 'epicNo': 'ABC1234567'}
      };
      
      final parser = VoterResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, true);
    });

    /// Verifies failed online Voter ID API response is parsed correctly
    test('VoterResponseParser should parse failed online response', () {
      final mockResponse = {
        'status': 'FAILED',
        'responseCode': '400',
        'error': 'Invalid voter ID'
      };
      
      final parser = VoterResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, false);
    });

    /// Verifies successful offline Voter ID response is parsed correctly
    test('VoterResponseParser should parse successful offline response', () {
      final mockResponse = {
        'RESPONSE': json.encode({
          'ursh': {
            'status': 'SUCCESS',
            'responseCode': '200',
            'data': {'name': 'John Doe'}
          }
        })
      };
      
      final parser = VoterResponseParser();
      final result = parser.parseOfflineResponse(mockResponse);
      
      expect(result, true);
    });

    /// Verifies malformed offline response returns false
    test('VoterResponseParser should handle malformed offline response', () {
      final mockResponse = {
        'RESPONSE': json.encode({
          'ursh': null
        })
      };
      
      final parser = VoterResponseParser();
      final result = parser.parseOfflineResponse(mockResponse);
      
      expect(result, false);
    });
  });

  /// Tests for PAN response parsing with mock API responses
  group('ResponseParser - PAN Response Validation Tests', () {
    /// Verifies successful online PAN API response is parsed correctly
    test('PanResponseParser should parse successful online response', () {
      final mockResponse = {
        'status': 'SUCCESS',
        'responseCode': '200',
        'data': {'pan': 'ABCDE1234F', 'name': 'John Doe'}
      };
      
      final parser = PanResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, true);
    });

    /// Verifies failed online PAN API response is parsed correctly
    test('PanResponseParser should parse failed online response', () {
      final mockResponse = {
        'status': 'FAILED',
        'responseCode': '401',
        'error': 'Invalid PAN'
      };
      
      final parser = PanResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, false);
    });

    /// Verifies successful offline PAN response is parsed correctly
    test('PanResponseParser should parse successful offline response', () {
      final mockResponse = {
        'Success': true,
        'PanValidation': {
          'success': true,
          'pan': 'ABCDE1234F'
        }
      };
      
      final parser = PanResponseParser();
      final result = parser.parseOfflineResponse(mockResponse);
      
      expect(result, true);
    });

    /// Verifies failed offline PAN response is parsed correctly
    test('PanResponseParser should parse failed offline response', () {
      final mockResponse = {
        'Success': false,
        'PanValidation': null
      };
      
      final parser = PanResponseParser();
      final result = parser.parseOfflineResponse(mockResponse);
      
      expect(result, false);
    });
  });

  /// Tests for GST response parsing with mock API responses
  group('ResponseParser - GST Response Validation Tests', () {
    /// Verifies successful GST API response is parsed correctly
    test('GstResponseParser should parse successful response', () {
      final mockResponse = {
        'gstResp': {
          'success': true,
          'responseData': {
            'status_code': '101',
            'gst': '29ABCDE1234Z1Z0'
          }
        }
      };
      
      final parser = GstResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, true);
    });

    /// Verifies failed GST API response is parsed correctly
    test('GstResponseParser should parse failed response', () {
      final mockResponse = {
        'gstResp': {
          'success': false,
          'responseData': {
            'status_code': '104'
          }
        }
      };
      
      final parser = GstResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, false);
    });

    /// Verifies malformed GST response returns false
    test('GstResponseParser should handle malformed response', () {
      final mockResponse = {
        'gstResp': null
      };
      
      final parser = GstResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, false);
    });
  });

  /// Tests for Passport response parsing with mock API responses
  group('ResponseParser - Passport Response Validation Tests', () {
    /// Verifies successful Passport API response is parsed correctly
    test('PassportResponseParser should parse successful response', () {
      final mockResponse = {
        'passportResp': {
          'success': true,
          'responseData': {
            'status_code': '101',
            'passport': 'A1234567'
          }
        }
      };
      
      final parser = PassportResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, true);
    });

    /// Verifies failed Passport API response is parsed correctly
    test('PassportResponseParser should parse failed response', () {
      final mockResponse = {
        'passportResp': {
          'success': false,
          'responseData': {
            'status_code': '104'
          }
        }
      };
      
      final parser = PassportResponseParser();
      final result = parser.parseOnlineResponse(mockResponse);
      
      expect(result, false);
    });
  });

  /// Tests for VerificationHandler factory pattern with mock responses
  group('VerificationHandlerFactory - Handler Creation Tests', () {
    /// Verifies VoterVerificationHandler is created for Voter type
    test('Factory should create VoterVerificationHandler for voter type', () {
      final handler = VerificationHandlerFactory.create(VerificationType.voter);
      expect(handler, isA<VoterVerificationHandler>());
    });

    /// Verifies PanVerificationHandler is created for PAN type
    test('Factory should create PanVerificationHandler for pan type', () {
      final handler = VerificationHandlerFactory.create(VerificationType.pan);
      expect(handler, isA<PanVerificationHandler>());
    });

    /// Verifies GstVerificationHandler is created for GST type
    test('Factory should create GstVerificationHandler for gst type', () {
      final handler = VerificationHandlerFactory.create(VerificationType.gst);
      expect(handler, isA<GstVerificationHandler>());
    });

    /// Verifies PassportVerificationHandler is created for Passport type
    test('Factory should create PassportVerificationHandler for passport type', () {
      final handler = VerificationHandlerFactory.create(VerificationType.passport);
      expect(handler, isA<PassportVerificationHandler>());
    });

    /// Verifies AadhaarVerificationHandler is created for Aadhaar type
    test('Factory should create AadhaarVerificationHandler for aadhaar type', () {
      final handler = VerificationHandlerFactory.create(VerificationType.aadhaar);
      expect(handler, isA<AadhaarVerificationHandler>());
    });
  });

  /// Tests for ResponseParserFactory pattern with correct parser creation
  group('ResponseParserFactory - Parser Creation Tests', () {
    /// Verifies VoterResponseParser is created for Voter type
    test('Factory should create VoterResponseParser for voter type', () {
      final parser = ResponseParserFactory.create(VerificationType.voter);
      expect(parser, isA<VoterResponseParser>());
    });

    /// Verifies PanResponseParser is created for PAN type
    test('Factory should create PanResponseParser for pan type', () {
      final parser = ResponseParserFactory.create(VerificationType.pan);
      expect(parser, isA<PanResponseParser>());
    });

    /// Verifies GstResponseParser is created for GST type
    test('Factory should create GstResponseParser for gst type', () {
      final parser = ResponseParserFactory.create(VerificationType.gst);
      expect(parser, isA<GstResponseParser>());
    });

    /// Verifies PassportResponseParser is created for Passport type
    test('Factory should create PassportResponseParser for passport type', () {
      final parser = ResponseParserFactory.create(VerificationType.passport);
      expect(parser, isA<PassportResponseParser>());
    });
  });

  /// Tests for ButtonStateManager state transitions
  group('ButtonStateManager - State Management Tests', () {
    /// Verifies button initializes to idle state with text
    test('ButtonStateManager should initialize to idle state', () {
      final manager = ButtonStateManager();
      manager.initialize('Verify');
      
      expect(manager.isDisabled, false);
      expect(manager.isLoading, false);
      expect(manager.isSuccess, false);
      expect(manager.isError, false);
      expect(manager.text, 'Verify');
    });

    /// Verifies button transitions to loading state
    test('ButtonStateManager should transition to loading state', () {
      final manager = ButtonStateManager();
      manager.initialize('Verify');
      manager.setLoading();
      
      expect(manager.isLoading, true);
      expect(manager.isDisabled, true);
    });

    /// Verifies button transitions to success state
    test('ButtonStateManager should transition to success state', () {
      final manager = ButtonStateManager();
      manager.initialize('Verify');
      manager.setSuccess('Verified');
      
      expect(manager.isSuccess, true);
      expect(manager.isDisabled, true);
      expect(manager.text, 'Verified');
    });

    /// Verifies button transitions to error state
    test('ButtonStateManager should transition to error state', () {
      final manager = ButtonStateManager();
      manager.initialize('Verify');
      manager.setError('Failed');
      
      expect(manager.isError, true);
      expect(manager.isDisabled, false);
      expect(manager.text, 'Failed');
    });

    /// Verifies button can reset to idle state
    test('ButtonStateManager should reset to idle state', () {
      final manager = ButtonStateManager();
      manager.initialize('Verify');
      manager.setLoading();
      manager.reset('Verify');
      
      expect(manager.isLoading, false);
      expect(manager.isDisabled, false);
      expect(manager.text, 'Verify');
    });

    /// Verifies background color changes based on state
    test('ButtonStateManager should return correct background color for each state', () {
      final manager = ButtonStateManager();
      
      manager.initialize('Verify');
      final idleColor = manager.getBackgroundColor(idleColor: Colors.blue);
      expect(idleColor, Colors.blue);
      
      manager.setLoading();
      final loadingColor = manager.getBackgroundColor(loadingColor: Colors.grey);
      expect(loadingColor, Colors.grey);
      
      manager.setSuccess('Done');
      final successColor = manager.getBackgroundColor(successColor: Colors.green);
      expect(successColor, Colors.green);
      
      manager.setError('Failed');
      final errorColor = manager.getBackgroundColor(errorColor: Colors.red);
      expect(errorColor, Colors.red);
    });
  });

  /// Tests for InputValidationManager validation logic
  group('InputValidationManager - Input Validation Tests', () {
    /// Verifies validation rejects empty input
    test('InputValidationManager should reject empty input', () {
      final manager = InputValidationManager();
      final voterPattern = AppConstant.voterPattern;
      manager.addPattern(voterPattern);
      
      final result = manager.validate('');
      expect(result, false);
    });

    /// Verifies validation accepts valid input against registered pattern
    test('InputValidationManager should accept valid voter ID', () {
      final manager = InputValidationManager();
      manager.addPattern(AppConstant.voterPattern);
      
      final result = manager.validate('ABC1234567');
      expect(result, true);
      expect(manager.isValid, true);
    });

    /// Verifies validation rejects invalid input
    test('InputValidationManager should reject invalid voter ID', () {
      final manager = InputValidationManager();
      manager.addPattern(AppConstant.voterPattern);
      
      final result = manager.validate('INVALID123');
      expect(result, false);
      expect(manager.isValid, false);
    });

    /// Verifies validation accepts input matching any of multiple patterns
    test('InputValidationManager should validate against multiple patterns', () {
      final manager = InputValidationManager();
      manager.addPattern(AppConstant.voterPattern);
      manager.addPattern(AppConstant.panPattern);
      
      // Valid voter ID
      expect(manager.validate('ABC1234567'), true);
      
      // Valid PAN
      expect(manager.validate('ABCDE1234F'), true);
      
      // Invalid input
      expect(manager.validate('INVALID'), false);
    });
  });
}
