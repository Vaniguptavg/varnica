import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp_demo/core/utils/app_localizations.dart';
import 'package:loginapp_demo/core/utils/constants.dart';
import 'package:loginapp_demo/core/utils/future_version.dart';
import 'package:loginapp_demo/injection.dart';
import 'package:loginapp_demo/presentation/bloc/login/login_bloc.dart';
import 'package:loginapp_demo/presentation/bloc/login/login_state.dart';
import 'package:loginapp_demo/presentation/widgets/email_field.dart';
import 'package:loginapp_demo/presentation/widgets/login_button.dart';
import 'package:loginapp_demo/presentation/widgets/password_field.dart';
import 'package:loginapp_demo/presentation/widgets/remember_me_check_box.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = serviceLocator<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // builder: (_) => _bloc,
      create: (BuildContext context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Flutter Clean Architecture',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder(
              bloc: _bloc,
              builder: (context, LoginState state) {
                print('the state is $state');
                if (state.isSuccess!) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    showDialog(
                        context: context, builder: (_) => FutureVersion());
                    _bloc.resetSuccess();
                  });
                }
                return Stack(
                  children: <Widget>[
                    Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          EmailField(
                            error: state.isEmailError!
                                ? AppLocalizations.of(context)!.translate(
                                loginTexts[LoginTexts.INVALID_EMAIL]!)
                                : null,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          PasswordField(
                            error: state.isPasswordError!
                                ? AppLocalizations.of(context)!.translate(
                              loginTexts[LoginTexts.INVALID_PASSWORD]!,
                            )
                                : null,
                          ),
                          RememberMeCheckBox(
                            isChecked: state.isRememberMe!,
                          ),
                          LoginButton(isValid: state.isEnabled!),
                        ],
                      ),
                    ),
                    Center(
                      child: state.isLoading!
                          ? CircularProgressIndicator()
                          : Container(),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}