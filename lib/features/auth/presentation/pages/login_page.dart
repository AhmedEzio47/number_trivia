import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:number_trivia/features/auth/presentation/pages/register_page.dart';
import 'package:number_trivia/features/auth/presentation/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is EmptyAuthState) {
              return AuthMessageDisplay(message: 'Login in to your account');
            } else if (state is LoadingAuthState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ReadyAuthState) {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
              });
              return Container();
            } else if (state is ErrorAuthState) {
              return AuthMessageDisplay(message: state.errorMessage);
            }
            return AuthMessageDisplay(message: 'Login in to your account');
          }),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .4,
            child: LoginControls(),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(ResetStateEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => RegisterPage(),
                ),
              );
            },
            child: RichText(
              text: TextSpan(
                  text: 'Don\'t have an account?',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Sign up',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
