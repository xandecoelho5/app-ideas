import 'package:flutter/material.dart';
import 'package:github_timeline/models/repository.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../utils/constants.dart';

class RepositoryTimeline extends StatelessWidget {
  const RepositoryTimeline({
    Key? key,
    required this.repository,
    required this.index,
    required this.isLast,
  }) : super(key: key);

  final Repository repository;
  final int index;
  final bool isLast;

  _buildStartChild() {
    String formatDate(String date) {
      final dateParts = date.split('T')[0].split('-');
      return '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';
    }

    return Text(
      formatDate(repository.createdAt),
      style: const TextStyle(color: kInputTextColor, fontSize: 12),
    );
  }

  _buildIndicator() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(color: Colors.white.withOpacity(0.2), width: 4),
        ),
      ),
    );
  }

  _buildEndChild() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            repository.name,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Expanded(
            child: Text(
              repository.description,
              style: const TextStyle(color: kInputTextColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      isFirst: index == 0,
      isLast: isLast,
      startChild: _buildStartChild(),
      indicatorStyle: IndicatorStyle(
        width: 35,
        height: 35,
        indicator: _buildIndicator(),
        drawGap: true,
      ),
      endChild: _buildEndChild(),
    );
  }
}
