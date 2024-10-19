import 'dart:developer';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../base/routes/routes.dart';
import '../../../base/utils/namespase/display_size.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final focusStates = ref.watch(dualFocusProvider);
    final focusViewModel = ref.read(dualFocusProvider.notifier);
    final loginState = ref.watch(loginViewModelProvider.notifier).isLoading;
    final loginStateViewModel = ref.read(loginViewModelProvider.notifier);
    // final selectedValue = ref.watch(radioProvider);
    final obscureValue = ref.watch(obscureTextProvider);
    final passwordValidations = ref.watch(passwordValidationProvider);
    final userValidations = ref.watch(userValidationProvider);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: displayWidth(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login_bg.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SizedBox(
                  width: displayWidth(context),
                  height: displayHeight(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: displayHeight(context) * 0.15,
                        width: displayWidth(context) * 0.30,
                        // decoration: const BoxDecoration(
                        child: Image.asset('assets/images/logo_finexe.png'),
                      ),
                      Text(
                        'Welcome Back to\nFinTech',
                        style: AppStyles.headingTextStyleXL,
                      ),
                      Text(
                        'Hello there, login to continue',
                        style: AppStyles.subHeading,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.04,
                      ),
                      AppFloatTextField(
                        // initialValue: 'dfgbfgbnx',
                        focusNode: focusViewModel.userFocusNode,
                        currentState: focusStates['userFocusNode'],
                        // focusNode: ,
                        inerHint: 'Enter Your ID',
                        height: userValidations
                            ? displayHeight(context) * 0.09
                            : null,
                        onFiledSubmitted: (value) {
                          log('onFiledSubmitted');
                          ref
                              .read(userValidationProvider.notifier)
                              .checkUsername(value.toString());
                        },
                        onValidate: (value) {
                          print(value);
                          if (value!.trim().isEmpty) {
                            return "username is a required field";
                          }
                          return '';
                        },
                        errorText: "username is a required field",
                        isError: userValidations,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: displayHeight(context) * 0.04),

                      AppFloatTextField(
                        // initialValue: 'cvfcfbcvb',
                        maxLine: 1,
                        focusNode: focusViewModel.passFocusNode,
                        currentState: focusStates['passFocusNode'],
                        height: passwordValidations
                            ? displayHeight(context) * 0.09
                            : null,
                        // focusNode: FocusNode(),
                        onValidate: (value) {
                          print(value);
                          if (value!.isEmpty) {
                            return "password is a required field";
                          }
                          return '';
                        },
                        onFiledSubmitted: (value) {
                          ref
                              .read(passwordValidationProvider.notifier)
                              .checkPassword(value);
                        },
                        inerHint: 'Password',
                        errorText: "password is a required field",
                        isError: passwordValidations,
                        textInputAction: TextInputAction.next,
                        isSuffix: true,
                        obscureText: obscureValue,
                        suffixIcon: obscureValue
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        suffixOnTap: () {
                          if (obscureValue != true) {
                            ref.read(obscureTextProvider.notifier).state = true;
                          } else {
                            ref.read(obscureTextProvider.notifier).state =
                                false;
                          }
                        },
                        hint: 'Password',
                        controller: _passwordController,
                      ),
                      // const Text('Role'),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     radio(
                      //         context: context,
                      //         selectedValue: selectedValue,
                      //         ref: ref,
                      //         title: 'Employee',
                      //         value: Role.Employee),
                      //     radio(
                      //         context: context,
                      //         selectedValue: selectedValue,
                      //         ref: ref,
                      //         title: 'Vendor',
                      //         value: Role.Vendor),
                      //     radio(
                      //         context: context,
                      //         selectedValue: selectedValue,
                      //         ref: ref,
                      //         title: 'Lender',
                      //         value: Role.Lender),
                      //   ],
                      // ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.forgot);
                              },
                              child: const Text('Forgot Password?')),
                        ),
                      ),
                      // const Remember(),
                      SizedBox(height: displayHeight(context) * 0.07),
                      // _loginButton(
                      //     passValidate: passwordValidations,
                      //     userValidate: userValidations),

                      // loginState.when(
                      //   data: (data) {
                      //     return
                      AnimatedSwitcher(
                        duration: const Duration(
                            milliseconds: 300), // Animation duration
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        child: loginState!
                            ? const CircularProgressIndicator(
                                key: ValueKey(
                                    'loading'), // Key for progress indicator
                              )
                            : AppButton(
                                key: const ValueKey('button'), // Key for button
                                width: displayWidth(context),
                                height: displayHeight(context) * 0.06,
                                textStyle:
                                    const TextStyle(color: AppColors.white),
                                label: 'Log In',
                                onTap: () {
                                  final user = _emailController.text.isEmpty;
                                  final pass = _passwordController.text.isEmpty;
                                  if (user || pass) {
                                    ref
                                        .read(userValidationProvider.notifier)
                                        .checkUsername(_emailController.text);
                                    ref
                                        .read(
                                            passwordValidationProvider.notifier)
                                        .checkPassword(
                                            _passwordController.text);
                                  } else {
                                    // Trigger the login and show snackbar or navigate based on success
                                    loginStateViewModel
                                        .login(_emailController.text,
                                            _passwordController.text)
                                        .then((value) {
                                      if (value) {
                                        showCustomSnackBar(context,
                                            'Login Successful', Colors.green);
                                        Navigator.pushNamed(
                                            context, AppRoutes.dashBoard);
                                      } else {
                                        showCustomSnackBar(context,
                                            'User Name Not Found', Colors.red);
                                      }
                                    });
                                  }
                                },
                              ),
                      ),
                      //  },
                      // error: (error, stackTrace) =>
                      //     Text('Error: ${error.toString()}'),
                      // loading: () => Center(
                      //   child: CircularProgressIndicator(),
                      // ),
                      // ),

                      SizedBox(
                        height: displayHeight(context) * 0.05,
                      ),
                      Center(
                        child: SizedBox(
                            width: displayWidth(context) * 0.03,
                            child: const Divider(
                              height: 2,
                              color: AppColors.gray,
                            )),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.05,
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            height: displayHeight(context) * 0.04,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'If you have not any id for the log in purpose\nso you ca get you id send request for ',
                                style: AppStyles.headingTextStyleFooter,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Get ID',
                                    style: AppStyles.smallTextStyleRich,
                                  ),
                                ],
                              ),
                            ),
                          )
                          // Text(
                          //   '© 2024 - Fincoopers Capital Private Limited *All Rights Reserved',
                          //   style: AppStyles.smallTextStyle,
                          // ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _loginButton(
  //     {required bool passValidate, required bool userValidate}) {
  //   return
  //
  //   //   SizedBox(
  //   //   child: ElevatedButton(
  //   //     onPressed: () {
  //   //       if (_formKey.currentState!.validate()) {
  //   //         final email = _emailController.text;
  //   //         final password = _passwordController.text;
  //   //         // ref.read(loginViewModelProvider.notifier).login(email, password);
  //   //       }
  //   //     },
  //   //     child: const Text('Login'),
  //   //   ),
  //   // );
  // }

  Widget _successMessage(String token) {
    return Text('Login successful! Token: $token');
  }

  Widget _errorMessage(String error) {
    return Column(
      children: [
        Text('Login failed: $error', style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 16),
        // _loginButton(passValidate: null),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

Widget radio(
    {required BuildContext context,
    required Role selectedValue,
    required WidgetRef ref,
    required String title,
    required Role value}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.30,
    child: Row(
      children: [
        Radio<Role>(
          value: value,
          groupValue: selectedValue,
          onChanged: (value) {
            if (value != null) {
              ref.read(radioProvider.notifier).select(value);
            }
          },
        ),
        Text(
          title,
        )
      ],
    ),
  );
}
