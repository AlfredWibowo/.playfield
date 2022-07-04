import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/admin/deletePage.dart';

class ManageSportFieldPage extends StatefulWidget {
  final SportCentre dataSC;
  final SportField dataSF;
  const ManageSportFieldPage({Key? key,  required this.dataSF, required this.dataSC}) : super(key: key);

  @override
  State<ManageSportFieldPage> createState() => _ManageSportFieldPageState();
}

class _ManageSportFieldPageState extends State<ManageSportFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: backButton(context),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                appBarIconBtn(context, Icons.delete,
                    deleteSFPage(dataSC: widget.dataSC, deleteSF: widget.dataSF,)),
              ],
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}