import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/screens/home/carousel.dart';

class HomeScreen extends StatelessWidget {
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        // child: ListView(
        //   children: <Widget>[
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         SizedBox(height: 10),
        //         Carousel(),
        //         SizedBox(height: 40),
        //         Text("Hot items", style: TextStyles.subTitle),
        //         SizedBox(height: 10),
        //         ConstrainedBox(
        //           constraints: BoxConstraints(
        //             minHeight: 80,
        //             maxHeight: double.infinity,
        //           ),
        //           child: Container(
        //             child: GridView.count(
        //               crossAxisCount: 2,
        //               shrinkWrap: true,
        //               scrollDirection: Axis.vertical,
        //               physics: NeverScrollableScrollPhysics(),
        //               childAspectRatio: .75,
        //               children: List.generate(100, (index) {
        //                 return productCard(index);
        //               }),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Sliver App Bar',
              ),
              floating: true,
              // centerTitle: true,
              elevation: 4.0,
              // expandedHeight: 120.0,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Image.network(
              //     'http://lorempixel.com/output/abstract-q-c-1920-1080-8.jpg',
              //     fit: BoxFit.cover,
              //   ),
              //   title: Text('Spacebar Title'),
              // ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 5.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.purple[100 * (index % 9)],
                    child: Text('Grid Item: $index'),
                  );
                },
                childCount: 1002,
              ),
            ),
            // SliverFillViewport(
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         child: Text('Sliver Fill Viewport'),
            //         color: Colors.lightBlue,
            //       );
            //     },
            //     childCount: 2,
            //   ),
            // ),
            // SliverFixedExtentList(
            //   itemExtent: 50.0,
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         alignment: Alignment.center,
            //         color: Colors.indigo[100 * (index % 9)],
            //         child: Text('List Item: $index'),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  productCard(int index) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Image.network(
              "https://source.unsplash.com/200x300/?fashion-product",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text("Product name $index"),
          )
        ],
      ),
      // margin: EdgeInsets.only(bottom: 20, top: 5, left: 4, right: 4),
    );
  }
}
