import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netflix_clone/view/home_view.dart';

class SplashService{
  void isUserLoggedIn(BuildContext context){
    Timer(const Duration(seconds: 6),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const HomeView()));
    });
  }
}