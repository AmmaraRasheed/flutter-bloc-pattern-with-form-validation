part of 'my_form_blog.dart';

class MyFormState extends Equatable {
//declare variables
  final Email email;
  final Password password;
  final FormzStatus status;

  const MyFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  //copy email with user enter email
  MyFormState copyWith({
    Email email,  //create this email,password classs
    Password password,
    FormzStatus status,
  }) {
    return MyFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];

  @override
  bool get stringify => true;

}