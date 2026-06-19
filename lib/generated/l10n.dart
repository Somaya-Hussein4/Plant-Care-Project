// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Create your new account`
  String get createAccount {
    return Intl.message(
      'Create your new account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get hintFullName {
    return Intl.message('Full Name', name: 'hintFullName', desc: '', args: []);
  }

  /// `Please enter your name`
  String get nameRequired {
    return Intl.message(
      'Please enter your name',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get hintUserName {
    return Intl.message('User Name', name: 'hintUserName', desc: '', args: []);
  }

  /// `Email`
  String get hintEmail {
    return Intl.message('Email', name: 'hintEmail', desc: '', args: []);
  }

  /// `Please enter your email`
  String get emailRequired {
    return Intl.message(
      'Please enter your email',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get hintPassword {
    return Intl.message('Password', name: 'hintPassword', desc: '', args: []);
  }

  /// `Please enter your password`
  String get passwordRequired {
    return Intl.message(
      'Please enter your password',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forgotPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and we'll send you an OTP`
  String get sendOtp {
    return Intl.message(
      'Enter your email and we\'ll send you an OTP',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOtpButton {
    return Intl.message('Send OTP', name: 'sendOtpButton', desc: '', args: []);
  }

  /// `Enter the OTP sent to`
  String get enterOtp {
    return Intl.message(
      'Enter the OTP sent to',
      name: 'enterOtp',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get hintOtp {
    return Intl.message('OTP', name: 'hintOtp', desc: '', args: []);
  }

  /// `Check your email for the OTP`
  String get checkEmail {
    return Intl.message(
      'Check your email for the OTP',
      name: 'checkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password resetted successful`
  String get passwordResetSuccess {
    return Intl.message(
      'Password resetted successful',
      name: 'passwordResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Or continue with`
  String get orContinueWith {
    return Intl.message(
      'Or continue with',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `User data not found`
  String get userDataNotFound {
    return Intl.message(
      'User data not found',
      name: 'userDataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logInLink {
    return Intl.message('Log In', name: 'logInLink', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Log in to your account`
  String get loginToAccount {
    return Intl.message(
      'Log in to your account',
      name: 'loginToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message('Log In', name: 'logIn', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signUpLink {
    return Intl.message('Signup', name: 'signUpLink', desc: '', args: []);
  }

  /// `Plant Disease Detection`
  String get pageTitle {
    return Intl.message(
      'Plant Disease Detection',
      name: 'pageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan Your Crop`
  String get scanTitle {
    return Intl.message(
      'Scan Your Crop',
      name: 'scanTitle',
      desc: '',
      args: [],
    );
  }

  /// `Capture a photo to detect plant diseases`
  String get scanSubtitle {
    return Intl.message(
      'Capture a photo to detect plant diseases',
      name: 'scanSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message('Take Photo', name: 'takePhoto', desc: '', args: []);
  }

  /// `Capture your crop for analysis`
  String get takePhotoSubtitle {
    return Intl.message(
      'Capture your crop for analysis',
      name: 'takePhotoSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Choose from Gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Scanning Tips`
  String get scanningTips {
    return Intl.message(
      'Scanning Tips',
      name: 'scanningTips',
      desc: '',
      args: [],
    );
  }

  /// `Use natural lighting for best results`
  String get tip1 {
    return Intl.message(
      'Use natural lighting for best results',
      name: 'tip1',
      desc: '',
      args: [],
    );
  }

  /// `Focus on affected leaves or stems`
  String get tip2 {
    return Intl.message(
      'Focus on affected leaves or stems',
      name: 'tip2',
      desc: '',
      args: [],
    );
  }

  /// `Keep camera steady to avoid blur`
  String get tip3 {
    return Intl.message(
      'Keep camera steady to avoid blur',
      name: 'tip3',
      desc: '',
      args: [],
    );
  }

  /// `Scan Another Plant`
  String get scanAnotherPlant {
    return Intl.message(
      'Scan Another Plant',
      name: 'scanAnotherPlant',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get seveirtyHigh {
    return Intl.message('High', name: 'seveirtyHigh', desc: '', args: []);
  }

  /// `Medium`
  String get seveirtyMedium {
    return Intl.message('Medium', name: 'seveirtyMedium', desc: '', args: []);
  }

  /// `Low`
  String get seveirtyLow {
    return Intl.message('Low', name: 'seveirtyLow', desc: '', args: []);
  }

  /// `Healthy`
  String get healthy {
    return Intl.message('Healthy', name: 'healthy', desc: '', args: []);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Tomato Plant`
  String get tomatoPlant {
    return Intl.message(
      'Tomato Plant',
      name: 'tomatoPlant',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing your plant...`
  String get analyzingYourPlant {
    return Intl.message(
      'Analyzing your plant...',
      name: 'analyzingYourPlant',
      desc: 'Text shown while the app is analyzing the plant image',
      args: [],
    );
  }

  /// `An unknown error occurred while analyzing the image.`
  String get unknownError {
    return Intl.message(
      'An unknown error occurred while analyzing the image.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `The analysis is inconclusive. Please try again with a clearer image.`
  String get lowConfidenceError {
    return Intl.message(
      'The analysis is inconclusive. Please try again with a clearer image.',
      name: 'lowConfidenceError',
      desc: '',
      args: [],
    );
  }

  /// `Low resolution image. Please take a higher quality photo.`
  String get lowResolutionError {
    return Intl.message(
      'Low resolution image. Please take a higher quality photo.',
      name: 'lowResolutionError',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported plant type. Please scan a different plant.`
  String get unsupportedPlantError {
    return Intl.message(
      'Unsupported plant type. Please scan a different plant.',
      name: 'unsupportedPlantError',
      desc: '',
      args: [],
    );
  }

  /// `Scan History`
  String get scanHistory {
    return Intl.message(
      'Scan History',
      name: 'scanHistory',
      desc: '',
      args: [],
    );
  }

  /// `No Scan Yet`
  String get noScanYet {
    return Intl.message('No Scan Yet', name: 'noScanYet', desc: '', args: []);
  }

  /// `Clear History`
  String get clearHistory {
    return Intl.message(
      'Clear History',
      name: 'clearHistory',
      desc: '',
      args: [],
    );
  }

  /// `Plant Care Guide`
  String get careGuideTitle {
    return Intl.message(
      'Plant Care Guide',
      name: 'careGuideTitle',
      desc: '',
      args: [],
    );
  }

  /// `Articles`
  String get articles {
    return Intl.message('Articles', name: 'articles', desc: '', args: []);
  }

  /// `Videos`
  String get videos {
    return Intl.message('Videos', name: 'videos', desc: '', args: []);
  }

  /// `{count} mins Read`
  String minsRead(int count) {
    return Intl.message(
      '$count mins Read',
      name: 'minsRead',
      desc: '',
      args: [count],
    );
  }

  /// `Profile Image Updated`
  String get profilrImageUpdated {
    return Intl.message(
      'Profile Image Updated',
      name: 'profilrImageUpdated',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `Languages`
  String get languages {
    return Intl.message('Languages', name: 'languages', desc: '', args: []);
  }

  /// `About us`
  String get aboutUs {
    return Intl.message('About us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Profile Image Updated Successfully`
  String get profileImage {
    return Intl.message(
      'Profile Image Updated Successfully',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Plant disease detection`
  String get notifWelcome {
    return Intl.message(
      'Welcome to Plant disease detection',
      name: 'notifWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Remember Your plant needs You`
  String get notifReminder {
    return Intl.message(
      'Remember Your plant needs You',
      name: 'notifReminder',
      desc: '',
      args: [],
    );
  }

  /// `Check soil. It might be dry`
  String get notifSoil {
    return Intl.message(
      'Check soil. It might be dry',
      name: 'notifSoil',
      desc: '',
      args: [],
    );
  }

  /// `Give your plant a sunshine break`
  String get notifSunshine {
    return Intl.message(
      'Give your plant a sunshine break',
      name: 'notifSunshine',
      desc: '',
      args: [],
    );
  }

  /// `Don't forget to water your plant.`
  String get notifWater {
    return Intl.message(
      'Don\'t forget to water your plant.',
      name: 'notifWater',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Profile`
  String get navProfile {
    return Intl.message('Profile', name: 'navProfile', desc: '', args: []);
  }

  /// `Care Guide`
  String get navCareGuide {
    return Intl.message('Care Guide', name: 'navCareGuide', desc: '', args: []);
  }

  /// `History`
  String get navHistory {
    return Intl.message('History', name: 'navHistory', desc: '', args: []);
  }

  /// `Notifications`
  String get navNotifications {
    return Intl.message(
      'Notifications',
      name: 'navNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Plant Care`
  String get plantCare {
    return Intl.message('Plant Care', name: 'plantCare', desc: '', args: []);
  }

  /// `Plant Care is a mobile application dedicated to helping tomato growers keep their plants healthy. In this version, all features are focused exclusively on tomato plants — from disease detection to daily care tips.`
  String get aboutDescription {
    return Intl.message(
      'Plant Care is a mobile application dedicated to helping tomato growers keep their plants healthy. In this version, all features are focused exclusively on tomato plants — from disease detection to daily care tips.',
      name: 'aboutDescription',
      desc: 'About page main description',
      args: [],
    );
  }

  /// `What We Offer:`
  String get whatWeOffer {
    return Intl.message(
      'What We Offer:',
      name: 'whatWeOffer',
      desc: 'Section title for features list',
      args: [],
    );
  }

  /// `Tomato Disease Diagnosis`
  String get featureDiseaseTitle {
    return Intl.message(
      'Tomato Disease Diagnosis',
      name: 'featureDiseaseTitle',
      desc: 'Title for the disease diagnosis feature',
      args: [],
    );
  }

  /// `Snap a photo of your tomato plant, and our AI will analyze it to identify any diseases or pests.`
  String get featureDiseaseDescription {
    return Intl.message(
      'Snap a photo of your tomato plant, and our AI will analyze it to identify any diseases or pests.',
      name: 'featureDiseaseDescription',
      desc: 'Description for the disease diagnosis feature',
      args: [],
    );
  }

  /// `Smart Notifications`
  String get featureNotificationsTitle {
    return Intl.message(
      'Smart Notifications',
      name: 'featureNotificationsTitle',
      desc: 'Title for the smart notifications feature',
      args: [],
    );
  }

  /// `Get reminders to check on your plants as well as alerts for watering your plants based on weather conditions.`
  String get featureNotificationsDescription {
    return Intl.message(
      'Get reminders to check on your plants as well as alerts for watering your plants based on weather conditions.',
      name: 'featureNotificationsDescription',
      desc: 'Description for the smart notifications feature',
      args: [],
    );
  }

  /// `Care Guide`
  String get featureCareGuideTitle {
    return Intl.message(
      'Care Guide',
      name: 'featureCareGuideTitle',
      desc: 'Title for the care guide feature',
      args: [],
    );
  }

  /// `Articles and videos on growing, watering and healing your tomato plants — practical tips for everyday growers.`
  String get featureCareGuideDescription {
    return Intl.message(
      'Articles and videos on growing, watering and healing your tomato plants — practical tips for everyday growers.',
      name: 'featureCareGuideDescription',
      desc: 'Description for the care guide feature',
      args: [],
    );
  }

  /// `This version supports tomato plants only. More plant types are coming soon!`
  String get aboutVersionNote {
    return Intl.message(
      'This version supports tomato plants only. More plant types are coming soon!',
      name: 'aboutVersionNote',
      desc: 'Bottom banner note about version limitations',
      args: [],
    );
  }

  /// `This Project is done as a Graduation Project`
  String get projectDescription {
    return Intl.message(
      'This Project is done as a Graduation Project',
      name: 'projectDescription',
      desc: '',
      args: [],
    );
  }

  /// `Egyptian E-Learning University`
  String get facultyDescription {
    return Intl.message(
      'Egyptian E-Learning University',
      name: 'facultyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0.0`
  String get versionDescription {
    return Intl.message(
      'Version 1.0.0',
      name: 'versionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get confirmLogout {
    return Intl.message(
      'Confirm Logout',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout from your account?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to logout from your account?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
