import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/services/firebase_methods.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:haash_moving_chart/cores/widgets/text_fields.dart';
import 'package:haash_moving_chart/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: context.read<FirebaseAuthMethods>().formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SpacerWidget(
                  height: 30,
                ),
                DefaultTextFormField(
                    isValidate: true,
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textController:
                        context.read<FirebaseAuthMethods>().emailController),
                const SpacerWidget(
                  height: 20,
                ),
                DefaultTextFormField(
                    isObscure: true,
                    isValidate: true,
                    label: 'Password',
                    textController:
                        context.read<FirebaseAuthMethods>().passwordController),
                const SpacerWidget(
                  height: 20,
                ),
                AuthGradientButton(
                    buttonText: 'Sign In',
                    onPressed: () {
                      if (context
                          .read<FirebaseAuthMethods>()
                          .formKey
                          .currentState!
                          .validate()) {
                        context
                            .read<FirebaseAuthMethods>()
                            .signInWithEmailPassword(context);
                      }
                    }),
              ],
            ),
          )),
    );
  }
}
