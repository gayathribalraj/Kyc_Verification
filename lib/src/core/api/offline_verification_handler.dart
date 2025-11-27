/*
  @author   : Gayathri
  @created  : 08/11/2025
  @desc     : Refactored offline verification handler with improved abstraction
*/

import 'package:sysmo_verification/kyc_validation.dart';

/// Handles offline verification by loading data from assets
class OfflineVerificationHandler {
  /// Load JSON data from asset path and return as Response object
  static Future<Response> loadData(String assetPath) async {
    try {
      final String jsonContent = await rootBundle.loadString(assetPath);
      return Response(
        data: json.decode(jsonContent),
        requestOptions: RequestOptions(path: assetPath),
      );
    } catch (e) {
      throw Exception('Failed to load offline data from $assetPath: $e');
    }
  }
}
