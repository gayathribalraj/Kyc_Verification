// Voter Verification UI A wrapper widget for voter ID verification input using KYCTextBox

import 'package:sysmo_verification/kyc_validation.dart';

class VoterVerification extends StatefulWidget {
  final KYCTextBox kycTextBox;
  const VoterVerification({super.key, required this.kycTextBox}) ;

  @override
  State<StatefulWidget> createState() => _VoterVerificationState();
}

class _VoterVerificationState extends State<VoterVerification> {
  @override
  Widget build(BuildContext context) {
    return widget.kycTextBox;
  }
}

// Aadhaar Verification UI A wrapper widget for Aadhaar  verification input using KYCTextBox
class AadhaarVerification extends StatefulWidget {
  final KYCTextBox kycTextBox;
  const AadhaarVerification({super.key, required this.kycTextBox});

  @override
  State<StatefulWidget> createState() => _AadhaarVerificationState();
}

class _AadhaarVerificationState extends State<AadhaarVerification> {
  @override
  Widget build(BuildContext context) {
    return widget.kycTextBox;
  }
}

// Pan Verification UI A wrapper widget for Pan verification input using KYCTextBox


class PanVerification extends StatefulWidget {
  final KYCTextBox kycTextBox;
 const PanVerification({super.key, required this.kycTextBox}) ;

  @override
  State<StatefulWidget> createState() => _PanVerificationState();
}

class _PanVerificationState extends State<PanVerification> {
  @override
  Widget build(BuildContext context) {
    return widget.kycTextBox;
  }
}


// GST Verification UI A wrapper widget for GST verification input using KYCTextBox


class GSTVerification extends StatefulWidget {
  final KYCTextBox kycTextBox;
 const GSTVerification({super.key, required this.kycTextBox}) ;

  @override
  State<StatefulWidget> createState() => _GSTVerificationState();
}

class _GSTVerificationState extends State<GSTVerification> {
  @override
  Widget build(BuildContext context) {
    return widget.kycTextBox;
  }
}

// Passport Verification UI A wrapper widget for Passport verification input using KYCTextBox


class PassportVerification extends StatefulWidget {
  final KYCTextBox kycTextBox;
 const PassportVerification({super.key, required this.kycTextBox}) ;

  @override
  State<StatefulWidget> createState() => _PassportVerificationState();
}

class _PassportVerificationState extends State<PassportVerification> {
  @override
  Widget build(BuildContext context) {
    return widget.kycTextBox;
  }
}




