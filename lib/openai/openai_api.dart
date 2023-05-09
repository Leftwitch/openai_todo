import 'dart:convert';

import 'package:dart_openai/openai.dart';
import 'package:flutter/services.dart';
import 'package:todo_flutter/types/todo_prediction.dart';

Future<TodoPrediction> predictTodo(String todo, List<String> tags) async {
  String jsonPrompt = await rootBundle.loadString('prompts/prompt.json');
  dynamic jsonParsed = json.decode(jsonPrompt);

  List<OpenAIChatCompletionChoiceMessageModel> messages = [];

  // Prepare Model
  messages.add(
    OpenAIChatCompletionChoiceMessageModel(
      role: 'system',
      content: jsonParsed['system']
          .replaceAll('{TAGS}', tags.join(','))
          .replaceAll('{TIME}', DateTime.now().toIso8601String()),
    ),
  );

  final prompts = jsonParsed['prompts'];
  for (var prompt in prompts) {
    messages.add(
      OpenAIChatCompletionChoiceMessageModel(
        role: 'user',
        content: prompt['user'],
      ),
    );
    messages.add(
      OpenAIChatCompletionChoiceMessageModel(
        role: 'assistant',
        content: prompt['assistant'],
      ),
    );
  }

  // Model Prepared now add out user prompt
  messages.add(
    OpenAIChatCompletionChoiceMessageModel(
      role: 'user',
      content: todo,
    ),
  );

  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    temperature: 0,
    messages: messages,
  );

  final chatCompletionContent = chatCompletion.choices[0].message.content;
  // Json parse logic from https://community.openai.com/t/valid-json-every-time/29271/2
  // To avoid that the chat API starts explaining more than needed
  // which would result in the JSON.decode failing, we just extract the JSON
  // from the response
  final jsonStart = chatCompletionContent.indexOf('{');
  final jsonEnd = chatCompletionContent.lastIndexOf('}') + 1;
  final jsonResponse = chatCompletionContent.substring(jsonStart, jsonEnd);

  dynamic responseParsed = json.decode(jsonResponse);

  DateTime? dateTime = responseParsed['date'] != null
      ? DateTime.parse(responseParsed['date'])
      : null;

  return TodoPrediction(
    predictedTime: dateTime,
    predictedTag: responseParsed['tag'],
    predictedLocation: responseParsed['location'],
  );
}
