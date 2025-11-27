/*
  @author   : Gayathri
  @created  : 08/11/2025
  @desc     : Abstract verification handler and implementations for different verification types
*/

import 'package:sysmo_verification/kyc_validation.dart';

/// Abstract base class for verification handlers
abstract class VerificationHandler {
  /// Handle online verification via API
  Future<Response> verifyOnline(String url, {dynamic request});

  /// Handle offline verification via asset
  Future<Response> verifyOffline(String assetPath);

  /// Unified verification method
  Future<Response> verify({
    required bool isOffline,
    String? url,
    String? assetPath,
    dynamic request,
  }) async {
    if (isOffline && assetPath != null && assetPath.isNotEmpty) {
      return await verifyOffline(assetPath);
    } else if (!isOffline && url != null && url.isNotEmpty) {
      return await verifyOnline(url, request: request);
    } else {
      throw Exception('No valid data source provided for verification');
    }
  }
}

/// Handler for Voter ID verification
class VoterVerificationHandler extends VerificationHandler {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Response> verifyOnline(String url, {dynamic request}) async {
    return await _apiClient.post(
      voterId,
      data: (request as VoteridRequest).toJson(),
    );
  }

  @override
  Future<Response> verifyOffline(String assetPath) async {
    return await OfflineVerificationHandler.loadData(assetPath);
  }
}

/// Handler for PAN verification
class PanVerificationHandler extends VerificationHandler {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Response> verifyOnline(String url, {dynamic request}) async {
    return await _apiClient.post(
      panCard,
      data: (request as PanidRequest).toJson(),
    );
  }

  @override
  Future<Response> verifyOffline(String assetPath) async {
    return await OfflineVerificationHandler.loadData(assetPath);
  }
}

/// Handler for GST verification
class GstVerificationHandler extends VerificationHandler {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Response> verifyOnline(String url, {dynamic request}) async {
    return await _apiClient.get(url);
  }

  @override
  Future<Response> verifyOffline(String assetPath) async {
    return await OfflineVerificationHandler.loadData(assetPath);
  }
}

/// Handler for Passport verification
class PassportVerificationHandler extends VerificationHandler {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Response> verifyOnline(String url, {dynamic request}) async {
    return await _apiClient.get(url);
  }

  @override
  Future<Response> verifyOffline(String assetPath) async {
    return await OfflineVerificationHandler.loadData(assetPath);
  }
}

/// Handler for Aadhaar verification
class AadhaarVerificationHandler extends VerificationHandler {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Response> verifyOnline(String url, {dynamic request}) async {
    return await _apiClient.get(url);
  }

  @override
  Future<Response> verifyOffline(String assetPath) async {
    return await OfflineVerificationHandler.loadData(assetPath);
  }
}

/// Factory for creating verification handlers
class VerificationHandlerFactory {
  static VerificationHandler create(VerificationType type) {
    return switch (type) {
      VerificationType.voter => VoterVerificationHandler(),
      VerificationType.pan => PanVerificationHandler(),
      VerificationType.gst => GstVerificationHandler(),
      VerificationType.passport => PassportVerificationHandler(),
      VerificationType.aadhaar => AadhaarVerificationHandler(),
    };
  }
}
