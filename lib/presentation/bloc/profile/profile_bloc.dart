import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginapp_demo/data/models/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetUserProfileEvent getUserProfileEvent;

  ProfileBloc({required GetUserProfileEvent getUserProfileEvent})
      : assert(getUserProfileEvent != null),
        getUserProfileEvent = getUserProfileEvent, super(ProfileInitial());


  @override
  ProfileState get initialState => Empty();

  @override
  Stream<ProfileState> onEvent(ProfileEvent event) async* {
    super.onEvent(event);
  }
}
