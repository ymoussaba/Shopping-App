import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shopping_app/src/models/slide.dart';

class HomeScreen extends StatelessWidget {
  var slides = [
    Slide(
      title: "FASHIZ",
      subTitle: "Get the latest trend in fashion",
      image: "https://source.unsplash.com/600x400/?fashion",
    ),
    Slide(
      title: "GET READY",
      subTitle: "Never be late anymore with this collection of watches",
      image: "https://source.unsplash.com/600x400/?watch",
    ),
    Slide(
      title: "SMART",
      subTitle: "Make your home more comfortable and pleasant",
      image: "https://source.unsplash.com/600x400/?smart home",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "HOME",
          style: TextStyles.title,
        ),
        actions: <Widget>[
          InkWell(
            // splashColor: AppColors.white,
            highlightColor: AppColors.primary.withAlpha(35),
            radius: 16,
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Image.asset(
              ImagesResources.chatIcon,
              height: 32,
              width: 32,
              color: AppColors.black,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 200.0,
              child: Card(
                elevation: 20,
                borderOnForeground: true,
                color: AppColors.primary,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    final slide = slides[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            height: 32,
                            width: 32,
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Image.network(
                          slide.image,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(slide.title, style: TextStyles.slideTitle),
                              Text(
                                slide.subTitle,
                                style: TextStyles.slideSubtitle,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: slides.length,
                  pagination: SwiperPagination(),
                  autoplay: true,
                  indicatorLayout: PageIndicatorLayout.SCALE,
                  // containerHeight: 280,
                  // itemHeight: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
