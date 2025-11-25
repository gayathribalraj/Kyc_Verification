kyc_verification — Complete Documentation

# Project Overview

kyc_verification is a reusable Flutter package designed to simplify Aadhaar, PAN, and Voter ID etc.. verification processes.

It supports:

Online verification using API services

Offline verification using local JSON assets

Reusable UI components for input fields, OTP forms, and consent screens

Reusable models + props for clean integration with any application architecture

# Features
# KYC Verification Capabilities

Aadhaar verification (OTP-based)

Voter ID verification

PAN verification

GST verification

Passport verification

Offline KYC support using assets

Online API KYC verification (Dio client)

# Reusable UI Components

Custom prop-based widgets for forms, input, buttons & styles

Reusable KYC input field (KYCTextBox)

OTP verification bottom sheet

Consent form screen

# Architecture Overview

The package is structured into clean, independent layers:

UI Components (Widgets)

Reusable input fields, OTP screens, consent dialogs, etc.

Verification Logic

A VerificationMixin that standardizes the verification flow

Service Layer

KYCService for offline + online verification

ApiClient using Dio

OfflineVerificationHandler for JSON loading

Core Models

Models for requests/responses:

PanidRequest

VoteridRequest

Aadhaar models

Error models

Props Layer

Reusable customization models:

FormProps

ButtonProps

StyleProps

# Folder Structure
lib/
 └── kyc_verification/
     ├── widget/
     ├── uiwidgetprops/
     ├── core/
     ├── model/
     ├── service/


Each folder contains separate components for widgets, props, models, and services.

# Installation (Package Creation)

1. To create a Flutter package:

2. flutter create --template=package custom_widgets_library

# How to Use in Main App

1. Add dependency (local path)
dependencies:
  kyc_verification:
    path: D:\Kyc_Verification

2. Import
import 'package:kyc_verification/kyc_validation.dart';

# Usage Example — Voter Verification


VoterVerification(
  kycTextBox: KYCTextBox(
    formProps: FormProps(
      formControlName: 'voterId',
      label: 'Enter Voter ID',
      mandatory: true,
      maxLength: 10,
    ),
  ),
)

# Components Documentation

1. FormProps

Defines configuration for the input field.

Field	Description
formControlName	Name of the form control
label	Input label
mandatory	Is field required?
maxLength	Max character limit
2. ButtonProps

Controls button behavior.

Field	Description
label	Button text
onPressed	Callback
disabled	Enable/Disable the button
3. StyleProps

Manages widget styles.

Field	Description
borderRadius	Corner radius
textStyle	Label + input text style

# Verification Services

1. VerificationMixin

Defines common verification behaviors:

verifyOnline()

verifyOffline()

Used as a shared contract for Voter, PAN, Aadhaar verification flows.

2. KYCService

Centralized entry for verification.

Method:
verify({
  required bool isOffline,
  String? assetPath,
  String? url,
});

# Responsibilities:

Switches between online/offline mode

Calls API using Dio

Loads local assets for offline validation

Returns standardized response

3. ApiClient

Handles network logic.

Features:

Adds API headers

Logs request/response

Supports POST + GET

Error handling wrapper

4. OfflineVerificationHandler

Loads offline JSON data.

Logic:
rootBundle.loadString(assetPath)


Used for:

Testing

Offline onboarding

Backup network failure

# Models Documentation
Example Models
PanidRequest
Field	Type
panNumber	String

Example:

{
  "panNumber": "ABCDE1234F"
}

VoteridRequest
Field	Type
epicNo	String

Example:

{
  "epicNo": "XYZ1234567"
}

#  Widgets
1. VoterVerification

Handles:

Input validation

Triggering KYCService

Loading indicator

Provides response through callbacks

Offline + online fallback

2. ConsentForm

Terms & Conditions

"I agree" checkbox

Accept/Reject actions

OTP trigger option

3. OTP Bottom Sheet

Includes:

6-digit OTP input

Resend option

Loading indicator

Calls API for OTP verification

# Error Handling

Common error cases handled:

Invalid input format

Wrong OTP

API timeout

Missing offline JSON file

No data source provided

Null/empty input

# Sample Offline JSON Response
{
  "success": true,
  "data": {
    "name": "John Doe",
    "voterId": "ABC1234567",
    "state": "Tamil Nadu"
  }
}