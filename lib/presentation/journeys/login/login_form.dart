import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/blocs/login/login_bloc.dart';
import 'package:movieapp/presentation/journeys/login/label_field_widget.dart';
import 'package:movieapp/presentation/widgets/button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _usernameController, _passwordController;
  bool enableSignIn = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _usernameController.addListener(() {
      setState(() {
        enableSignIn = _usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        enableSignIn = _usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_32.w,
          vertical: Sizes.dimen_24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_8.h),
              child: Text(
                TranslationConstants.loginToMovieApp.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            LabelFieldWidget(
              label: TranslationConstants.username.t(context),
              hintText: TranslationConstants.enterTMDbUsername.t(context),
              controller: _usernameController,
            ),
            LabelFieldWidget(
              label: TranslationConstants.password.t(context),
              hintText: TranslationConstants.enterPassword.t(context),
              controller: _passwordController,
              isPasswordField: true,
            ),
            SizedBox(height: Sizes.dimen_16.h),
            BlocConsumer<LoginBloc, LoginState>(
                buildWhen: (previous, current) => current is LoginError,
                builder: (context, state) {
                  if (state is LoginError) {
                    return Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.orangeAccent,
                          ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                listenWhen: (previous, current) => current is LoginSuccess,
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteList.home, (route) => false);
                  }
                }),
            Button(
              title: TranslationConstants.signIn.t(context),
              onTap: enableSignIn
                  ? () {
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginInitiateEvent(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  : null,
              isEnabled: enableSignIn,
            )
          ],
        ),
      ),
    );
  }
}
