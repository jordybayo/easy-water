import 'package:formz/formz.dart';

enum phoneNumberValidationError { invalid }

class PhoneNumber extends FormzInput<String, phoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',);

  @override
  phoneNumberValidationError validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : phoneNumberValidationError.invalid;
  }
}