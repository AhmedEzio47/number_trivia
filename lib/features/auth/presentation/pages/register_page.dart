import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:number_trivia/features/auth/presentation/pages/login_page.dart';
import 'package:number_trivia/features/auth/presentation/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register page'),
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
              return AuthMessageDisplay(message: 'Create your account');
            } else if (state is LoadingAuthState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ReadyAuthState) {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                Navigator.pop(context);
              });
              //return AuthMessageDisplay(message: state.user.name);
            } else if (state is ErrorAuthState) {
              return AuthMessageDisplay(message: state.errorMessage);
            }
            return AuthMessageDisplay(message: 'Create your account');
          }),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .4,
            child: RegisterControls(),
          ),
          InkWell(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoginPage(),
              ),
            ),
            child: RichText(
              text: TextSpan(
                  text: 'Already a user?',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Login',
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
