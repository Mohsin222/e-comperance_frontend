

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Home extends ConsumerWidget {


//   @riverpod
// Future<String> boredSuggestion(BoredSuggestionRef ref) async {
//   final response = await http.get(
//     Uri.https('https://boredapi.com/api/activity'),
//   );
//   final json = jsonDecode(response.body) as Map;
//   return json['activity']! as String;
// }
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final boredSuggestion = ref.watch(boredSuggestionProvider);
//     // Perform a switch-case on the result to handle loading/error states
//     return switch (boredSuggestion) {
//       AsyncData(:final value) => Text('data: $value'),
//       AsyncError(:final error) => Text('error: $error'),
//       _ => const Text('loading'),
//     };
//   }
// }