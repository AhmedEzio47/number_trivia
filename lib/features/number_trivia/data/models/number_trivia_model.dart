import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final String text;
  final int number;
  NumberTriviaModel({required this.text, required this.number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap) {
    return NumberTriviaModel(
        text: jsonMap['text'],
        number: (jsonMap['number'] as num)
            .toInt()); //num can be either double or int
  }

  Map<String, dynamic> toJson() {
    return {
      "text": this.text,
      "number": this.number,
    };
  }
}
