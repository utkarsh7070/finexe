import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/ui/authenticate/model/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/login_response_model.dart';

final radioProvider = StateNotifierProvider<RadioNotifier, Role>((ref) {
  return RadioNotifier();
});

final userValidationProvider =
    StateNotifierProvider<UserValidationNotifier, bool>(
  (ref) {
    return UserValidationNotifier();
  },
);
final passwordValidationProvider =
    StateNotifierProvider<PasswordValidationNotifier, bool>(
  (ref) {
    return PasswordValidationNotifier();
  },
);

final dualFocusProvider =
    StateNotifierProvider<FocusViewModel, Map<String, bool>>((ref) {
  return FocusViewModel();
});

final obscureTextProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<String>>((ref) {
  final dio = ref.read(dioProvider);
  return LoginViewModel(const AsyncValue.data(''), dio);
});

class FocusViewModel extends StateNotifier<Map<String, bool>> {
  final FocusNode userFocusNode;
  final FocusNode passFocusNode;

  FocusViewModel()
      : userFocusNode = FocusNode(),
        passFocusNode = FocusNode(),
        super({
          'userFocusNode': false,
          'passFocusNode': false,
        }) {
    userFocusNode
        .addListener(() => _focusListener('userFocusNode', userFocusNode));
    passFocusNode
        .addListener(() => _focusListener('passFocusNode', passFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    userFocusNode
        .removeListener(() => _focusListener('userFocusNode', userFocusNode));
    passFocusNode
        .removeListener(() => _focusListener('passFocusNode', passFocusNode));
    userFocusNode.dispose();
    passFocusNode.dispose();
    super.dispose();
  }
}

class LoginViewModel extends StateNotifier<AsyncValue<String>> {
  final Dio dio;

  LoginViewModel(super.state, this.dio);

  Future<bool> login(String email, String password) async {
    LoginRequestModel loginRequestModel =
        LoginRequestModel(userName: email, password: password);
    // state = const AsyncValue.loading();
    try {
      Response response =
          await dio.post(Api.login, data: loginRequestModel.toJson());
      if (response.statusCode == 200) {
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(response.data);
        SessionService.createSession(
            accessToken: loginResponseModel.items.token,
            employeeId: loginResponseModel.items.employeId,
        name: loginResponseModel.items.roleName,
        email: loginResponseModel.items.userName);
        return true;
      }
      // state = AsyncValue.data(token);
    } catch (e) {
      // state = AsyncValue.error(e);
    }
    return false;
  }
}

class RadioNotifier extends StateNotifier<Role> {
  RadioNotifier() : super(Role.Employee); // Default value for the radio buttons

  // Method to update the selected value
  void select(Role value) {
    state = value;
  }
}

class UserValidationNotifier extends StateNotifier<bool> {
  UserValidationNotifier()
      : super(false); // Default value for the radio buttons

  void checkUsername(value) {
    if (value == '' || value.isEmpty) {
      state = true;
      // return true;
    } else {
      state = false;
    }
  }
// Method to update the selected value
// void select(Role value) {
//   state = value;
// }
}

class PasswordValidationNotifier extends StateNotifier<bool> {
  PasswordValidationNotifier()
      : super(false); // Default value for the radio buttons

  void checkPassword(value) {
    if (value == '' || value.isEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
// Method to update the selected value
// void select(Role value) {
//   state = value;
// }
}

enum Role { Employee, Vendor, Lender }
