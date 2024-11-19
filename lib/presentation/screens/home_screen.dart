import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadb_tv/core/utils/routes.dart';
import 'package:quadb_tv/injection_container.dart';
import 'package:quadb_tv/presentation/bloc/home/home_bloc.dart';
import 'package:quadb_tv/presentation/widgets/show_card.dart';

import '../widgets/error_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => false,
      child: BlocProvider(
        create: (context) =>
            DependencyInjection.sl<HomeBloc>()..add(LoadShows()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TV Shows'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.search);
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: 'Search',
            ),
          ]),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return switch (state) {
                HomeInitial() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                HomeLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                HomeSuccess(shows: final shows) => ListView.builder(
                    itemCount: shows.length,
                    itemBuilder: (context, index) {
                      final show = shows[index];
                      return ShowCard(
                        show: show,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.details,
                            arguments: show,
                          );
                        },
                      );
                    },
                  ),
                HomeFailure(failure: final failure) => ErrorView(
                    message: failure.message,
                    onRetry: () {
                      context.read<HomeBloc>().add(LoadShows());
                    },
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
