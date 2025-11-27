import 'package:sysmo_verification/kyc_validation.dart';

String voterId =
    dotenv.env['voter_verification_endpoint'] ??
    'https://dev.connectperfect.io/cloud_gateway/api/v1.0/karza/voterid/v3';
String panCard =
    dotenv.env['pan_verification_endpoint'] ??
    'https://dev.connectperfect.io/cloud_gateway/api/v1.0/karza/Pancard';
