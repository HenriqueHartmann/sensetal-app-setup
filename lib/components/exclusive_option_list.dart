import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class ExclusiveOptionItem {
  final String title;
  final String subtitle;

  ExclusiveOptionItem({
    required this.title,
    required this.subtitle,
  });
}

class ExclusiveOptionsList extends StatefulWidget {
  final List<ExclusiveOptionItem> itensList;
  final ValueChanged<String>? onTap;

  const ExclusiveOptionsList({super.key, required this.itensList, this.onTap});

  @override
  State<ExclusiveOptionsList> createState() => _ExclusiveOptionsListState();
}

class _ExclusiveOptionsListState extends State<ExclusiveOptionsList> {
  int _itemSelected = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.itensList.length,
        (index) => Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _itemSelected = index;
                });
                if (widget.onTap != null) {
                  widget.onTap!(widget.itensList[index].title);
                }
              },
              child: ItemCard(
                title: widget.itensList[index].title,
                subtitle: widget.itensList[index].subtitle,
                isSelected: _itemSelected == index,
              ),
            ),
            const VerticalSpace(size: AppSpaceSize.md)
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;

  const ItemCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)),
        decoration: const BoxDecoration(
          color: AppColors.primary05,
          borderRadius: AppBorderRadius.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
                ),
                const VerticalSpace(size: AppSpaceSize.xs),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                )
              ],
            ),
            const HorizontalSpace(size: AppSpaceSize.xs),
            Container(
              width: getSizeFromEnum(AppSpaceSize.custom, 20),
              height: getSizeFromEnum(AppSpaceSize.custom, 20),
              padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.custom, 2)),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary02,
              ),
              child: Container(
                  padding:
                      EdgeInsets.all(getSizeFromEnum(AppSpaceSize.custom, 2)),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary04,
                  ),
                  child: isSelected
                      ? Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary02,
                          ),
                        )
                      : null),
            ),
          ],
        ),
      ),
    ]);
  }
}
