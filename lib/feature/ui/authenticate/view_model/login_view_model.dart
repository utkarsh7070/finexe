import 'package:flutter_riverpod/flutter_riverpod.dart';


final radioProvider = StateNotifierProvider<RadioNotifier, Role>((ref) {
  return RadioNotifier();
});

final userValidationProvider = StateNotifierProvider<UserValidationNotifier,bool>((ref) {
  return UserValidationNotifier();
},);
final passwordValidationProvider = StateNotifierProvider<PasswordValidationNotifier,bool>((ref) {
  return PasswordValidationNotifier();
},);

final rememberProvider =  StateProvider<bool>((ref) {
  return false;
},);
final obscureTextProvider =  StateProvider<bool>((ref) {
  return false;
},);
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AsyncValue<String>>((ref) {
  // final authRepository = ref.watch(authRepositoryProvider);

  return LoginViewModel(const AsyncValue.data('')
      // authRepository: authRepository
  );
});

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
  UserValidationNotifier() : super(false);// Default value for the radio buttons

  void checkUsername(value){
  if (value == '' || value.isEmpty) {
    state = true;
    // return true;
  }else{
    state = false;
  }
}
// Method to update the selected value
  // void select(Role value) {
  //   state = value;
  // }
}class PasswordValidationNotifier extends StateNotifier<bool> {
  PasswordValidationNotifier() : super(false); // Default value for the radio buttons

  void checkPassword(value){
    if (value == '' || value.isEmpty) {
      state = true;
    }else{
      state = false;
    }

  }
// Method to update the selected value
  // void select(Role value) {
  //   state = value;
  // }
}
enum Role { Employee, Vendor,Lender }
