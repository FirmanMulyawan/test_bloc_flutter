import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<double> {
  SplashCubit() : super(0.0);

  Future<void> startProgress() async {
    await Future.delayed(const Duration(milliseconds: 600));
    emit(0.5);

    await Future.delayed(const Duration(milliseconds: 600));
    emit(1.0);
  }
}
