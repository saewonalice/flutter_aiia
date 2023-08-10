import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:aiia/event.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import "dart:developer";

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final FireStore = FirebaseFirestore.instance;
  late Map<String, List<String>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late Future dataload;

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    dataload = getDatabase();
  }

  List<String> _getEventsfromDay(DateTime date) {
    return selectedEvents[date.toString()] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  Future<Map<String, List<String>>> getDatabase() async {
    QuerySnapshot qs = await FireStore.collection("calendar").get();
    qs.docs.forEach((doc) {
      String temp = doc.id.toString();
      List<String> tempstr = [];
      for (int i = 0; i < doc["ID"].length; i++) {
        tempstr.add(doc["ID"][i]);
      }
      selectedEvents[temp] = tempstr;
    });
    return selectedEvents;
  }

  void setDatabase() async {
    Iterable<String> dates = [];
    dates = selectedEvents.keys;
    for (String cur in dates) {
      FireStore.collection("calendar")
          .doc(cur)
          .set(<String, List<String>>{"ID": selectedEvents["$cur"]!});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("AIIA CALENDAR"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: dataload,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ));
          } else if (snapshot.hasError)
            return Text("불러오기 에러");
          else if (snapshot.hasData) {
            selectedEvents = snapshot.data;
            return Column(
              children: [
                TableCalendar(
                  focusedDay: selectedDay,
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,

                  //Day Changed
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focusDay;
                    });
                    print(focusedDay);
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },

                  eventLoader: _getEventsfromDay,

                  //To style the Calendar
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue[900],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purpleAccent,
                          Colors.blue,
                        ],
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.indigo,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Text(
                                "EVENT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ..._getEventsfromDay(selectedDay).map(
                              (String event) => Dismissible(
                                key: UniqueKey(),
                                background: Container(color: Colors.red),
                                secondaryBackground:
                                    Container(color: Colors.red),
                                // 지울 때 나오는 뒷 배경
                                onDismissed: (direction) {
                                  selectedEvents[selectedDay.toString()]
                                      ?.remove(event);
                                  setDatabase();
                                  setState(() {
                                    dataload = getDatabase();
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.check_box_rounded,
                                          color: Colors.greenAccent,
                                          size: 30,
                                        ),
                                        title: Text(
                                          event,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Text("");
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add Event"),
              content: TextFormField(
                controller: _eventController,
              ),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text("Add"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) {
                    } else {
                      if (selectedEvents[selectedDay.toString()] != null) {
                        selectedEvents[selectedDay.toString()]
                            ?.add(_eventController.text.toString());
                      } else {
                        selectedEvents[selectedDay.toString()] = [
                          _eventController.text.toString()
                        ];
                      }
                    }
                    Navigator.pop(context);
                    _eventController.clear();
                    print(selectedEvents);
                    setDatabase();
                    setState(() {});
                    return;
                  },
                ),
              ],
            ),
          ),
          label: Text("Add Event"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
