import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';

class AdminMaintenancePage extends StatefulWidget {
  const AdminMaintenancePage({Key? key}) : super(key: key);

  @override
  State<AdminMaintenancePage> createState() => _AdminMaintenancePageState();
}

class _AdminMaintenancePageState extends State<AdminMaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            title('Manage your', false),
            title('Sports center', true),
          ],
        ),
      ),
    );
  }
}
