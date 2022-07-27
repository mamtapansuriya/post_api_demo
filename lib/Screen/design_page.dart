import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Design Demo",
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(5.w),
              child: SizedBox(
                //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                height: 25.h,
                width: 100.w,
                child: Stack(
                  children: [
                    Container(
                      height: 20.h,
                      width: 100.w,
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(3.w)),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Make as public comment",
                                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.not_interested_outlined,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Make as anonymus",
                                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.not_interested_outlined, color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8.w,
                      bottom: 2.h,
                      child: ClipPath(
                        child: Container(
                          width: 5.w,
                          height: 3.h,
                          color: Colors.black45,
                        ),
                        clipper: CustomClipPath(),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
