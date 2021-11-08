import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/auth/presentation/bloc/auth_bloc.dart';

class LoginControls extends StatefulWidget {
  @override
  _LoginControlsState createState() => _LoginControlsState();
}

class _LoginControlsState extends State<LoginControls> {
  String email = '';
  String password = '';
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'jondoe@emample.com',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 40)),
            ),
            onPressed: dispatchLoginEvent,
            child: Text('Login'),
          )
        ],
      ),
    );
  }

  void dispatchLoginEvent() {
    passwordController.clear();
    BlocProvider.of<AuthBloc>(context)
        .add(LoginEvent(email: email, password: password));
  }
}
