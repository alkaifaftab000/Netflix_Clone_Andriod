import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/constant/app_color.dart';
import 'package:netflix_clone/constant/app_text.dart';
import 'package:netflix_clone/model/search_model.dart' as m;

class Detail extends StatefulWidget {
  final m.Show show;
  const Detail({super.key, required this.show});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () async {
          await EasyLauncher.url(url: widget.show.url);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(
          Icons.play_arrow_rounded,
          size: 30,
          color: Colors.white,
        ),
        label: Text(
          'Play',
          style: AppText.popinsFont(
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: AppColor.homeAppBar,
      body: Stack(
        children: [
          Hero(tag: 'Image${widget.show.id}',
            child: Image.network(
              widget.show.image?.original ?? 'https://th.bing.com/th/id/OIP.nGagK8mwO46xtXvHXjcJbwHaD4?rs=1&pid=ImgDetMain',
              fit: BoxFit.cover,
              height: ss.height,
              width: double.infinity,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: ss.height * 0.6,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.black87,
                    Colors.black54,
                    Colors.transparent
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        widget.show.name,
                        textAlign: TextAlign.center,
                        style: AppText.popinsFont(
                          color: Colors.white,
                          fontWt: FontWeight.bold,
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.movie_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.show.genres.isNotEmpty?
                            'Genre: ${widget.show.genres.join(', ')}':'Genre: Drama',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppText.popinsFont(
                              fontWt: FontWeight.bold,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.language_outlined,
                          color: Colors.white,

                          size: 25,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Language: ${widget.show.language}',
                          style: AppText.popinsFont(
                            color: Colors.white,
                            fontWt: FontWeight.bold,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.flag_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Country: ${widget.show.network?.country?.name ?? 'N/A'}',
                          style: AppText.popinsFont(
                            color: Colors.white,
                            fontWt: FontWeight.bold,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.live_tv_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Network: ${widget.show.network?.name ?? 'N/A'}',
                          style: AppText.popinsFont(
                            color: Colors.white,
                            fontWt: FontWeight.bold,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Summary:',
                      style: AppText.popinsFont(
                        color: Colors.white,
                        fontWt: FontWeight.bold,
                        size: 18,
                      ),
                    ),

                    Text(
                        widget.show.summary,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.popinsFont(
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
