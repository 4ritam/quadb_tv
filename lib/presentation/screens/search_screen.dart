import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quadb_tv/presentation/widgets/show_horizontal_card.dart';
import 'package:quadb_tv/presentation/widgets/show_vertical_card.dart';
import '../../injection_container.dart';
import '../bloc/search/search_bloc.dart';
import '../widgets/error_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DependencyInjection.sl<SearchBloc>()..add(const PerformEmptyLoad()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 36.h,
            title: const SearchBar(),
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return switch (state) {
                SearchInitial() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                SearchLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                SearchEmpty(shows: final shows) => Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: ListView.builder(
                      itemCount: shows.length,
                      itemBuilder: (context, index) {
                        return ShowHorizontalCard(show: shows[index]);
                      },
                    ),
                  ),
                SearchSuccess(shows: final shows) => Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: shows.isEmpty
                        ? const Center(child: Text('No shows found'))
                        : GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            shrinkWrap: true,
                            crossAxisSpacing: 8.w,
                            mainAxisSpacing: 8.w,
                            children: shows
                                .where((show) =>
                                    (show.originalImageUrl != null ||
                                        show.mediumImageUrl != null))
                                .toList()
                                .map(
                                  (show) => ShowVerticalCard(
                                    show: show,
                                  ),
                                )
                                .toList(),
                          ),
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
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        hintStyle: Theme.of(context).textTheme.titleSmall,
      ),
      onChanged: (query) {
        if (query.trim().isEmpty) {
          context.read<SearchBloc>().add(const PerformEmptyLoad());
        } else {
          context.read<SearchBloc>().add(PerformNameSearch(query.trim()));
        }
      },
    );
  }
}
