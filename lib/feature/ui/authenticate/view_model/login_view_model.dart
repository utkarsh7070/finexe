import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final rememberProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);

final obscureTextProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<String>>((ref) {
  // final authRepository = ref.watch(authRepositoryProvider);

  return LoginViewModel(const AsyncValue.data('')
      // authRepository: authRepository
      );
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
  LoginViewModel(super.state);

// final AuthRepository authRepository;

// LoginViewModel({required this.authRepository}) : super(const AsyncValue.data(''));

// Future<void> login(String email, String password) async {
//   state = const AsyncValue.loading();
//   try {
//     final token = await authRepository.login(email, password);
//     state = AsyncValue.data(token);
//   } catch (e) {
//     state = AsyncValue.error(e);
//   }
// }
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
