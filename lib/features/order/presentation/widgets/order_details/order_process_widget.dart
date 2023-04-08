import 'package:flutter/material.dart';
import 'package:flutter_timeline/flutter_timeline.dart';
import 'package:flutter_timeline/indicator_position.dart';

import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../domain/entities/order_entity.dart';
import 'update_order_status_widget.dart';

class OrderProcessWidget extends StatefulWidget {
  final OrderEntity order;
  const OrderProcessWidget(this.order, {super.key});

  @override
  State<OrderProcessWidget> createState() => _OrderProcessWidgetState();
}

class _OrderProcessWidgetState extends State<OrderProcessWidget> {
  List<TimelineEventDisplay> events = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => loadEvent());
    super.initState();
  }

  void loadEvent() {
    LoggerHelper.log(widget.order.status.toString());
    for (StatusHistoryEntity status in widget.order.getStatusHistory) {
      events.add(_buildEvent(status));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          "Status History",
          fontWeight: FontWeight.w500,
          fontSize: sp(18),
        ),
        verticalSpace(),
        TimelineTheme(
          data: TimelineThemeData(
            lineColor: kcPrimaryColor,
            gutterSpacing: 0,
            itemGap: 0,
            indicatorPosition: IndicatorPosition.top,
          ),
          child: Timeline(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            indicatorSize: 44,
            events: events,
            anchor: IndicatorPosition.top,
          ),
        ),
        verticalSpace(10),
        UpdateOrderStatusWidget(widget.order),
      ],
    );
  }

  TimelineEventDisplay _buildEvent(StatusHistoryEntity status) {
    return TimelineEventDisplay(
      child: TimelineEventCard(
        padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(10)),
        title: TextWidget(
          status.name,
          fontWeight: FontWeight.w600,
          fontSize: sp(15),
        ),
        content: status.time != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    status.description,
                    fontSize: sp(14),
                    textAlign: TextAlign.left,
                  ),
                  TextWidget(
                    DateTimeHelper.formatDateWithTime(status.time!),
                    fontSize: sp(14),
                    fontWeight: FontWeight.w300,
                    textColor: kcSoftTextColor.withOpacity(0.7),
                  ),
                ],
              )
            : SizedBox(height: h(20)),
      ),
      indicator: Container(
        decoration: BoxDecoration(
          color: status.time != null ? kcPrimaryColor : kcGrey100,
          // color: kcGrey100,
          shape: BoxShape.circle,
        ),
        child: Icon(
          status.icon,
          color: status.time != null ? kcWhite : kcGrey400,
          // color: kcPrimaryColor,
          size: sp(15),
        ),
      ),
    );
  }
}
