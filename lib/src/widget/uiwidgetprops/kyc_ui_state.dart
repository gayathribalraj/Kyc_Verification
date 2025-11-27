class KycUiState {
  final bool isLoading; 
  final bool isValid;
  final bool disabled;
  final bool isError;
  final String buttonText;

  const KycUiState({
    this.isLoading = false,
    this.isValid = false,
    this.disabled = false,
    this.isError = false,
    this.buttonText = 'verify'
  });

  KycUiState copyWith({
    bool? isLoading,
    bool? isValid,
    bool? disabled,
    bool? isError,
    String? buttonText, required bool isSuccess,
  }) {
    return KycUiState(
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      disabled: disabled ?? this.disabled,
      isError: isError ?? this.isError,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}