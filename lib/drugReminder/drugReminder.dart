import 'package:flutter/material.dart';
import 'package:graduation_project/ToDo/add_task_screen.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/ToDo/tasks_List.dart';
import 'package:graduation_project/drugReminder/addDrug.dart';
import 'package:graduation_project/drugReminder/drug_prov.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrugMainCareDoctor extends StatelessWidget {
  final String patUid;
  const DrugMainCareDoctor({Key? key, required this.patUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _drugProv = Provider.of<DrugProv>(context, listen: true);
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.purpleAccent
      ),
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: Text(AppLocalizations.of(context)!.patientDrugs
            ,style: TextStyle(fontSize: 29,),),

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => addDrug(
                          patId: patUid,
                        )));
          },
          backgroundColor: Colors.purpleAccent,
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [

                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("images/pill1.jpg"),
                  ),
                  SizedBox(width: 16),
                  Text(
                    AppLocalizations.of(context)!.drugReminder,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _drugProv.drugsList.length,
                      itemBuilder: (context, index) {
                        /*TimeOfDay time =
                            _drugProv.drugsList[index]['time'] as TimeOfDay;*/
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            leading:
                                Image.asset(_drugProv.drugsList[index]['type'],width: 50),
                            title: Text(_drugProv.drugsList[index]['name'],style:TextStyle(fontSize: 33,fontWeight: FontWeight.bold)),
                            subtitle: Text(_drugProv.drugsList[index]
                                    ['duration'] +
                                '\nAt: ' +
                                _drugProv.drugsList[index]['time'],style:TextStyle(fontSize: 38,color: Colors.deepPurple,fontWeight: FontWeight.w500)),
                            trailing: SizedBox(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      try {
                                        showLoading(context);
                                        _drugProv.deleteDrug(index, patUid);
                                        hideLoading(context);
                                      } catch (e) {
                                        hideLoading(context);
                                        errorDialog(
                                          context,
                                          AppLocalizations.of(context)!
                                              .errorOccuredTryLater,
                                        );
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => addDrug(
                                                  patId: patUid,
                                                  index: index,
                                                  name: _drugProv
                                                      .drugsList[index]['name'],
                                                  time: _drugProv
                                                      .drugsList[index]['time'],
                                                  duration:
                                                      _drugProv.drugsList[index]
                                                          ['duration'],
                                                  type: _drugProv
                                                      .drugsList[index]['type'],
                                                ))),
                                    child: const Icon(Icons.edit),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
