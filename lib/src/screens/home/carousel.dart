import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/models/slide.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    return SizedBox(
      height: 200.0,
      child: Card(
        elevation: 0,
        // borderOnForeground: true,
        color: AppColors.white,
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
                Container(
                  padding: const EdgeInsets.all(20.0),
                  // width: double.infinity,
                  decoration: AppDecorations.transparentToBlackGradient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(slide.title, style: TextStyles.slideTitle),
                      Text(
                        slide.subTitle,
                        style: TextStyles.slideSubtitle,
                      ),
                      SizedBox(height: 10),
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
    );
  }
}
