import 'package:formz/formz.dart';

//create enum

enum EmailValidationError { invalid }

//create class to validate email address

class Email extends FormzInput<String, EmailValidationError> {
  const Email.dirty([String value = '']) : super.dirty(value);

  //expression to validate email
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError validator(String value) {
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}