import 'package:flutter/material.dart';
import 'package:netflix_clone/constant/app_color.dart';
import 'package:netflix_clone/constant/app_text.dart';
import 'package:netflix_clone/controller/search_controller.dart';
import 'package:netflix_clone/view/detail.dart';
import 'package:shimmer/shimmer.dart';
import 'package:netflix_clone/model/search_model.dart';

class SearchScreen extends StatefulWidget {
  final String? query;
  const SearchScreen({super.key,this.query});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _apiController = ApiController();
  bool isLoading = false;
  List<Show> searchResults = [];
  String? error;




  Widget _buildShimmerEffect() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: 8, // Number of shimmer items to show
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[850]!,
          highlightColor: Colors.grey[700]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        searchResults = [];
        error = null;
      });
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final results = await _apiController.searchShows(query);
      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to search shows. Please try again.';
        isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      searchResults = [];
      error = null;
      isLoading = false;
    });
  }

  @override
  void initState() {

    super.initState();
    if (widget.query != null) {
    _searchController.text = widget.query!;
    performSearch(widget.query!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homeAppBar,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBar(

                controller: _searchController,
                textStyle: WidgetStateProperty.all(
                  AppText.popinsFont(
                      fontWt: FontWeight.bold,
                      color: Colors.grey.shade200,
                      size: 20),
                ),
                hintText: 'Search for shows',
                hintStyle: WidgetStateProperty.all(
                  AppText.popinsFont(
                      fontWt: FontWeight.bold,
                      color: Colors.grey.shade200,
                      size: 20),
                ),
                trailing: [
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      onPressed: _clearSearch,
                      icon:
                          const Icon(Icons.clear, color: Colors.grey, size: 35),
                    ),
                  IconButton(
                    onPressed: () => performSearch(_searchController.text),
                    icon:
                        const Icon(Icons.search, color: Colors.grey, size: 35),
                  ),
                ],

                backgroundColor: WidgetStateProperty.all(Colors.grey[900]),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                elevation: WidgetStateProperty.all(0),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16),
                ),
                onSubmitted: performSearch,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _clearSearch();
                  } else {
                    performSearch(value);
                  }
                },
              ),
            ),
            Expanded(
              child: error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            error!,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () =>
                                performSearch(_searchController.text),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    )
                  : isLoading
                      ? _buildShimmerEffect()
                      : searchResults.isEmpty
                          ? Center(
                              child: _searchController.text.isEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.send_rounded,size: 100,color: Colors.grey.shade300),
                                          const SizedBox(height: 10,),
                                          Text(
                                            'Start searching for shows',
                                            style: AppText.popinsFont(
                                                fontWt: FontWeight.bold,
                                                color: Colors.grey.shade200,
                                                size: 20),
                                          ),
                                        ])
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.sentiment_dissatisfied_rounded,size: 100,color: Colors.grey.shade300),
                                        const SizedBox(height: 10,),
                                          Text(
                                            'No Result Found',
                                            style: AppText.popinsFont(
                                                fontWt: FontWeight.bold,
                                                color: Colors.grey.shade200,
                                                size: 20),
                                          ),
                                        ]))
                          : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: searchResults.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemBuilder: (context, index) {
                                final show = searchResults[index];
                                return GestureDetector(
                                  onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> Detail(show: show))),
                                  child: Hero(
                                    tag : 'Image${show.id}',
                                    child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  show.image?.medium ??
                                                      'https://via.placeholder.com/300x450',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                      const SizedBox(height: 8),
                                      Text(
                                        show.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ));
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
