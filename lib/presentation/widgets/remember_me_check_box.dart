import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp_demo/core/utils/app_localizations.dart';
import 'package:loginapp_demo/core/utils/constants.dart';
import 'package:loginapp_demo/presentation/bloc/login/login_bloc.dart';

class RememberMeCheckBox extends StatefulWidget {
  final bool isChecked;

  const RememberMeCheckBox({Key? key, required this.isChecked})
      : super(key: key);

  @override
  _RememberMeCheckBoxState createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 15,
      ),
      child: GestureDetector(
        onTap: () {
          print('trigger ');
          BlocProvider.of<LoginBloc>(context).triggerRememberMe();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.black,
                selectedRowColor: Colors.black,
              ),
              child: Checkbox(
                value: widget.isChecked,
                onChanged: (_) =>
                    BlocProvider.of<LoginBloc>(context).triggerRememberMe(),
                checkColor: Colors.white,
                activeColor: Colors.black,
              ),
            ),
            Text(
              AppLocalizations.of(context)!
                  .translate(loginTexts[LoginTexts.REMEMBER_ME]!)!,
            ),
          ],
        ),
      ),
    );
  }
}
