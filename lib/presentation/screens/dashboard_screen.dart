import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quadb_tv/presentation/screens/search_screen.dart';

import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    super.key,
  });

  final List<Widget> pages = [HomeScreen(), SearchScreen()];

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => false,
      child: Scaffold(
        body: Stack(
          children: [
            widget.pages[_currentIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: SizedBox(
                  height: 60.h,
                  width: 350.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: BottomAppBar(
                        color: const Color.fromARGB(48, 255, 255, 255),
                        shape: const CircularNotchedRectangle(),
                        notchMargin: 5,
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = 0;
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _currentIndex == 0
                                          ? Icons.home_rounded
                                          : Icons.home_outlined,
                                      color: _currentIndex == 0
                                          ? Colors.white70
                                          : Colors.blueGrey,
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    _currentIndex = 1;
                                  });
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _currentIndex == 1
                                          ? Icons.search_rounded
                                          : Icons.search_outlined,
                                      color: _currentIndex == 1
                                          ? Colors.white70
                                          : Colors.blueGrey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
