import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tasq/models/todo.dart';
import 'package:tasq/providers/admin_provider.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class AddTaskScreen extends StatefulWidget {
  static String id = 'AddTaskScreen';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final taskController = TextEditingController();

  String currTask = '';
  bool remindMe = false;
  DateTime reminderDate;
  TimeOfDay reminderTime;
  int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
        builder: (context, p, _) => Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Add Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextField(
                        controller: taskController,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (newVal) {
                          currTask = newVal;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SwitchListTile(
                        value: remindMe,
                        title: Text('Reminder'),
                        onChanged: (newValue) async {
                          if (newValue) {
                            reminderDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 2),
                            );

                            if (reminderDate == null) {
                              return;
                            }

                            reminderTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            if (reminderDate != null && reminderTime != null) {
                              remindMe = newValue;
                            }
                          } else {
                            reminderDate = null;
                            reminderTime = null;
                            remindMe = newValue;
                          }

                          print(reminderTime);
                          print(reminderDate);

                          setState(() {});
                        },
                        subtitle: Text('Remind me about this item'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          child: remindMe
                              ? Text('Reminder set at: ' +
                                  DateTime(
                                          reminderDate.year,
                                          reminderDate.month,
                                          reminderDate.day,
                                          reminderTime.hour,
                                          reminderTime.minute)
                                      .toString())
                              : null),
                      SizedBox(
                        height: remindMe ? 10.0 : 0.0,
                      ),
                      p.isLoading
                          ? ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 40),
                              child: CircularProgressIndicator(),
                            )
                          : FlatButton(
                              color: Colors.lightBlueAccent,
                              onPressed: () async {
                                if (reminderDate == null) {
                                  return Get.snackbar(
                                      "Uh oh!", "Please select reminder date",
                                      backgroundColor: Colors.white);
                                }
                                if (taskController.text.isEmpty) {
                                  return Get.snackbar(
                                      "Uh oh!", "Please enter todo name",
                                      backgroundColor: Colors.white);
                                }
                                if (remindMe) {
                                  var scheduledNotificationDateTime =
                                      reminderDate
                                          .add(Duration(
                                              hours: reminderTime.hour,
                                              minutes: reminderTime.minute))
                                          .subtract(Duration(seconds: 5));
                                  AndroidNotificationDetails
                                      androidPlatformChannelSpecifics =
                                      AndroidNotificationDetails(
                                    currTask,
                                    'To Do Notification',
                                    'Do the task',
                                    priority: Priority.max,
                                    importance: Importance.max,
                                    playSound: true,
                                  );
                                  var iOSPlatformChannelSpecifics =
                                      IOSNotificationDetails();
                                  NotificationDetails platformChannelSpecifics =
                                      NotificationDetails(
                                          android:
                                              androidPlatformChannelSpecifics,
                                          iOS: iOSPlatformChannelSpecifics);
                                  id = Provider.of<AdminProvider>(context,
                                          listen: false)
                                      .adminTodos
                                      .length;
                                  print(id);
                                  await FlutterLocalNotificationsPlugin()
                                      .schedule(
                                    id,
                                    'Task reminder',
                                    'It is time for your task: $currTask',
                                    scheduledNotificationDateTime,
                                    platformChannelSpecifics,
                                    androidAllowWhileIdle: true,
                                  );
                                }
                                Todo todo = Todo(
                                  name: currTask,
                                  isChecked: false,
                                  date: Timestamp.fromDate(reminderDate == null
                                      ? null
                                      : reminderDate.add(Duration(
                                          hours: reminderTime.hour,
                                          minutes: reminderTime.minute,
                                        ))),
                                );

                                p.addTodo(todo: todo);
                              },
                              child: Text(
                                'ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ));
  }
}
