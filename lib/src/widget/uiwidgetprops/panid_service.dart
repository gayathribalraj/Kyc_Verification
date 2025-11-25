
import 'package:kyc_verification/kyc_validation.dart';

class PanVerified with VerificationMixin {
  // create instance of class apiclient
  final ApiClient apiClient = ApiClient();


  @override
  Future<Response> verifyOnline(String url, {PanidRequest? request}) {
    return ApiClient().callPost(ApiConfig.panCard, data: request!.toJson());
  }

  @override
  Future<Response> verifyOffline(String assetPath) async {
    return await OfflineVerificationHandler.loadData(assetPath);
  }
}
