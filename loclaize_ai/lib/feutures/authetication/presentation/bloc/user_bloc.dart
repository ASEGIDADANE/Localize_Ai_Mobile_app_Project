


import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loclaize_ai/core/error/faliure.dart';
import 'package:loclaize_ai/feutures/authetication/domain/entity/user_entity.dart';
import 'package:loclaize_ai/feutures/authetication/domain/usecase/signin_usecase.dart';
import 'package:loclaize_ai/feutures/authetication/domain/usecase/signup_usecase.dart';


import 'user_event.dart';
import 'user_state.dart';



 
class UserBloc extends Bloc<UserEvent, UserState> {
   
  final SignupUsecase signUpUsecase;
  final SigninUsecase signInUsecase;

  UserBloc({
    required this.signUpUsecase,
    required this.signInUsecase,
  }) : super(UserInitialState()){
      

   
    
    on<SignUpEvent> ((event,emit)async{
      emit(UserLoadingState());
      final Either<Failure, bool> result = await signUpUsecase.excute(event.user);
      result.fold(
        (failure) => emit(UserErrorState(errorMessage: failure.message)),
        (check) => emit(UserSignUpState(successful: check)),
      );
      });

    on<SignInEvent> ((event,emit)async{
      emit(UserLoadingState());
      final Either<Failure, UserEntity> result = await signInUsecase.excute(event.user);
      result.fold(
        (failure) => emit(UserErrorState(errorMessage: failure.message)),
        (check) => emit(UserLoggedInState(userData: check)),
      );
      });
  }
  }