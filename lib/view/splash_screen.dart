import 'package:flutter/material.dart';
import 'package:netflix_clone/constant/app_color.dart';
import 'package:netflix_clone/constant/app_text.dart';
import 'package:netflix_clone/services/splash_service.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final _splashService = SplashService();
  @override
  void initState() {
    super.initState();
    _splashService.isUserLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homeAppBar,
      body: Padding(padding: const EdgeInsets.only(left: 10,right: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              const SizedBox(height:100),
              const Image(image: AssetImage('assets/images/splash.gif')),
              const Spacer(),
              const CircularProgressIndicator(color: Colors.red,strokeWidth: 1),
              const SizedBox(height: 40),
              Text('NETFLIX',style: AppText.popinsFont(fontWt: FontWeight.bold,color:Colors.white,size: 30)),
              const SizedBox(height: 30),
              Text('This is just a clone of netflix build for learning',style: AppText.popinsFont(fontWt: FontWeight.bold,color:Colors.white,size: 13)),
              const SizedBox(height: 10),
            ]
          ),
        )
      )
    );
  }
}
