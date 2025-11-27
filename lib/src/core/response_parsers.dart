/*
  @author   : Gayathri
  @created  : 08/11/2025
  @desc     : Response parser interface and implementations for different verification types
*/

import 'package:sysmo_verification/kyc_validation.dart';

/// Abstract parser for verification responses
abstract class ResponseParser {
  /// Parse online API response and return success status
  bool parseOnlineResponse(dynamic responseData);

  /// Parse offline asset response and return success status
  bool parseOfflineResponse(dynamic responseData);
}

/// Parser for Voter ID verification responses
class VoterResponseParser implements ResponseParser {
  @override
  bool parseOnlineResponse(dynamic responseData) {
    try {
      return responseData['status'] == 'SUCCESS' &&
          responseData['responseCode'] == '200';
    } catch (e) {
      return false;
    }
  }

  @override
  bool parseOfflineResponse(dynamic responseData) {
    try {
      final decodedResponse = jsonDecode(responseData['RESPONSE']);
      final status = decodedResponse['ursh']?['status']?.toString().toUpperCase();
      final responseCode = decodedResponse['ursh']?['responseCode']?.toString();
      return status == 'SUCCESS' && responseCode == '200';
    } catch (e) {
      return false;
    }
  }
}

/// Parser for PAN verification responses
class PanResponseParser implements ResponseParser {
  @override
  bool parseOnlineResponse(dynamic responseData) {
    try {
      return responseData['status'] == 'SUCCESS' &&
          responseData['responseCode'] == '200';
    } catch (e) {
      return false;
    }
  }

  @override
  bool parseOfflineResponse(dynamic responseData) {
    try {
      final panValidation = responseData["PanValidation"];
      return responseData["Success"] == true &&
          panValidation != null &&
          panValidation["success"] == true;
    } catch (e) {
      return false;
    }
  }
}

/// Parser for GST verification responses
class GstResponseParser implements ResponseParser {
  @override
  bool parseOnlineResponse(dynamic responseData) {
    try {
      final gstResp = responseData["gstResp"];
      final statusCode = gstResp?["responseData"]?["status_code"]?.toString();
      return gstResp?["success"] == true && statusCode == "101";
    } catch (e) {
      return false;
    }
  }

  @override
  bool parseOfflineResponse(dynamic responseData) => parseOnlineResponse(responseData);
}

/// Parser for Passport verification responses
class PassportResponseParser implements ResponseParser {
  @override
  bool parseOnlineResponse(dynamic responseData) {
    try {
      final passportResp = responseData["passportResp"];
      final statusCode = passportResp?["responseData"]?["status_code"]?.toString();
      return passportResp?["success"] == true && statusCode == "101";
    } catch (e) {
      return false;
    }
  }

  @override
  bool parseOfflineResponse(dynamic responseData) => parseOnlineResponse(responseData);
}

/// Factory for creating response parsers
class ResponseParserFactory {
  static ResponseParser create(VerificationType type) {
    return switch (type) {
      VerificationType.voter => VoterResponseParser(),
      VerificationType.pan => PanResponseParser(),
      VerificationType.gst => GstResponseParser(),
      VerificationType.passport => PassportResponseParser(),
      VerificationType.aadhaar => VoterResponseParser(), // Default
    };
  }
}
