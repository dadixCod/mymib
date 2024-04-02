import 'package:flutter/material.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    this.headline,
    required this.optionTitle,
    required this.price,
    required this.list,
    this.height,
    this.listHight,
  });
  final String? headline;
  final double? height;
  final double? listHight;
  final String optionTitle;
  final String price;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    final constants = Constants(deviseSize: deviseSize);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/coming_soon');
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: deviseSize.width,
            height: height ?? deviseSize.height * 0.5,
            padding: EdgeInsets.only(
                left: 10, right: 10, top: constants.tenVertical * 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headline != null
                    ? Text(
                        headline!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
                Container(
                  height: listHight ?? deviseSize.height * 0.34,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Text(
                        list[index],
                        style: context.textTheme.bodyLarge,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -(constants.tenVertical * 2),
            right: 70,
            left: 70,
            child: Container(
              height: constants.tenVertical * 4,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  optionTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.background,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              width: deviseSize.width * 0.35,
              height: constants.tenVertical * 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.colorScheme.background,
              ),
              child: Center(
                child: Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
