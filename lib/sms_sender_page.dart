import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

import 'entity/models/user.dart';
import 'presenter/blocs/user_bloc/user_bloc.dart';

final Telephony telephony = Telephony.instance;

class SmsSender extends StatefulWidget {
  const SmsSender({Key? key}) : super(key: key);

  @override
  _SmsSenderState createState() => _SmsSenderState();
}

class _SmsSenderState extends State<SmsSender> {
  String? code;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    codeInitial();
    Wakelock.enable();
    Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) => context.read<UserBloc>().add(
            UserFetched(),
          ),
    );
  }

  void codeInitial() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      code = _prefs.getString('verification_code');
    });
  }

  void _sendSMS(String message, List<String> recipents) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('verification_code', message);

    setState(() {
      code = _prefs.getString('verification_code');
      counter++;
    });

    await telephony
        .sendSms(
            message: 'Alemshop, tassyklama kody: $message', to: recipents.first)
        .catchError((onError) {
      print(onError);
    });
  }

  String message = "Alemshop, tassyklama kody:";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is! UserFetchSuccess) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final User user = state.user;
          print(code);
          if (code != user.code || code == null) {
            _sendSMS(user.code, [user.phone]);
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(user.phone),
                const SizedBox(
                  height: 20,
                ),
                Text('$message ${user.code}'),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Sms sany: $counter'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
