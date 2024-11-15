import 'package:flutter/material.dart';
import 'package:netflix_clone/constant/app_text.dart';
import 'package:netflix_clone/controller/search_controller.dart';
import 'package:netflix_clone/model/search_model.dart' as m;
import 'package:netflix_clone/view/detail.dart';
import 'package:shimmer/shimmer.dart';

class SquareList extends StatefulWidget {
  final List<String> categories;

  const SquareList({
    super.key,
    required this.categories,
  });

  @override
  State<SquareList> createState() => _SquareListState();
}

class _SquareListState extends State<SquareList> {
  final _searchController = ApiController();
  List<m.Show> _shows = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchShows();
  }

  Future<void> _fetchShows() async {
    try {
      final shows = await Future.wait(
        widget.categories
            .map((category) => _searchController.searchShows(category))
            .toList(),
      );

      if (mounted) {
        setState(() {
          _shows = shows.expand((list) => list).toList()..shuffle();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      debugPrint('Error fetching shows: $e');
    }
  }

  Widget _buildShimmerItem() {
    return SizedBox(
      width: 165,
      height: 230,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[700]!,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 200,
                width: 150,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 120,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    if (_isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: ss.width,
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) => _buildShimmerItem(),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        width: ss.width,
        height: 230,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _shows.length,
          itemBuilder: (context, index) {
            final show = _shows[index];
            return SizedBox(
              width: 165,
              height: 230,
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail(show: _shows[index]))),
                child: Column(
                  children: [
                    Hero(
                      tag: 'Image${show.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          show.image?.original ??
                              'https://jobs.netflix.com/static/images/Netflix-Social-Rectangle.png',
                          fit: BoxFit.cover,
                          height: 200,
                          width: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: 150,
                              color: Colors.grey[800],
                              child:
                                  const Icon(Icons.error, color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      show.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.popinsFont(
                        fontWt: FontWeight.bold,
                        color: Colors.white,
                        size: 13,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
