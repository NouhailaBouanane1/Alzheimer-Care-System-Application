import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Gallery/MyImage.dart';
import 'package:graduation_project/Gallery/MyVideo.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationBarvideo extends StatefulWidget {
  @override
  _NavigationBarvideoState createState() => _NavigationBarvideoState();
}

class _NavigationBarvideoState extends State<NavigationBarvideo> {
  int _currentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        index: _currentIndex,
        color: Color(0xff9C27B0),
        backgroundColor: Colors.grey,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(
            Icons.image,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.video_library,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MyImage(),
            MyVideo(),
            // MyGallery(),
          ],
        ),
      ),
    );
  }
}
