import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomeFormState {
  final DropDownValueModel? selectedIncomeSource;

  IncomeFormState({this.selectedIncomeSource});

  IncomeFormState copyWith({DropDownValueModel? selectedIncomeSource}) {
    return IncomeFormState(
      selectedIncomeSource: selectedIncomeSource ?? this.selectedIncomeSource,
    );
  }
}

class IncomeFormNotifier extends StateNotifier<IncomeFormState> {
  IncomeFormNotifier() : super(IncomeFormState());

  void updateSelectedIncome(DropDownValueModel? newIncomeSource) {
    state = state.copyWith(selectedIncomeSource: newIncomeSource);
  }
}

final incomeFormProvider =
StateNotifierProvider<IncomeFormNotifier, IncomeFormState>((ref) {
  return IncomeFormNotifier();
});
