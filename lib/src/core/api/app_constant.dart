
class AppConstant {
  static final RegExp panPattern  = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
  static final RegExp gstPattern = RegExp(
    r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$',
  );

  static final RegExp voterPattern = RegExp(r'^[A-Z]{3}\d{7}$');

  static final RegExp passportPattern = RegExp(r'^[A-Z][1-9][0-9]{6}$');

  static final RegExp aadhaarPattern = RegExp('[0-9]{12}');
}
