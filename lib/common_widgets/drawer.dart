import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:number_trivia/features/auth/presentation/pages/login_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: (MediaQuery.of(context).size.width) * .65,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 200,
            child: Center(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is ReadyAuthState) {
                    return WelcomeMessage(message: 'Hello ${state.user.name}');
                  }
                  return WelcomeMessage(message: 'Hello guest');
                },
              ),
            ),
          ),
          AuthListTile(),
        ],
      ),
    );
  }
}

class AuthListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return ListTile(
        onTap: () => state is ReadyAuthState
            ? _dispatchLogoutEvent(context)
            : _authenticate(context),
        leading: Icon(
          Icons.power_settings_new,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(state is ReadyAuthState ? 'Logout' : 'Login/Register'),
      );
    });
  }

  void _dispatchLogoutEvent(BuildContext context) {
    Navigator.of(context).pop();
    BlocProvider.of<AuthBloc>(context).add(LogoutUserEvent());
  }

  void _authenticate(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LoginPage(),
      ),
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  final String message;

  const WelcomeMessage({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
