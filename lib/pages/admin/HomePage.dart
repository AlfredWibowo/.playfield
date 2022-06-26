import 'package:project_ambw/class/CUserSession.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            title('Hello,', false),
            title(UserSession.session.nama, true),
            SizedBox(
              height: 30,
            ),
            subTitle('Scan QR Code', false, () {}),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.black,
              child: ListTile(
                title: Text(
                  'scan here'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            subTitle('Lastest Appliant', true, () {}),
            SizedBox(height: 10),
            Card(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GOR Sudirman',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textWithIconRow(Icons.calendar_today, '16/6/2022'),
                        textWithIconRow(Icons.timer, '10.00-12.00'),
                        SizedBox(
                          height: 5,
                        ),
                        sportCard('Badminton', sportColor('Badminton')),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.check),
                                  style: ElevatedButton.styleFrom(
                                    //minimumSize: Size.fromHeight(20),
                                    primary: Colors.green,
                                    shape: roundedRectangleBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.close),
                                  style: ElevatedButton.styleFrom(
                                    //minimumSize: Size.fromHeight(20),
                                    primary: Colors.red,
                                    shape: roundedRectangleBorder(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
