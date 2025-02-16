import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String assetPath1;
    final String assetPath2;


  CustomAppBar({
    super.key,
    required this.title,
    required this.assetPath1,required this.assetPath2
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: bgColor,
      title: CustomText(
        title: title,
        fontFamily: "Poppins",
        fontSize: 26,
      ),
      actions: [
        IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              assetPath1,
              height: 30,
              width: 30,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              assetPath2,
              height: 30,
              width: 30,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
