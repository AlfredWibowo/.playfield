import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_ambw/class/SportCentre.dart';
import 'package:project_ambw/class/SportField.dart';
import 'package:project_ambw/functions/functions.dart';
import 'package:project_ambw/functions/widget.dart';
import 'package:project_ambw/pages/admin/deletePage.dart';
import 'package:project_ambw/services/dbFirestore.dart';

class ManageSportFieldPage extends StatefulWidget {
  final SportCentre dataSC;
  final SportField dataSF;
  const ManageSportFieldPage(
      {Key? key, required this.dataSF, required this.dataSC})
      : super(key: key);

  @override
  State<ManageSportFieldPage> createState() => _ManageSportFieldPageState();
}

class _ManageSportFieldPageState extends State<ManageSportFieldPage> {
  final List<String> _sportFieldType = ["Badminton", "Futsal", "Basketball"];

  late String _dropdownSFType;

  late int _dropdownStartTime;
  late int _dropdownEndTime;
  late List<int> _listTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _dropdownSFType = widget.dataSF.fieldType;
      _listTime = [for (var i = 0; i <= 23; i += 1) i];
      _dropdownStartTime = _listTime.first;
      _dropdownEndTime = _listTime.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  appBarIconBtn(
                      context,
                      Icons.delete,
                      deleteSFPage(
                        dataSC: widget.dataSC,
                        deleteSF: widget.dataSF,
                      )),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title('Manage Sport Field', false),
                      title(widget.dataSF.name, true),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32),
              scCardEditable('Name', widget.dataSF.name, context),
              const SizedBox(height: 8),
              scCard('ID', widget.dataSF.id, context),
              const SizedBox(height: 8),
              sfCardEditableType('Type', widget.dataSF.fieldType, context),
              const SizedBox(height: 8),
              sfCardEditableOpTime(
                  'Operational Time', widget.dataSF.opTime, context),
              const SizedBox(height: 8),
              scCardEditable('Price', widget.dataSF.price.toString(), context),
              const SizedBox(height: 16),
            ]),
          ),
        )));
  }

  Card scCard(String title, String value, BuildContext context) {
    TextEditingController _tfController = TextEditingController();

    return Card(
      // color: Colors.black,
      shape: Border.all(width: 2.0, color: Colors.black),
      borderOnForeground: true,
      child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          subtitle: Text(
            value,
            style: const TextStyle(
                color: Color.fromRGBO(50, 50, 50, 100), fontSize: 16),
          ),
          trailing: Container(width: 0, height: 0)),
    );
  }

  Card scCardEditable(String title, String value, BuildContext context) {
    TextEditingController _tfController = TextEditingController();

    return Card(
      // color: Colors.black,
      shape: Border.all(width: 2.0, color: Colors.black),
      borderOnForeground: true,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
              color: Color.fromRGBO(50, 50, 50, 100), fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: () {
            BuildContext dialogContext;
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                dialogContext = context;
                return AlertDialog(
                  insetPadding: const EdgeInsets.all(24.0),
                  title: Text(
                    ('Edit ' + title).toUpperCase(),
                    style: const TextStyle(fontFamily: 'Comfortaa'),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            const SizedBox(height: 16.0),
                            ListTile(
                              subtitle: TextField(
                                controller: _tfController,
                                decoration: InputDecoration(
                                    labelText: title,
                                    focusedBorder: outlineInputBorder(),
                                    enabledBorder: outlineInputBorder()),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(4), // <-- Radius
                                ),
                                elevation: 0.0,
                                primary: Colors.black,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                if (title == "Name") {
                                  widget.dataSF.name = _tfController.text;
                                } else if (title == "Type") {
                                  widget.dataSF.fieldType = _tfController.text;
                                } else if (title == "Operational Time") {
                                  widget.dataSF.opTime = _tfController.text;
                                } else if (title == "Price") {
                                  widget.dataSF.price =
                                      double.parse(_tfController.text);
                                }
                                await SportFieldFirestoreDatabase.editData(
                                    sf: widget.dataSF);
                                buildSnackBar(
                                    context, title + ' berhasil di edit');
                                Navigator.pop(dialogContext);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(
                                    fontFamily: 'Roboto', color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    )
                  ],
                );
              },
            ).then((_) => setState(() {}));
          },
          icon: const Icon(Icons.edit),
          color: Colors.grey,
        ),
      ),
    );
  }

  Card sfCardEditableOpTime(String title, String value, BuildContext context) {
    return Card(
      // color: Colors.black,
      shape: Border.all(width: 2.0, color: Colors.black),
      borderOnForeground: true,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
              color: Color.fromRGBO(50, 50, 50, 100), fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: () {
            BuildContext dialogContext;
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                dialogContext = context;
                return AlertDialog(
                  insetPadding: const EdgeInsets.all(24.0),
                  title: Text(
                    ('Edit ' + title).toUpperCase(),
                    style: const TextStyle(fontFamily: 'Comfortaa'),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
                  actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  content: StatefulBuilder(
                      builder: (BuildContext context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 14.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          isDense: true,
                                          style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16),
                                          isExpanded: true,
                                          value: _dropdownStartTime,
                                          items: _listTime.map((int value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                value.toString(),
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto'),
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
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.remove),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 14.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isDense: true,
                                        style: const TextStyle(
                                            fontFamily: 'Roboto', fontSize: 16),
                                        isExpanded: true,
                                        value: _dropdownEndTime,
                                        items: _listTime.map((int value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value.toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Roboto'),
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
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    );
                  }),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(4), // <-- Radius
                                ),
                                elevation: 0.0,
                                primary: Colors.black,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                String opTime =
                                    "${_dropdownStartTime}:00-${_dropdownEndTime}:00";
                                widget.dataSF.opTime = opTime;
                                await SportFieldFirestoreDatabase.editData(
                                    sf: widget.dataSF);
                                buildSnackBar(
                                    context, title + ' berhasil di edit');
                                Navigator.pop(dialogContext);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(
                                    fontFamily: 'Roboto', color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    )
                  ],
                );
              },
            ).then((_) => setState(() {}));
          },
          icon: const Icon(Icons.edit),
          color: Colors.grey,
        ),
      ),
    );
  }

  Card sfCardEditableType(String title, String value, BuildContext context) {
    return Card(
      // color: Colors.black,
      shape: Border.all(width: 2.0, color: Colors.black),
      borderOnForeground: true,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
              color: Color.fromRGBO(50, 50, 50, 100), fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: () {
            BuildContext dialogContext;
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                dialogContext = context;
                return AlertDialog(
                  insetPadding: const EdgeInsets.all(24.0),
                  title: Text(
                    ('Edit ' + title).toUpperCase(),
                    style: const TextStyle(fontFamily: 'Comfortaa'),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  content: StatefulBuilder(
                      builder: (BuildContext context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 16.0),
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
                                      style:
                                          const TextStyle(fontFamily: 'Roboto', fontSize: 16),
                                      isExpanded: true,
                                      value: _dropdownSFType,
                                      items: _sportFieldType.map((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(fontFamily: 'Roboto'),
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
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(4), // <-- Radius
                                ),
                                elevation: 0.0,
                                primary: Colors.black,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                String fieldType = _dropdownSFType;
                                widget.dataSF.fieldType = fieldType;
                                await SportFieldFirestoreDatabase.editData(
                                    sf: widget.dataSF);
                                buildSnackBar(
                                    context, title + ' berhasil di edit');
                                Navigator.pop(dialogContext);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(
                                    fontFamily: 'Roboto', color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    )
                  ],
                );
              },
            ).then((_) => setState(() {}));
          },
          icon: const Icon(Icons.edit),
          color: Colors.grey,
        ),
      ),
    );
  }
}
