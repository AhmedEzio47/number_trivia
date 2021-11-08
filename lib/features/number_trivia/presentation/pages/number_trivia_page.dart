import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/common_widgets/drawer.dart';
import 'package:number_trivia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:number_trivia/injector_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _dispatchFetchUserEvent(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: _buildBody(context),
      drawer: MyDrawer(),
    );
  }

  void _dispatchFetchUserEvent(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(FetchUserEvent());
  }

  BlocProvider<NumberTriviaBloc> _buildBody(BuildContext context) {
    return BlocProvider<NumberTriviaBloc>(
      create: (_) => serviceLocator<NumberTriviaBloc>(),
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is EmptyNumberTrivia) {
                      return MessageDisplay(message: 'Start searching!');
                    } else if (state is ErrorNumberTriviaState) {
                      return MessageDisplay(message: state.errorMessage);
                    } else if (state is LoadingNumberTriviaState) {
                      return LoadingIndicator();
                    } else if (state is ReadyNumberTriviaState) {
                      return TriviaDisplay(trivia: state.trivia);
                    }
                    return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Placeholder(),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TriviaControls()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
