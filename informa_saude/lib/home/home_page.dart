import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:informa_saude/home/home_controller.dart';
import 'package:informa_saude/map/map_controller.dart';
import 'package:informa_saude/statistics/statistics_controller.dart';
import '../map/map_page.dart';
import '../news/news_page.dart';
import '../profile/profile_page.dart';
import '../statistics/statistics_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (BuildContext context) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _buildPageViewItems(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (id) {
          _pageController.jumpToPage(id);
          widget.controller.onPageSelected(id);
          setState(() {});
        },
        showUnselectedLabels: true,
        currentIndex: widget.controller.pageSelected,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.deepPurple.shade600,
        items: _buildBottomItems(),
      ),
    );
  }

  List<Widget> _buildPageViewItems() {
    return [
      MapWidget(
        controller: MapController(),
      ),
      StatisticsPage(
        controller: StatisticsController(),
      ),
      const NewsPage(),
      const ProfilePage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomItems() {
    return [
      _buildMapItem(),
      _buildStatisticsItem(),
      _buildNewsItem(),
      _buildProfileItem(),
    ];
  }

  BottomNavigationBarItem _buildProfileItem() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.person_outline_rounded,
        size: 22,
        color: widget.controller.isProfileSelected
            ? Colors.black
            : Colors.deepPurple.shade600,
      ),
      label: 'Perfil',
    );
  }

  BottomNavigationBarItem _buildNewsItem() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.info_outline_rounded,
        size: 22,
        color: widget.controller.isNewsSelected
            ? Colors.black
            : Colors.deepPurple.shade600,
      ),
      label: 'Informações',
    );
  }

  BottomNavigationBarItem _buildMapItem() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.map_outlined,
        size: 22,
        color: widget.controller.isMapSelected
            ? Colors.black
            : Colors.deepPurple.shade600,
      ),
      label: 'Mapa Covid',
    );
  }

  BottomNavigationBarItem _buildStatisticsItem() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.analytics_outlined,
        size: 22,
        color: widget.controller.isStatisticsSelected
            ? Colors.black
            : Colors.deepPurple.shade600,
      ),
      label: 'Estatísticas',
    );
  }
}
