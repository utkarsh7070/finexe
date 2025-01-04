import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NetworkListener(
      context: context,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // UploadBox(iconData: Icons.add,title: 'sjdbs',subTitle: 'skmxs',),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Forgot Password?',
                              textAlign: TextAlign.start,
                              style: AppStyles.headingTextStyle2,
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        const Text(
                            'Enter your email and we\'ll send you instructions to reset your password'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        AppFloatTextField(
                          inerHint: 'Email',
                          controller: _emailController,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        AppButton(
                          width: MediaQuery.of(context).size.width,
                          label: 'Send reset link',textStyle: AppStyles.buttonLightTextStyle,
                          onTap: () {
      
                          },
                        ),
                        textButton(context),
      
      
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(CupertinoIcons.back,color: AppColors.primary,),
        TextButton(onPressed: () {
          Navigator.pop(context);
          // Navigator.pushNamed(context, AppRoutes.login);
        }, child: const Text('Back to login'))
      ],
    );
  }
}
