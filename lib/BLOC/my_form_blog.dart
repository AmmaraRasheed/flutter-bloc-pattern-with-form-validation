//import file now
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_pattern_flutter/BLOC/Model.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'my_form_event.dart';
part 'my_form_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc() : super(const MyFormState());

  //create  MyFormEvent Class

  //create MyFormState class
  @override
  void onTransition(Transition<MyFormEvent, MyFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

//now check for event
//when user add email to email field then this event is equal to Email chngng
  //then this if runs
  @override
  Stream<MyFormState> mapEventToState(MyFormEvent event) async* {
    if (event is EmailChanged) {

    }
    //if user enter pass then event==Passwordchngng
    else if (event is PasswordChanged) {

    }
    else if (event is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        await Future.delayed(const Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }


}