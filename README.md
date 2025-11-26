
# Sysmo Verification 

## Package introduction

Sysmo Verification is a reusable Flutter package designed to simplify multiple KYC verification processes such as Aadhaar, PAN, Voter ID, Passport, GST, and OTP workflows. It includes UI widgets, service APIs, validation utilities, state properties, and reusable input components. Its primary purpose is to allow developers to integrate a unified KYC workflow into any Flutter application with minimal configuration.

The UI displays a single row containing a reactive text input field along with a customizable Verify button. You can easily change the button text or styling. By simply calling the corresponding class name for any KYC type, the package automatically provides the same UI layout with different underlying functionality.

## Why Use This Package?

- Saves time — no need to build KYC flows again and again

- Ensures consistency — all document types follow same UI/UX pattern

- Modular & maintainable — clear separation between UI, data models, and services



## This package solves that by providing 

- Reusable UI and Customizable widgets 
- Different validation patterns for each kyc
- share service structre based on online or offline
- Same design, different logics 

## Key Features 

### Customizable

Easily customize colors, text, form fields, API endpoints, and JSON configurations as needed.

### Reusable 

Common UI widgets and base classes are shared accross all kyc modules.

```
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                // Textbox section Reactive Form field
                IgnorePointer(
                  ignoring: disabled,
                  child: ReactiveTextField<String>(
                    autofocus: false,
                    keyboardType: getKeyboardType(widget.verificationType),
                    formControlName: widget.formProps.formControlName,
                    onChanged: (control) {
                      //Reset button state when input changes

                      final raw = (control.value ?? '').toString().trim();
                      id = raw;
                      // Validate pattern for either any kyc
                      isValid = (voterIdPattern.hasMatch(raw) ||
                          aadhaPattern.hasMatch(raw) ||
                          panPattern.hasMatch(raw) ||
                          gstPattern.hasMatch(raw) ||
                          passportPattern.hasMatch(raw));
                      setState(() {
                        buttonText = widget.buttonProps.label;
                        isSuccess = false;
                        isError = false;
                        isValid = isValid;
                        disabled = false;
                      });
                    },
                    maxLength: widget.formProps.maxLength,
                    style: widget.styleProps.textStyle ??
                        const TextStyle(fontSize: 14),
                    decoration: widget.styleProps.inputDecoration ??
                        InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: widget.formProps.label,
                              style: widget.styleProps.textStyle ??
                                  const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                              children: [
                                TextSpan(
                                  text: widget.formProps.mandatory ? ' *' : '',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          // Keep error style under the field.
                          errorStyle: widget.styleProps.textStyle ??
                              TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    validationMessages: widget.formProps.validator != null &&
                            widget.formProps.maxLength != null
                        ? {
                            '': (control) {
                              final abstractControl =
                                  control as AbstractControl<dynamic>;
                              final errorMessage = widget.formProps.validator!(
                                abstractControl,
                              );
                              return errorMessage;
                            },
                          }
                        : null,
                  ),
                ),
                // Custom validation error message pattern,
                if (!isValid)
                  Padding(
                    padding: EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      '${widget.validationPattern}',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          //Verify Button
          ElevatedButton(
            style: ButtonStyle(
              // ignore: deprecated_member_use
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => buttonBackgroundColor(),
              ),
              // ignore: deprecated_member_use
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => widget.buttonProps.foregroundColor,
              ),
              // ignore: deprecated_member_use
              padding: MaterialStateProperty.all(widget.buttonProps.padding),
              // ignore: deprecated_member_use
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.buttonProps.borderRadius,
                  ),
                ),
              ),
            ),
          ),
        ]

            onPressed: (){}
      );
    )
  }
```

## How the UI Works

All verification screens follow the same UI structure using a shared layout and a reusable input component.Only the business logic, API model, and validation rules change.

## Common Layout:

* Title (e.g., Aadhaar Verification)
* `KYCTextBox` input field

   ```
   class KYCTextBox extends StatefulWidget {
  final FormProps formProps;
  final StyleProps styleProps;
  final ButtonProps buttonProps;
  final bool isOffline;
  final String? assetPath;
  final String apiUrl;
  final ValueChanged<dynamic> onSuccess;
  final ValueChanged<dynamic> onError;
  final Key? fieldKey;
  final String? validationPattern;
  final VerificationType verificationType;
  final String? kycNumber;

  final ReactiveFormFieldCallback<String>? onChange;
  final bool showVerifyButton;
  const KYCTextBox({super.key, 
    this.fieldKey,
    required this.formProps,
    required this.styleProps,
    this.showVerifyButton = false,
    this.onChange,
    required this.buttonProps,
    required this.isOffline,
    this.assetPath,
    required this.onSuccess,
    required this.onError,
    this.validationPattern,
    required this.apiUrl,
    required this.verificationType,
    this.kycNumber,
  });
   }

   ```
* Verify / Proceed button
* Response display (Success / Error)
* OTP screen (only for Aadhaar)
* Consent screen (optional)
* The UI is simple, predictable, and consistent across all KYC types.

## Installation

Add this to your project’s `pubspec.yaml` dependencies: 
```
dependencies:
  kyc_verification:
    path: ../path_to_kyc_verification   # or version if published

```
Then run:
```
flutter pub get

```
`or`
```
flutter pub add kyc_verification

```
## Usage:
Import the package:

```
import 'package:kyc_verification/kyc_validation.dart';

```

## Then use the main widget where needed. Example for PAN verification:

```
 PanVerification(
  kycTextBox: KYCTextBox(
    validationPattern:,
    formProps:FormProps(
      formControlName: 'pan',
      label: 'panNumber',
      mandatory: true,
       maxLength: 10,
    ),
    // if u want to style the input text fields (optinol)
    styleProps: StyleProps(),
    apiUrl: 'your endpoint'.
    // customize the buttonprops
    buttonProps:ButtonProps(
      label: 'lable name',
      foregroundColor: Colors.white,
    
    )
    // this is optional handler we provid online offline handler 
    isOffline: true / false 
    onSuccess:(value)async{
      print(onSuccess ${value.data})

    }
     onError:(value)async{
      print(onerror $value)

    }
    assetPath:'you path',
    // based on button fuctinallity
   verificationType: VerificationType.pan, 
  kycNumber:form.controls['pan']?.value != null?form.controls['pan']!.value.toString(): null,
  ),),

```
## Supported KYC Types & Behavior

KYC Type	Input Field	Flow Type	Notes

- Aadhaar	: Aadhaar Number	OTP-based	Shows OTP screen after initial validation
- PAN	: PAN Number	Instant verify	Single request → instant result
- Voter ID : 	Voter Number	Instant verify	Single request → instant result
- GST	: GST Number	Instant verify	Single request → instant result
- Passport: Passport Number	Instant verify	Single request → instant result


## Defines configuration for the input field.

 ### Field	Description:

 * FormProps :

    - formControlName	Name of the form control
    - label	Input label
    - hint Placeholder Name
    - mandatory	Is field required?
    - maxLength	Max character limit
    - ValidationFunction? validator

* ButtonProps Controls button behavior:

   - label	 text
   - onPressed	Callback
   - disabled	bool
   - backgroundColor Color
   - foregroundColor Color
   - borderRadius double
   - padding EdgeInsetsGeometry

* StyleProps Manages widget styles:

  -  double borderRadius;
  -  TextStyle textStyle;
  -  EdgeInsetsGeometry padding;
  -  Color backgroundColor;
  -  Color borderColor;
  -  InputDecoration inputDecoration;
  -  CrossAxisAlignment crossAxisAlignment;


















