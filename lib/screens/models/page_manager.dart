import 'package:flutter/material.dart';

class PageManager {
  PageManager(this._pageController);

  PageController _pageController;

  int currentPage = 0;

  setPage(int page) {
    if (page == currentPage) return;
    currentPage = page;
    _pageController.jumpToPage(page);
  }
}
