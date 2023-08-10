import 'package:aiia/Member.dart';
import 'package:aiia/pages/page_calendar.dart';
import 'package:aiia/pages/page_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class NaviScr extends StatefulWidget {
  @override
  State<NaviScr> createState() => _NaviScrState();
}

class _NaviScrState extends State<NaviScr> {
  TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  int _curPage = 0;
  final _kPages = <String, Widget>{
    'message': ChatScreen(),
    'calendar': Calendar(),
    'Member': Member(),
  };

  void _onTapPageChange(int index) {
    setState(() {
      _curPage = index;
    });
  }

  // 고치고 싶은거 잇음 ??// elevation : 0 넣자
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 여기 3으로 바꾸고
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [for (final page in _kPages.values) page],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.blue[100],
          items: <TabItem>[
            TabItem(icon: Icons.message, title: "Chat"),
            TabItem(icon: Icons.calendar_month, title: "Calendar"),
            TabItem(icon: Icons.people, title: "Members"),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: _widgetPages[_curPage],
    //   bottomNavigationBar: Container(
    //     decoration: BoxDecoration(
    //         color: Colors.white,
    //         border: Border(
    //           top: BorderSide(color: Color(0xff353535), width: 0.3),
    //         )),
    //     child: BottomNavigationBar(
    //       currentIndex: _curPage,
    //       onTap: _onTapPageChange,
    //       elevation: 1,
    //       items: <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.chat),
    //           label: "Chat",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.padding),
    //           label: "calendar",
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buildStyleSelector() {
    final dropdown = DropdownButton<TabStyle>(
      value: _tabStyle,
      onChanged: (newStyle) {
        if (newStyle != null) setState(() => _tabStyle = newStyle);
      },
      items: [
        for (final style in TabStyle.values)
          DropdownMenuItem(
            value: style,
            child: Text(style.toString()),
          )
      ],
    );
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: const Text('appbar style:'),
      trailing: dropdown,
    );
  }
}
