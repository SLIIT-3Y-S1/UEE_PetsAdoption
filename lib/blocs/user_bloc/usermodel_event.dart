part of 'usermodel_bloc.dart';

abstract class UsermodelEvent extends Equatable {
  
  const UsermodelEvent();

  @override
  List<Object> get props => [];

}

class GetUserData extends UsermodelEvent {
  
  final String userID;
  const GetUserData({required this.userID});
  
  @override
  List<Object> get props => [userID];
}
