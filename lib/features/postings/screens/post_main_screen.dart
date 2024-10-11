import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/postings/screens/adoption/adoption_home_tab.dart';
import 'package:pawpal/features/postings/screens/lostpet/lostpet_home_tab.dart';

class PostingsScreen extends StatefulWidget {
  const PostingsScreen({super.key});

  @override
  _PostingsScreenState createState() => _PostingsScreenState();
}

class _PostingsScreenState extends State<PostingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late List<TabData> _tabData;
  late Color _activeColor;

  @override
  void initState() {
    super.initState();
    _tabData = [
      TabData(
          title: 'Adoption',
          color: AppColors.accentYellow,
          content: AdoptionHomeTab()),
      TabData(
          title: 'Lost', 
          color: AppColors.accentRed, 
          content: LostPetHomeTab()),
    ];
    _activeColor = _tabData.first.color;

    _controller = TabController(vsync: this, length: _tabData.length)
      ..addListener(() {
        setState(() {
          _activeColor = _tabData[_controller.index].color;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: _activeColor),
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: _activeColor,
          labelPadding: EdgeInsets.zero,
          controller: _controller,
          tabs: _tabData
              .map((data) => Tab(
                    child: Container(
                      constraints: BoxConstraints.expand(),
                      child: Center(
                        child: Text(
                          data.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall, // Use text style from theme
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        body: TabBarView(
          controller: _controller,
          children: _tabData.map((data) => data.content).toList(),
        ),
      ),
    );
  }
}

class TabData {
  TabData({required this.title, required this.color, required this.content});

  final String title;
  final Color color;
  final Widget content;
}
