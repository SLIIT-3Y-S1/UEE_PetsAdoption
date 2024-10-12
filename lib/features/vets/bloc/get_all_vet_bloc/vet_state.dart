import 'package:pawpal/features/vets/models/vetModel.dart';

// Base state
abstract class VetState {}

// Initial state
class VetInitial extends VetState {}

// Loading state for vet list
class VetListLoading extends VetState {}

// Success state for vet list
class VetListSuccess extends VetState {
  final List<VetModel> vetList;
  final List<VetModel> topRatedVets;

  VetListSuccess({required this.vetList, this.topRatedVets = const []});
}

// Failure state for vet list
class VetListFailure extends VetState {
  final String error;
  VetListFailure(this.error);
}

// Loading state for top-rated vets
class TopRatedVetsLoading extends VetState {}

// Success state for top-rated vets
class TopRatedVetsSuccess extends VetState {
  final List<VetModel> topRatedVets;

  TopRatedVetsSuccess(this.topRatedVets);
}

// Failure state for top-rated vets
class TopRatedVetsFailure extends VetState {
  final String error;
  TopRatedVetsFailure(this.error);
}
