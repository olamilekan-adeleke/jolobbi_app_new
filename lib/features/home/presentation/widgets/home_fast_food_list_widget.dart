import 'package:flutter/material.dart';
import 'package:jolobbi_app_new/cores/constants/constants.dart';

import '../../../../cores/components/components.dart';
import '../../../../cores/utils/sizer_utils.dart';

class HomeFastFoodListWidget extends StatelessWidget {
  const HomeFastFoodListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget("Top Rated Restaurant", fontSize: sp(20)),
        verticalSpace(),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildFastFoodItem();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFastFoodItem() {
    return Container(
      height: h(95),
      margin: EdgeInsets.only(bottom: h(10)),
      padding: EdgeInsets.only(right: w(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          ImageWidget(
            imageTypes: ImageTypes.network,
            imageUrl: "https://picsum.photos/200",
            height: h(95),
            width: w(95),
          ),
          horizontalSpace(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: sw(56),
                    child: TextWidget(
                      "Item & Restaurant",
                      fontSize: sp(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.bookmark_border,
                    color: kcSoftTextColor.withOpacity(0.5),
                    size: sp(20),
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: kcSoftTextColor.withOpacity(0.5),
                    size: sp(15),
                  ),
                  horizontalSpace(5),
                  SizedBox(
                    width: sw(55),
                    child: TextWidget(
                      "452 Grafton St, Boston, MA 02130, USA",
                      fontSize: sp(14),
                      fontWeight: FontWeight.w300,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              verticalSpace(5),
              SizedBox(
                width: sw(61.32),
                child: Row(
                  children: [
                    Icon(Icons.star, color: kcPrimaryColor, size: sp(15)),
                    horizontalSpace(2),
                    TwoSpanTextWidget(
                      "4.5 ",
                      "(1256 Reviews)",
                      fontSize: sp(13),
                      fontSize2: sp(12),
                      fontWeight: FontWeight.w400,
                      fontWeight2: FontWeight.w300,
                      textColor2: kcSoftTextColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    TextWidget(
                      "30 Mins • 1.2km",
                      fontSize: sp(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
