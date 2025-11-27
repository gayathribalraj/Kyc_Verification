/*
  @author   : Gayathri
  @created  : 08/11/2025
  @desc     : Refactored OTP bottom sheet widget
*/

import 'package:sysmo_verification/kyc_validation.dart';

/// OTP bottom sheet dialog
class OtpSheet extends StatefulWidget {
  final String assetPath;
  final String url;
  final bool isOffline;

  const OtpSheet({
    super.key,
    required this.assetPath,
    required this.url,
    this.isOffline = true,
  });

  @override
  State<OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<OtpSheet> {
  late String otpPin;
  late ValueNotifier<bool> isLoading;

  @override
  void initState() {
    super.initState();
    otpPin = '';
    isLoading = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  Future<void> _handleOtpVerification() async {
    if (otpPin.length != 6) {
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1));

      final response = await KYCService().verify(
        isOffline: widget.isOffline,
        request: otpPin,
        assetPath: widget.assetPath,
        url: widget.url,
      );

      isLoading.value = false;

      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context, response);
      }
    } catch (e) {
      isLoading.value = false;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verification failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 30,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter OTP',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          OtpTextField(
            numberOfFields: 6,
            showFieldAsBox: true,
            fieldWidth: 45,
            filled: true,
            fillColor: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            onCodeChanged: (value) {
              otpPin = value;
            },
            onSubmit: (value) {
              otpPin = value;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleOtpVerification,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: const Color.fromARGB(255, 3, 9, 110),
              foregroundColor: Colors.white,
            ),
            child: ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (context, loading, _) {
                return loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : const Text("Verify OTP");
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// Show OTP bottom sheet dialog
Future<dynamic> showOtpBottomSheet(
  BuildContext context,
  String assetPath,
  String url, {
  bool isOffline = true,
}) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => OtpSheet(
      assetPath: assetPath,
      url: url,
      isOffline: isOffline,
    ),
  );
}
