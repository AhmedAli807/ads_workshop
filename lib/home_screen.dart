import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadAd();
  }
  BannerAd ? _bannerAd;
  bool isTesting=true;
  String unitId(){
    if(Platform.isAndroid){
      if(isTesting==true){
        return 'ca-app-pub-3940256099942544/6300978111';
      }
      else
        {
          return 'ca-app-pub-2728042388744791/5765995900';
        }
    }
    else if(Platform.isIOS){
      if(isTesting==true){
        return 'ca-app-pub-3940256099942544/6300978111';
      }
      else{
        return '';
      }

    }
    else{
      return '';
    }
    }
  void loadAd(){
    _bannerAd=BannerAd(
        size: AdSize.banner,
        adUnitId: unitId(),
        listener:BannerAdListener(
              onAdLoaded: (ad){
                debugPrint('$ad loaded.');
              },
          onAdFailedToLoad: (ad,err){
                ad.dispose();
          }
        ) ,
        request: const AdRequest())..load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _bannerAd!=null?Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: _bannerAd!.size.height.toDouble(),
                    width: _bannerAd!.size.width.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ):Text('')
              ],
            ),
      ),
    );

  }
  }



