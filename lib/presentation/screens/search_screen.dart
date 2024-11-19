import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/routes.dart';
import '../../injection_container.dart';
import '../bloc/search/search_bloc.dart';
import '../widgets/error_view.dart';
import '../widgets/show_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyInjection.sl<SearchBloc>()
        ..add(const PerformNameSearch('Fun')),
      child: Scaffold(
        appBar: AppBar(
          title: const SearchBar(),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return switch (state) {
              SearchInitial() => const Center(
                  child: Text('Search for TV shows'),
                ),
              SearchLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              SearchEmpty(shows: final shows) => ListView.builder(
                  itemCount: shows.length,
                  itemBuilder: (context, index) {
                    final show = shows[index];
                    return ShowCard(
                      show: show,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: show,
                      ),
                    );
                  },
                ),
              SearchSuccess(shows: final shows) => shows.isEmpty
                  ? const Center(child: Text('No shows found'))
                  : ListView.builder(
                      itemCount: shows.length,
                      itemBuilder: (context, index) {
                        final show = shows[index];
                        return ShowCard(
                          show: show,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.details,
                            arguments: show,
                          ),
                        );
                      },
                    ),
              SearchFailure(failure: final failure) => ErrorView(
                  message: failure.message,
                  onRetry: () => context
                      .read<SearchBloc>()
                      .add(const PerformNameSearch('')),
                ),
            };
          },
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search TV shows...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        prefixIcon: const Icon(Icons.search),
      ),
      onChanged: (query) {
        context.read<SearchBloc>().add(PerformNameSearch(query.trim()));
      },
    );
  }
}
