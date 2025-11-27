/*
  @author   : Gayathri
  @created  : 10/11/2025
  @desc     :VerificationMixin to handle online and offline verification 
*/
import 'package:sysmo_verification/kyc_validation.dart';


mixin VerificationMixin {
  Future<Response> verifyOnline(String url);

  Future<Response> verifyOffline(String assetPath);
}

// handle verify offline rootBundle for asset loading.

class OfflineVerificationHandler {
  static Future<Response> loadData(String assetPath) async {
    final String res = await rootBundle.loadString(assetPath);
    return Response(
      data: json.decode(res),
      requestOptions: RequestOptions(path: assetPath),
    );
  }
}
