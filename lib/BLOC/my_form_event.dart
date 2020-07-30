part of 'my_form_blog.dart';

abstract class MyFormEvent extends Equatable {
  const MyFormEvent();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

//event for email
class EmailChanged extends MyFormEvent {

}

//event for password

class PasswordChanged extends MyFormEvent {

}


//event for submit button
class FormSubmitted extends MyFormEvent {}