import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/navigator/navigator.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/utils/utils.dart';

class MenuItemImageWidget extends StatelessWidget {
  MenuItemImageWidget(this.images, {super.key});

  final List<String> images;
  final ValueNotifier<int> currentPos = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final double height = sh(36);
    final double width = sw(100);

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              final String image = images[index];

              return ImageWidget(
                imageTypes: ImageTypes.network,
                imageUrl: image,
                height: height,
                width: width,
              );
            },
            onPageChanged: (value) => currentPos.value = value,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: sp(30)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.map((url) {
                  final int index = images.indexOf(url);

                  return ValueListenableBuilder(
                    valueListenable: currentPos,
                    builder: (_, int value, __) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                          vertical: h(10.0),
                          horizontal: w(2.0),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: value == index
                              ? kcPrimaryColor
                              : kcGrey200.withOpacity(0.8),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              height: h(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sr(20)),
                  topRight: Radius.circular(sr(20)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: AppRouter.instance.goBack,
                  child: Container(
                    margin: EdgeInsets.only(top: h(10), left: w(10)),
                    padding: EdgeInsets.all(sp(10)),
                    decoration: BoxDecoration(
                      color: kcGrey200.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(sr(20)),
                    ),
                    child: Icon(Icons.arrow_back, size: sr(20)),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: h(10), right: w(10)),
                    padding: EdgeInsets.all(sp(10)),
                    decoration: BoxDecoration(
                      color: kcGrey200.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(sr(20)),
                    ),
                    child: Icon(Icons.bookmark_border_outlined, size: sr(20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
