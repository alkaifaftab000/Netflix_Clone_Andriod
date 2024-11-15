import 'package:flutter/material.dart';
import 'package:netflix_clone/constant/app_text.dart';
import 'package:netflix_clone/model/category_model.dart';
import 'package:netflix_clone/view/search.dart';
import 'package:shimmer/shimmer.dart';

class CircularList extends StatefulWidget {
  const CircularList({super.key});

  @override
  State<CircularList> createState() => _CircularListState();
}

class _CircularListState extends State<CircularList> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulating loading data
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget _buildShimmerItem() {
    return SizedBox(
      height: 100,
      width: 120,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[700]!,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 3),
            Container(
              width: 100,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: ss.width,
        height: 130,
        child: _isLoading
            ? ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) => _buildShimmerItem(),
        )
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: MovieGenre.movieGenres.length,
          itemBuilder: (context, index) {
            final genre = MovieGenre.movieGenres[index];
            return SizedBox(
              height: 100,
              width: 120,
              child: Column(
                children: [
                  GestureDetector(
                    onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> SearchScreen(query: MovieGenre.movieGenres[index].name))),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        radius: 47,
                        backgroundImage: NetworkImage(genre.url),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Center(
                    child: Text(
                      genre.name,
                      style: AppText.popinsFont(
                        color: Colors.white,
                        size: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}