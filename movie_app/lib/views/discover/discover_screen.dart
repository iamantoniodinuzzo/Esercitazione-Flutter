import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/theme/colors.dart';
import 'package:movie_app/views/routes/app_routes.dart';
import 'package:movie_app/views/search/search_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MovieAppColors.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Discover',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            _buildSearchButton(context),
            const SizedBox(
              height: 18,
            ),
            _buildAdvancedFilteringButton(),
          ],
        ),
      ),
    );
  }

  Align _buildAdvancedFilteringButton() {
    return Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed(AppRoutes.filterable.name);
                },
                icon: const Icon(Icons.filter_alt_outlined),
                label: const Text('Advanced'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: MovieAppColors.secondary,
                  elevation: 15,
                  shadowColor: MovieAppColors.secondary,
                  padding: const EdgeInsets.all(15.0),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          );
  }

  SizedBox _buildSearchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          showSearch(context: context, delegate: SearchScreen());
        },
        icon: const Icon(Icons.search),
        label: const Text('What movie do you want to search to?'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: MovieAppColors.secondary,
          elevation: 15,
          shadowColor: MovieAppColors.secondary,
          padding: const EdgeInsets.all(15.0),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
