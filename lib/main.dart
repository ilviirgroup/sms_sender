import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sms_sender/utils/app_observer.dart';

import 'presenter/blocs/user_bloc/user_bloc.dart';
import 'sms_sender_page.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: AppObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SmsSender(),
      ),
    );
  }
}

