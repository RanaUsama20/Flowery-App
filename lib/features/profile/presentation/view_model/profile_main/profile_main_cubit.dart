import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/status.dart';

part 'profile_main_state.dart';

class ProfileMainCubit extends Cubit<ProfileMainState> {
  ProfileMainCubit() : super(const ProfileMainState());
}
