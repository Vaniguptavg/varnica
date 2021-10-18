import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp_demo/core/utils/app_localizations.dart';
import 'package:loginapp_demo/core/utils/constants.dart';
import 'package:loginapp_demo/presentation/bloc/login/login_bloc.dart';

class LoginButton extends StatelessWidget {
  final bool isValid;

  const LoginButton({Key? key, required this.isValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isValid
          ? () {
        BlocProvider.of<LoginBloc>(context).onLoginPressed('token');
      }
          : null,
      child: Text(
        AppLocalizations.of(context)!
            .translate(loginTexts[LoginTexts.LOGIN]!)!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isValid ? Colors.black : Colors.black26,
          fontSize: 25,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}