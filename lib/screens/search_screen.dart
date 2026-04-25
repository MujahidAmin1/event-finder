import 'package:event_finder/models/event.dart';
import 'package:event_finder/screens/detail_screen.dart';
import 'package:event_finder/themes/app_colors.dart';
import 'package:event_finder/themes/slide_up_page_route.dart';
import 'package:event_finder/widgets/event_tile.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Event> events;
  const SearchScreen({super.key, required this.events});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Event> _results = [];
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _hasSearched = true;
      _results = query.trim().isEmpty
          ? []
          : widget.events
                .where(
                  (e) => e.title.toLowerCase().contains(
                    query.trim().toLowerCase(),
                  ),
                )
                .toList();
    });
  }

  void _clear() {
    _searchController.clear();
    setState(() {
      _results = [];
      _hasSearched = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onSubmitted: _search,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Search events...',
            hintStyle: TextStyle(
              color: isDark ? AppColors.hintDark : AppColors.hintLight,
              fontSize: 16,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
          ),
          style: TextStyle(color: cs.onSurface, fontSize: 16),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.close,
                color: isDark ? AppColors.hintDark : AppColors.hintLight,
              ),
              onPressed: _clear,
            ),
        ],
      ),
      body: !_hasSearched
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: isDark
                        ? AppColors.borderDark
                        : Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search for events',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.hintDark
                          : AppColors.hintLight,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : _results.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: isDark
                        ? AppColors.borderDark
                        : Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No results for "${_searchController.text}"',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.hintDark
                          : AppColors.hintLight,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  SlideUpPageRoute(
                    page: DetailScreen(event: _results[index]),
                  ),
                ),
                child: EventTile(event: _results[index]),
              ),
            ),
    );
  }
}
