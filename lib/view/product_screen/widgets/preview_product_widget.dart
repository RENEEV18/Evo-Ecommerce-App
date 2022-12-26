import 'package:evo_mart/common/const/const.dart';
import 'package:flutter/material.dart';

class PreviewProductWidget extends StatelessWidget {
  const PreviewProductWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final List<String> image;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 70,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    'http://172.16.5.206:5005/uploads/products/${image[index]}',
                  ),
                ),
                border: Border.all(),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return kWidth;
          },
          itemCount: image.length,
        ),
      ),
    );
  }
}