import 'package:note_app/base/widget/cubit/base_state.dart';

class TState extends BaseState {
  const TState({super.isLoading});

  TState copyWith({bool? isLoading}) {
    return TState(isLoading: isLoading ?? this.isLoading);
  }
}
