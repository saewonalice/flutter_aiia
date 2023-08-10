import 'package:flutter/material.dart';

class MemberInfo {
  MemberInfo({required this.loc, required this.name});
  String loc = ''; //위치
  String name = ''; //이름
}

class Member extends StatefulWidget {
  const Member({Key? key}) : super(key: key);

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  @override
  List<MemberInfo> Members = [
    MemberInfo(
      loc: "CAPTAIN",
      name: "김한백(AI소프트웨어학부(인공지능전공))",
    ),
    MemberInfo(loc: "CO-PILOT", name: "구도연(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CO-PILOT", name: "박주혁(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "FLIGHT-ATTENDANT", name: "민세원(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "FLIGHT-ATTENDANT", name: "황정민(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "OFFICIAL CREW", name: "김지민(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "OFFICIAL CREW", name: "최민석(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "구본욱(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "국희근(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "권민지(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "김아진(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "김이현(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "남승우(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "문희상(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "서현교(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "이윤서(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "이효진(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "정세현(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "조유진(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "진준우(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "최지호(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "추호성(AI소프트웨어학부(인공지능전공))"),
    MemberInfo(loc: "CREW ON PROBATION", name: "황채연(AI소프트웨어학부(인공지능전공))"),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Members",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildListView(Members),
    );
  }
}

ListView _buildListView(List<MemberInfo> memberList) {
  return ListView.builder(
    itemCount: memberList.length,
    itemBuilder: (_, index) {
      return ListTile(
        title: Text(memberList[index].loc),
        subtitle: Text(memberList[index].name),
        leading: Icon(Icons.person),
        trailing: Icon(Icons.call),
      );
    },
  );
}
