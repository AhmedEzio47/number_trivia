import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterControls extends StatefulWidget {
  @override
  _RegisterControlsState createState() => _RegisterControlsState();
}

class _RegisterControlsState extends State<RegisterControls> {
  String email = '';
  String password = '';
  String name = '';
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
              hintText: 'John Doe',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
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
            onPressed: dispatchRegisterEvent,
            child: Text('Create account'),
          )
        ],
      ),
    );
  }

  void dispatchRegisterEvent() {
    passwordController.clear();
    BlocProvider.of<AuthBloc>(context)
        .add(RegisterEvent(email: email, password: password, name: name));
  }
}
