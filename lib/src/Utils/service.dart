import 'package:sysmo_verification/kyc_validation.dart';

class KYCService extends KycVerification{
  Future<Response> verify({
    required bool isOffline,
    String? request,
    String? url,
    String? assetPath,
  }) async {
    try {
      if (isOffline && assetPath!.isNotEmpty) {
        return await verifyOffline(assetPath);
      } else if (!isOffline && url!.isNotEmpty) {
        return await verifyOnline(url);
      } else {
        throw Exception('No data source provided');
      }
    } catch (error) {
      throw Exception(error.toString);
    }
    
  }
    
}

class KycVerification with VerificationMixin {
 @override
  Future<Response> verifyOffline(String assetPath) =>
      OfflineVerificationHandler.loadData(assetPath);

  @override
  Future<Response> verifyOnline(String url) async => ApiClient().callGet(url);
}