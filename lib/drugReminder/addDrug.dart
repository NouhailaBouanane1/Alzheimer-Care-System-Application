import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import 'drug_prov.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class addDrug extends StatefulWidget {
  final String? name;
  final String? duration;
  final String? time;
  final String? type;
  final int? index;
  final String patId;
  const addDrug(
      {Key? key,
      required this.patId,
      this.index,
      this.name,
      this.duration,
      this.time,
      this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => addDrugState();
}

class addDrugState extends State<addDrug> {
  TextEditingController _medecine = TextEditingController();
  TextEditingController _durationCont = TextEditingController();

  TimeOfDay? newTime;
  DateTime datetime = DateTime.now();
  int indexType = 0;

  final List imagesUrl = [
    'images/drugs/drops.png',
    'images/drugs/pill.jpg',
    'images/drugs/syrup.jpg',
    'images/drugs/creme.jpg'
  ];
  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _medecine.text = widget.name ?? '';
      _durationCont.text = widget.duration ?? '';
      newTime = stringToTimeOfDay(widget.time!);
      indexType = imagesUrl.indexOf(widget.type, 0);
    }
  }

  @override
  void dispose() {
    _medecine.dispose();
    _durationCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List types = [
      'drops',
      'capsules',
      'liquid',
      'ointment',
    ];
    var _drug_prov = Provider.of<DrugProv>(context, listen: false);
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back)),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.newReminder,
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quintessential',
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    'images/drug_Reminder.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    AppLocalizations.of(context)!.medicineName,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _medecine,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!.panadol,hintStyle: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.type,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => setState(() {
                          indexType = 0;
                        }),
                        child: Container(
                          width: 100,
                          height: 20,
                          color: indexType == 0
                              ? Colors.blue[100]
                              : Colors.transparent,
                          child: Card(
                            child: Image.asset(
                              'images/drugs/drops.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          indexType = 1;
                        }),
                        child: Container(
                          width: 100,
                          height: 20,
                          color: indexType == 1
                              ? Colors.blue[100]
                              : Colors.transparent,
                          child: Card(
                            child: Image.asset(
                              'images/drugs/pill.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          indexType = 2;
                        }),
                        child: Container(
                          width: 100,
                          height: 20,
                          color: indexType == 2
                              ? Colors.blue[100]
                              : Colors.transparent,
                          child: Card(
                            child: Image.asset(
                              'images/drugs/syrup.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          indexType = 3;
                        }),
                        child: Container(
                          width: 100,
                          height: 20,
                          color: indexType == 3
                              ? Colors.blue[100]
                              : Colors.transparent,
                          child: Card(
                            child: Image.asset(
                              'images/drugs/creme.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 3),
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.scheduleTime,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: newTime != null
                        ? Text(
                            '${newTime?.hourOfPeriod ?? ''}:${newTime?.minute ?? ''}${newTime?.period.toString().split('.')[1] ?? ''}')
                        : const SizedBox(),
                    trailing: InkWell(
                        child: Icon(Icons.alarm),
                        onTap: () async {
                          var temp = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: datetime.hour, minute: datetime.minute),
                          );

                          setState(() {
                            newTime = temp;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 8),
                      child: Text(
                        AppLocalizations.of(context)!.duration,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: _durationCont,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.useItFor3Month,hintStyle: TextStyle(fontSize: 24),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (widget.index == null) {
                        try {
                          showLoading(context);
                          await _drug_prov.addDrug(
                              patUid: widget.patId,
                              name: _medecine.text,
                              duration: _durationCont.text,
                              type: types[indexType],
                              date:
                                  '${newTime?.hourOfPeriod}:${newTime?.minute} ${(newTime?.period.toString().split('.')[1])!.toUpperCase()}',
                              scheduledTime: Timestamp.fromDate(DateTime(
                                  datetime.year,
                                  datetime.month,
                                  datetime.day,
                                  newTime!.hour,
                                  newTime!.minute)));
                          hideLoading(context);
                        } catch (e) {
                          hideLoading(context);
                          errorDialog(
                              context,
                              AppLocalizations.of(context)!
                                  .errorOccuredTryLater);
                        }

                        Navigator.pop(context);
                      } else {
                        try {
                          showLoading(context);
                          _drug_prov.editDrug(widget.index!, widget.patId,
                              date:
                                  '${newTime?.hourOfPeriod}:${newTime?.minute} ${newTime?.period.toString().split('.')[1]}',
                              duration: _durationCont.text,
                              name: _medecine.text,
                              type: types[indexType]);
                          hideLoading(context);
                          Navigator.pop(context);
                        } catch (e) {
                          hideLoading(context);
                          errorDialog(
                              context,
                              AppLocalizations.of(context)!
                                  .errorOccuredTryLater);
                        }
                      }
                    },
                    child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(colors: [
                          Color(0xffCE93D8),
                          Color(0xffF8BBD0),
                          Color(0xff7B1FA2)
                        ]),
                      ),
                      padding: EdgeInsets.only(
                          top: 10, left: 3, right: 2, bottom: 14),
                      child: Text(
                        AppLocalizations.of(context)!.setReminder,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
