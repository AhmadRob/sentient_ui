import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

class ListsGridsSection extends StatelessWidget {
  const ListsGridsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SentientColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SentientHeadingEnhanced('5. Lists & Grids'),
        SentientSizedBox(height: 10),
        SentientText('SentientGridView (ShrinkWrap):'),
        SentientSizedBox(height: 8),
        // Fix grid view by constraining height since shrinkwrap inside column can be tricky
        SizedBox(
          height: 80,
          child: SentientGridView(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            children: List.generate(
              4,
              (i) => SentientContainer(
                color: Colors.indigo.withOpacity(0.1),
                child: Center(child: Text('${i + 1}')),
              ),
            ),
          ),
        ),
        SentientSizedBox(height: 16),
        SentientText('SentientListView (Horizontal):'),
        SentientSizedBox(height: 8),
        SentientSizedBox(
          height: 50,
          child: SentientListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              5,
              (i) => Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: SentientContainer(
                  width: 50,
                  color: Colors.amber.withOpacity(0.2),
                  child: Center(child: Text('L${i + 1}')),
                ),
              ),
            ),
          ),
        ),
        SentientDivider(),
      ],
    );
  }
}
