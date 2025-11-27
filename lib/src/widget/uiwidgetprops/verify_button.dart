/*
  @author   : Gayathri
  @created  : 08/11/2025
  @desc     : Reusable verify button widget with state management
*/

import 'package:sysmo_verification/kyc_validation.dart';

/// Verify button widget that responds to button state
class VerifyButton extends StatelessWidget {
  final ButtonStateManager stateManager;
  final VoidCallback? onPressed;
  final ButtonProps buttonProps;

  const VerifyButton({
    super.key,
    required this.stateManager,
    this.onPressed,
    required this.buttonProps,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (_) => stateManager.getBackgroundColor(
            idleColor: buttonProps.backgroundColor ?? const Color.fromARGB(255, 3, 9, 110),
            loadingColor: Colors.grey,
            successColor: Colors.green,
            errorColor: Colors.red,
          ),
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (_) => buttonProps.foregroundColor,
        ),
        padding: WidgetStateProperty.all(buttonProps.padding),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonProps.borderRadius),
          ),
        ),
      ),
      onPressed: (!stateManager.isDisabled && !stateManager.isLoading) ? onPressed : null,
      child: stateManager.isLoading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : Text(stateManager.text),
    );
  }
}
