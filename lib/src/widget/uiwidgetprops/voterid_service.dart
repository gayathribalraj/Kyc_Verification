
// import 'package:dio/src/response.dart';
import 'package:sysmo_verification/kyc_validation.dart';
import 'package:sysmo_verification/kyc_validation.dart' as ApiConfig;


class VoterVerified with VerificationMixin {
  // create instance of class apiclient
  final ApiClient apiClient = ApiClient();


  @override
  Future<Response> verifyOnline(String url, {VoteridRequest? request}) {
    return ApiClient().callPost(ApiConfig.voterId, data: request!.toJson());
  }

  @override
  Future<Response> verifyOffline(String assetPath) async {
    return await OfflineVerificationHandler.loadData(assetPath);
  }
}
