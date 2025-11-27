/*
  @author   : Gayathri
  @created  : 08/11/2025
  @desc     : Verification enums and state management classes
*/

import 'package:flutter/material.dart';

/// Types of KYC verification supported
enum VerificationType { voter, aadhaar, pan, gst, passport }

/// Button state enumeration
enum ButtonState { idle, loading, success, error }

/// Verification state enumeration
enum VerificationState { pending, verifying, verified, failed }

/// Manages button UI state
class ButtonStateManager {
  ButtonState _state = ButtonState.idle;
  String _text = '';
  bool _disabled = false;

  ButtonState get state => _state;
  String get text => _text;
  bool get isDisabled => _disabled;
  bool get isLoading => _state == ButtonState.loading;
  bool get isSuccess => _state == ButtonState.success;
  bool get isError => _state == ButtonState.error;

  /// Initialize button state
  void initialize(String initialText) {
    _text = initialText;
    _state = ButtonState.idle;
    _disabled = false;
  }

  /// Update button to loading state
  void setLoading() {
    _state = ButtonState.loading;
    _disabled = true;
  }

  /// Update button to success state
  void setSuccess(String successText) {
    _state = ButtonState.success;
    _text = successText;
    _disabled = true;
  }

  /// Update button to error state
  void setError(String errorText) {
    _state = ButtonState.error;
    _text = errorText;
    _disabled = false;
  }

  /// Reset button to idle state
  void reset(String defaultText) {
    _state = ButtonState.idle;
    _text = defaultText;
    _disabled = false;
  }

  /// Get background color based on state
  Color getBackgroundColor({
    Color? idleColor,
    Color? loadingColor,
    Color? successColor,
    Color? errorColor,
  }) {
    return switch (_state) {
      ButtonState.loading => loadingColor ?? Colors.grey,
      ButtonState.success => successColor ?? Colors.green,
      ButtonState.error => errorColor ?? Colors.red,
      ButtonState.idle => idleColor ?? const Color.fromARGB(255, 3, 9, 110),
    };
  }
}

/// Manages input validation state
class InputValidationManager {
  bool _isValid = true;
  final List<RegExp> _patterns = [];

  bool get isValid => _isValid;

  /// Add validation pattern
  void addPattern(RegExp pattern) {
    _patterns.add(pattern);
  }

  /// Validate input against all patterns
  bool validate(String input) {
    if (input.isEmpty) {
      _isValid = false;
      return false;
    }
    _isValid = _patterns.any((pattern) => pattern.hasMatch(input));
    return _isValid;
  }

  /// Reset validation
  void reset() {
    _isValid = true;
  }
}
