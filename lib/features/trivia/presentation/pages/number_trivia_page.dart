import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momobill/features/trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:momobill/features/trivia/presentation/wigdets/widgets.dart';
import 'package:momobill/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {

  Future start(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => NumberTriviaPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Number Trivia')),
        body: SingleChildScrollView(child: buildBody(context)));
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(message: 'Start searching!');
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return TriviaDisplay(
                    numberTrivia: state.trivia,
                  );
                } else if (state is Error) {
                  return MessageDisplay(
                    message: state.message,
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(height: 20),
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
