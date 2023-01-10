import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'task_form.dart';

class Tasks extends StatefulWidget {
  final List<List<List<String>>> tasksInfo;

  const Tasks({required this.tasksInfo, Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => TasksState();
}

class TasksState extends State<Tasks> {
  static const TextStyle taskInfoStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);
  List<String> cards = ["ToDo", "In Progress", "To Review", "Completed"];
  List<List<List<String>>> _tasksInfos = [];

  @override
  Widget build(BuildContext context) {
    _tasksInfos = widget.tasksInfo;
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff373447), Color(0xff1F1E2B)])),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (context, index) {
            if (index < cards.length) return _buildCard(context, index);
          },
        ));
  }

  Widget buildTaskCard(String projectName, String imageURL) => Card(
      color: const Color.fromARGB(255, 31, 31, 42),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                projectName,
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ));
  Widget _buildAddCardTaskWidget(context, index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 50.0),
      child: InkWell(
        onTap: () {
          _showAddCardTask(context, index);
        },
        child: Row(
          children: const <Widget>[
            Icon(
              Icons.add,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              "Add Task",
              style: TextStyle(
                  color: Color(0xff1F1E2B),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: const [
                //   BoxShadow(
                //       blurRadius: 5,
                //       offset: Offset(0, 0),
                //       color: Color.fromARGB(122, 150, 119, 18),
                //       spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Color.fromARGB(128, 17, 206, 231),
            ),
            margin: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  child: Center(
                    child: Text(
                      cards[index],
                      style: const TextStyle(
                        color: Color(0xff1F1E2B),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: DragAndDropList<List<String>>(
                      _tasksInfos[index],
                      itemBuilder: (BuildContext context, item) {
                        return _buildCardTask(
                            index, _tasksInfos[index].indexOf(item));
                      },
                      onDragFinish: (oldIndex, newIndex) {
                        _handleReOrder(oldIndex, newIndex, index);
                      },
                      // canBeDraggedTo: (one, two) => true,
                      dragElevation: 8.0,
                    ),
                  ),
                ),
                _buildAddCardTaskWidget(context, index),
              ],
            ),
          ),
          Positioned.fill(
            child: DragTarget<Map>(
              onWillAccept: (data) {
                return true;
              },
              onLeave: (data) {},
              onAccept: (data) {
                if (data['from'] == index) {
                  return;
                }
                _tasksInfos[data['from']].remove(data['cardInfoList']);
                _tasksInfos[index].add(data['cardInfoList']);
                setState(() {});
              },
              builder: (context, accept, reject) {
                //print("--- > $accept");
                //print(reject);
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCardTask(int index, int innerIndex) {
    return Container(
      width: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Draggable<Map<String, Object>>(
          feedback: Container(
            width: 300,
            child: Card(
                color: Color.fromARGB(255, 31, 31, 42),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(_tasksInfos[index][innerIndex][0],
                                  style: taskInfoStyle),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                  'Begin Date: ${_tasksInfos[index][innerIndex][1]}',
                                  style: taskInfoStyle),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Deadline: ${_tasksInfos[index][innerIndex][2]}',
                                  style: taskInfoStyle),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(_tasksInfos[index][innerIndex][3],
                                  style: taskInfoStyle),
                            ],
                          )),
                    ],
                  ),
                )),
          ),
          childWhenDragging: Container(),
          data: {"from": index, "cardInfoList": _tasksInfos[index][innerIndex]},
          child: Card(
              color: Color.fromARGB(255, 31, 31, 42),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(_tasksInfos[index][innerIndex][0],
                                style: taskInfoStyle),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                                'Begin Date: ${_tasksInfos[index][innerIndex][1]}',
                                style: taskInfoStyle),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Deadline: ${_tasksInfos[index][innerIndex][2]}',
                                style: taskInfoStyle),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(_tasksInfos[index][innerIndex][3],
                                style: taskInfoStyle),
                          ],
                        )),
                  ],
                ),
              ))),
    );
  }

  _showAddCardTask(BuildContext context, int index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: buildTaskForm(context, index, this),
          );
        });
  }

  void addCard(int index, BuildContext context) {
    Navigator.of(context).pop();
    _addCardTask(index);
    setState(() {});
  }

  _addCardTask(int index) {
    String name = taskNameInput.text;
    String beginDate = beginDateInput.text;
    String deadline = deadlineInput.text;
    String description = descriptionInput.text;
    List<String> cardInfoList = [name, beginDate, deadline, description];
    _tasksInfos[index].add(cardInfoList);
    taskNameInput.text = "";
    beginDateInput.text = "";
    deadlineInput.text = "";
    descriptionInput.text = "";
  }

  _handleReOrder(int oldIndex, int newIndex, int index) {
    var oldValue = _tasksInfos[index][oldIndex];
    _tasksInfos[index][oldIndex] = _tasksInfos[index][newIndex];
    _tasksInfos[index][newIndex] = oldValue;
    setState(() {});
  }
}