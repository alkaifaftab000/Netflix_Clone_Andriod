import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/constant/app_text.dart';
import 'package:netflix_clone/controller/search_controller.dart';
import 'package:netflix_clone/model/search_model.dart' as m;
import 'package:netflix_clone/view/detail.dart';
import 'package:shimmer/shimmer.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  HomeCarouselState createState() => HomeCarouselState();
}

class HomeCarouselState extends State<HomeCarousel> {
  final _searchController = ApiController();
  List<m.Show> _shows = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRandomShows();
  }

  Future<void> _fetchRandomShows() async {
    final randomCategories = [
      'horror',
      'fantasy',
      'adventure',
      'action',
      'romance',
      'drama',
      'comedy'
    ];
    final shows = await Future.wait(
      randomCategories
          .map((category) => _searchController.searchShows(category))
          .toList(),
    );
    setState(() {
      _shows = shows.expand((list) => list).toList()..shuffle();
      _isLoading = false;
    });
  }

  Widget _buildShimmerSlide() {
    final ss = MediaQuery.of(context).size;
    return SizedBox(
      height: ss.height * .55,
      width: ss.width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[700]!,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.black54,
          width: ss.width,
          child: Stack(
            children: [
              if (_isLoading)
                Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[700]!,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              else if (_shows.isNotEmpty)
                CarouselSlider.builder(
                  itemCount: _shows.length,
                  itemBuilder: (context, index, realIndex) {
                    final show = _shows[index];
                    return show.image != null
                        ? Stack(
                      children: [
                        GestureDetector(
                          child: Image.network(
                            show.image?.original ??
                                'https://jobs.netflix.com/static/images/Netflix-Social-Rectangle.png',
                            height: ss.height * .55,
                            width: ss.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black87,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : const SizedBox();
                  },
                  options: CarouselOptions(
                    enlargeCenterPage: false,
                    autoPlay: true,
                    height: ss.height * .55,
                    enableInfiniteScroll: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                )
              else
                _buildShimmerSlide(),

              const Positioned(
                left: 10,
                top: 15,
                child: Image(
                  image: AssetImage('assets/images/netflix_logo.png'),
                  height: 65,
                  width: 60,
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: ['Movies', 'TV Shows', 'Fav']
                      .map(
                        (item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        item,
                        style: AppText.popinsFont(
                          color: Colors.grey.shade100.withOpacity(0.7),
                          fontWt: FontWeight.bold,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
              Positioned(
                bottom: -1,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    debugPrint('Tapped');
                    if (_shows.isNotEmpty) {
                      await EasyLauncher.url(url: _shows[_currentIndex].url);
                    }
                  },
                  child: Container(
                    height: ss.height * .55,
                    width: ss.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.black38,
                          Colors.black12,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 130,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20),
                              const Image(image: AssetImage('assets/images/netflix_logo.png'), height: 25, width: 20),
                              const SizedBox(width: 5),

                                Text(
                                  _shows.isNotEmpty && _shows[_currentIndex].genres.isNotEmpty?
                                  _shows[_currentIndex].genres.first:'Drama',
                                  style: AppText.popinsFont(
                                    color: Colors.white,
                                    fontWt: FontWeight.bold,
                                    size: 15,
                                  ),
                                )

                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_shows.isNotEmpty)
                          Text(
                            _shows[_currentIndex].name,
                            style: AppText.popinsFont(
                              color: Colors.white,
                              fontWt: FontWeight.bold,
                              size: 24,
                            ),
                          )
                        else
                          const SizedBox(),
                        const SizedBox(height: 10),
                        if (_shows.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              _shows[_currentIndex].summary,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppText.popinsFont(
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          )
                        else
                          const SizedBox(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'My List',
                                  style: AppText.popinsFont(
                                    color: Colors.white,
                                    fontWt: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            TextButton.icon(
                              onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> Detail(show: _shows[_currentIndex]))),
                              label: Text(
                                'Play  ',
                                style: AppText.popinsFont(
                                  fontWt: FontWeight.bold,
                                  size: 25,
                                ),
                              ),
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.black,
                                size: 45,
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Info',
                                  style: AppText.popinsFont(
                                    color: Colors.white,
                                    fontWt: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (!_isLoading && _shows.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
                  (index) => AnimatedContainer(
                height: 8,
                width: _currentIndex == index ? 30 : 10,
                margin: EdgeInsets.symmetric(
                  horizontal: _currentIndex == index ? 6 : 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                duration: const Duration(seconds: 1),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}