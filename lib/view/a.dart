import 'package:flutter/material.dart';
import 'package:netflix_clone/components/home/circular_list.dart';
import 'package:netflix_clone/components/home/home_carausel.dart';
import 'package:netflix_clone/components/home/square_list.dart';
import 'package:netflix_clone/constant/app_color.dart';
import 'package:netflix_clone/constant/app_text.dart';

class A extends StatefulWidget {
  const A({super.key});
  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.homeAppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: ss.width, child: const HomeCarousel()),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'Genre',
                style: AppText.popinsFont(
                  color: Colors.white,
                  fontWt: FontWeight.bold,
                  size: 30,
                ),
              ),
              icon: const Icon(Icons.category_rounded, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 10),
            const CircularList(),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'Continue Watching',
                style: AppText.popinsFont(
                  color: Colors.white,
                  fontWt: FontWeight.bold,
                  size: 30,
                ),
              ),
              icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 30),
            ),
            const SquareList(
              categories:  ['horror', 'fantasy', 'adventure'],
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'Trending',
                style: AppText.popinsFont(
                  color: Colors.white,
                  fontWt: FontWeight.bold,
                  size: 30,
                ),
              ),
              icon: const Icon(Icons.trending_up_rounded, color: Colors.white, size: 30),
            ),
            const SquareList(
              categories: ['comedy','zombie','action'],
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'Movies',
                style: AppText.popinsFont(
                  color: Colors.white,
                  fontWt: FontWeight.bold,
                  size: 30,
                ),
              ),
              icon: const Icon(Icons.public_rounded, color: Colors.white, size: 30),
            ),
            const SquareList(
              categories: ['Movies'],
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'Web Series',
                style: AppText.popinsFont(
                  color: Colors.white,
                  fontWt: FontWeight.bold,
                  size: 30,
                ),
              ),
              icon: const Icon(Icons.network_check_rounded, color: Colors.white, size: 30),
            ),
            const SquareList(
              categories: ['Web Series'],
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'Drama',
                style: AppText.popinsFont(
                  color: Colors.white,
                  fontWt: FontWeight.bold,
                  size: 30,
                ),
              ),
              icon: const Icon(Icons.sentiment_satisfied_alt_rounded, color: Colors.white, size: 30),
            ),
            const SquareList(
              categories: ['Drama'],
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text(
                'TV Shows',
                style: AppText.popinsFont(
                  color: Colors.white,
                  fontWt: FontWeight.bold,
                  size: 30,
                ),
              ),
              icon: const Icon(Icons.tv_rounded, color: Colors.white, size: 30),
            ),
            const SquareList(
              categories: ['TV Shows'],
            )
          ],

        ),
      ),
    );
  }
}