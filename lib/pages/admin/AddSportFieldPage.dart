// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:flutter/material.dart';
import 'package:project_ambw/services/dbFirestore.dart';
import 'package:project_ambw/services/storageService.dart';
import 'package:uuid/uuid.dart';

class AddSportFieldPage extends StatefulWidget {
  final SportCentre dataSC;

  const AddSportFieldPage({Key? key, required this.dataSC}) : super(key: key);

  @override
  State<AddSportFieldPage> createState() => _AddSportFieldPageState();
}

class _AddSportFieldPageState extends State<AddSportFieldPage> {
  final TextEditingController _tfName = TextEditingController();
  final TextEditingController _tfPrice = TextEditingController();
  final TextEditingController _tfImage = TextEditingController();

  final List<String> _sportFieldType = ["Badminton", "Futsal", "Basketball"];

  late String _dropdownSFType;

  late int _dropdownStartTime;
  late int _dropdownEndTime;
  late List<int> _listTime;

  late FilePickerResult? resultFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _dropdownSFType = _sportFieldType.first;
      _listTime = [for (var i = 0; i <= 23; i += 1) i];
      _dropdownStartTime = _listTime.first;
      _dropdownEndTime = _listTime.last;
    });
  }

  Future<void> selectFile(BuildContext context) async {
    resultFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (resultFile == null) {
      buildSnackBar(context, "No Image Selected");
    } else {
      final filePath = resultFile!.files.single.path;
      final fileName = resultFile!.files.single.name;
      setState(() {
        _tfImage.text = fileName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: backButton(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              title('Add', false),
              title('New Sport Field', true),
              SizedBox(
                height: 30,
              ),
      
              //Image
              TextField(
                controller: _tfImage,
                decoration: InputDecoration(
                  labelText: 'Image File Name',
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      selectFile(context);
                    },
                    icon: Icon(Icons.file_upload),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
      
              //Name SF
              TextField(
                controller: _tfName,
                decoration: InputDecoration(
                  labelText: 'Name',
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
      
              //Price SF / hour
              TextField(
                controller: _tfPrice,
                decoration: InputDecoration(
                  labelText: 'Rp. ',
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
      
              //Dropdown Field Type
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 14.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isDense: true,
                      focusColor: Colors.transparent,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                      isExpanded: true,
                      value: _dropdownSFType,
                      items: _sportFieldType.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownSFType = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
      
              //dropdown op time
              Row(
                children: [
                  Text('Operational Time'),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 14.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              isDense: true,
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 16),
                              isExpanded: true,
                              value: _dropdownStartTime,
                              items: _listTime.map((int value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                setState(() {
                                  _dropdownStartTime = newValue!;
                                });
                              }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.remove),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 14.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,
                            style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                            isExpanded: true,
                            value: _dropdownEndTime,
                            items: _listTime.map((int value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              setState(() {
                                _dropdownEndTime = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
      
              ElevatedButton(
                onPressed: () async {
                  String id = Uuid().v4();
                  String name = _tfName.text;
                  String opTime =
                      "${_dropdownStartTime}:00-${_dropdownEndTime}:00";
                  String fieldType = _dropdownSFType;
                  int price = int.parse(_tfPrice.text);
                  String fieldPicture = _tfImage.text;
      
                  //add id to Sport Centre
                  SportCentre sc = widget.dataSC;
                  sc.sportFieldId.add(id);
                  SportCentreFirestoreDatabase.editData(sc: sc);
      
                  //add data sf
                  SportField sf = SportField(
                    id: id,
                    name: name,
                    opTime: opTime,
                    fieldType: fieldType,
                    price: price,
                    fieldPicture: fieldPicture,
                  );
                  SportFieldFirestoreDatabase.addData(sf: sf);
      
                  if (_tfImage.text != "") {
                    //add image to storage
                    Future<String> responseMsg = StorageService.uploadImage(
                      // fileName: resultFile!.files.single.name,
                      fileName: "${sc.name}_${sf.fieldType}_${sf.name}",
                      filePath: resultFile!.files.single.path!,
                      isProfilePicture: false,
                    );
                  }
      
                  buildSnackBar(context, "New Sport Field Added to ${sc.name}");
      
                  Navigator.pop(context);
                },
                child: Text(
                  'submit'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  primary: Colors.black,
                  shape: roundedRectangleBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
