import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/vets/bloc/get_all_vet_bloc/vet_bloc.dart';
import 'package:pawpal/features/vets/bloc/get_all_vet_bloc/vet_evet.dart';
import 'package:pawpal/features/vets/bloc/get_all_vet_bloc/vet_state.dart';
import 'package:pawpal/features/vets/widgets/vet_card.dart';

class VetsListScreen extends StatefulWidget {
  const VetsListScreen({super.key});

  @override
  State<VetsListScreen> createState() => _VetsListScreenState();
}

class _VetsListScreenState extends State<VetsListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VetBloc>(context).add(VetListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vets'),
          bottom: const TabBar(
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColors.accentYellow,
            labelStyle: TextStyle(fontSize: 14),
            tabs: [
              Tab(text: 'All Vets'),
              Tab(text: 'Top Rated'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllVetsTab(),
            TopRatedVetsTab(),
          ],
        ),
      ),
    );
  }
}

class AllVetsTab extends StatelessWidget {
  const AllVetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VetBloc, VetState>(
      builder: (context, state) {
        if (state is VetListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VetListSuccess) {
          final vetsList = state.vetList;
          return ListView.builder(
            itemCount: vetsList.length,
            itemBuilder: (context, index) {
              return VetCard(vetModel: vetsList[index]);
            },
          );
        } else if (state is VetListFailure) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

class TopRatedVetsTab extends StatelessWidget {
  const TopRatedVetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current vet list from the state
    final state = BlocProvider.of<VetBloc>(context).state;

    if (state is VetListSuccess) {
      // Trigger fetching top-rated vets based on the existing vet list
      BlocProvider.of<VetBloc>(context)
          .add(TopRatedVetsRequested(state.vetList));
    }
    return BlocBuilder<VetBloc, VetState>(
      builder: (context, state) {
        if (state is TopRatedVetsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VetListSuccess && state.topRatedVets.isNotEmpty) {
          final topRatedVets = state.topRatedVets;
          return ListView.builder(
            itemCount: topRatedVets.length,
            itemBuilder: (context, index) {
              return VetCard(vetModel: topRatedVets[index]);
            },
          );
        } else if (state is TopRatedVetsFailure) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text('No top-rated vets available'));
        }
      },
    );
  }
}
