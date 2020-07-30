import 'package:bloc_pattern_flutter/BLOC/my_form_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class MyApp121 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.brown,
            title: Text('Flutter Form Validation',
            )),
        body: BlocProvider(
          create: (context) => MyFormBloc(), //create this class now
          child: MyForm(),
        ),
      ),
    );
  }
}

//Now create this form Class::
class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFormBloc, MyFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Scaffold.of(context).hideCurrentSnackBar();
          showDialog(
            context: context,
            builder: (_) => SuccessDialog(),//now create this success dialog widget
          );
        }
        if (state.status.isSubmissionInProgress) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Submitting...')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          child: Column(
            children: <Widget>[
              EmailInput(),   //create this email class
              PasswordInput(),  //now create a widget for password field
              SubmitButton(),  //create button
            ],
          ),
        ),
      ),
    );
  }
}
//Email Field
class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      buildWhen: (previous, current){
        print(previous.email);
        print(current.email);
        return previous.email != current.email;

      },
      builder: (context, state) {

        return TextFormField(
          initialValue: state.email.value,
          decoration: InputDecoration(
            icon: Icon(Icons.email,color: Colors.brown,),
            labelText: 'Email',
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.bloc<MyFormBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

//Password field
class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          decoration: InputDecoration(
            icon: Icon(Icons.lock,color:Colors.brown),
            labelText: 'Password',
            errorText: state.password.invalid ? 'Invalid Password' : null,
          ),
          obscureText: true,
          onChanged: (value) {
            context.bloc<MyFormBloc>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }
}

//create button
class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          color:Colors.brown,

          onPressed: state.status.isValidated
              ? () => context.bloc<MyFormBloc>().add(FormSubmitted())
              : null,
          child: Text('Submit',style:
          TextStyle(
              color:Colors.white
          ),),
        );
      },
    );
  }
}

//success dialog
class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

