// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, unused_field

import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

String imagePath =
    "data:image/jpeg;base64,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";

class _TicketPageState extends State<TicketPage> {
  // int _currentindexTab = 0;

  // final List<Tab> _ticketTab = [
  //   Tab(
  //     text: 'Pending',
  //   ),
  //   Tab(text: 'Active'),
  //   Tab(
  //     text: 'History',
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            title('Manage your', false),
            title('Reservation', true),
            SizedBox(
              height: 30,
            ),
            ticketCard(
                'GOR Sudirman', '087853946662', 'Jl. Kertajaya Surabaya', 'Badminton',0),
            SizedBox(
              height: 10,
            ),
            ticketCard(
                'GOR Sudirman', '087853946662', 'Jl. Kertajaya Surabaya', 'Basket',1),
            SizedBox(
              height: 10,
            ),
            ticketCard(
                'GOR Sudirman', '087853946662', 'Jl. Kertajaya Surabaya', 'Futsal',2),
          ],
        ),
      ),
    );

    // @override
    // Widget build(BuildContext context) {
    //   return DefaultTabController(
    //       length: _ticketTab.length,
    //       child: Builder(builder: (BuildContext context) {
    //         TabController _tabController = DefaultTabController.of(context)!;

    //         _tabController.addListener(() {
    //           if (!_tabController.indexIsChanging) {
    //             setState(() {
    //               _currentindexTab = _tabController.index.toInt();
    //             });
    //           }
    //         });

    //         return Scaffold(
    //           body: Container(
    //             padding: EdgeInsets.all(0),
    //             child: Column(
    //               children: [
    //                 TabBar(
    //                   tabs: _ticketTab,
    //                   labelColor: Colors.blue,
    //                 ),
    //                 SizedBox(
    //                   height: 30,
    //                 ),
    //                 Expanded(
    //                   child: ListView(
    //                     children: [
    //                       ListTile(
    //                         onTap: () {},
    //                         leading: ClipRRect(
    //                           borderRadius: BorderRadius.circular(5),
    //                           child: Image.network(
    //                             imagePath,
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                         title: Text(
    //                           'GOR Bulutangkis Soedirman',
    //                         ),
    //                         subtitle: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               '0857-3317-0825',
    //                             ),
    //                             Text(
    //                               'Jl. Dr. Ir. H. Soekarno No.8, Manyar Sabrangan, Kec. Mulyorejo, Kota SBY, Jawa Timur 60116',
    //                             ),
    //                           ],
    //                         ),
    //                         trailing: Icon(
    //                           Icons.pause_circle,
    //                           color: Colors.amber,
    //                           size: 36,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       }));
  }
}
