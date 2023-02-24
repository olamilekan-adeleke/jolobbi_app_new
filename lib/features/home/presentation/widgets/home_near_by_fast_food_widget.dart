import 'package:flutter/material.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';

class HomeNearByFastFoodWidget extends StatelessWidget {
  const HomeNearByFastFoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget("Nearby Restaurants", fontSize: sp(20)),
        verticalSpace(),
        SizedBox(
          height: h(122),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: w(90),
                margin: EdgeInsets.only(right: w(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(sr(15)),
                      child: ImageWidget(
                        imageTypes: ImageTypes.network,
                        imageUrl: "https://picsum.photos/200",
                        height: h(85),
                        width: w(85),
                      ),
                    ),
                    verticalSpace(3),
                    TextWidget(
                      "Restaurant Name",
                      fontSize: sp(14),
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
