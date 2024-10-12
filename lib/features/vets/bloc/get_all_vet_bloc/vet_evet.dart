import 'package:pawpal/features/vets/models/vetModel.dart';

// Base event
abstract class VetEvent {}

// Request vet list event
class VetListRequested extends VetEvent {}

// Request top-rated vets event
class TopRatedVetsRequested extends VetEvent {
  final List<VetModel> allVets;

  TopRatedVetsRequested(this.allVets);
}
