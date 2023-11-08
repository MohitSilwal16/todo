import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/dialoguebox.dart';
import 'package:todo/shawtydata.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  bool flag = true;
  final shawtyList = ShawtyData.genShawty();
  final longList = ShawtyData.genDekai();
  final TextEditingController _controller = TextEditingController();
  String title = "Short Term";
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(title),
      ),
      body: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttons(width, height),
            const SizedBox(
              height: 20,
            ),
            parentToDoList(width, height)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 33, 117, 243),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogueBox(
                controller: _controller,
                onSave: addTask,
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Expanded parentToDoList(double width, double height) {
    return Expanded(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          } else {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
        },
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              if (value == 0) {
                flag = true;
                title = "Short Term";
              } else {
                flag = false;
                title = "Long Term";
              }
            });
          },
          controller: _pageController,
          itemCount: 2,
          itemBuilder: (context, index) {
            return index == 0
                ? todoList(width, height, shawtyList, "shortterm")
                : todoList(width, height, longList, "longterm");
          },
        ),
      ),
    );
  }

  ListView todoList(
      double width, double height, List<ShawtyData> list, String boxName) {
    return ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal),
      itemBuilder: (context, index) =>
          todoCard(width, height, index, list, boxName),
    );
  }

  GestureDetector todoCard(double width, double height, int index,
      List<ShawtyData> list, String boxName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          list[index].completed = !list[index].completed;
        });
        ShawtyData.update(boxName, list[index]);
      },
      onDoubleTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Drag Left to Delete Task'),
            duration: Duration(seconds: 2),
            dismissDirection: DismissDirection.down,
          ),
        );
      },
      child: Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => deleteTask(index, list),
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(10, 20)),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 51, 48, 48),
                borderRadius: BorderRadius.all(Radius.elliptical(10, 20)),
              ),
              width: width * .94,
              height: height * .08,
              child: Row(
                children: [
                  Checkbox(
                      value: list[index].completed,
                      activeColor: const Color.fromARGB(255, 37, 33, 243),
                      onChanged: (newBool) {
                        setState(() {
                          list[index].completed = !list[index].completed;
                        });
                        ShawtyData.update(boxName, list[index]);
                      }),
                  SizedBox(
                    width: width * .37,
                    child: Text(
                      list[index].name,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  SizedBox buttons(double width, double height) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          const SizedBox(
            width: 4,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize:
                  Size((width / 2) - 20, height * 0.06), // Set fixed size here
              backgroundColor: const Color.fromARGB(255, 33, 117, 243),
            ),
            onPressed: () {
              setState(() {
                flag = true;
                title = "Short Term";
                int index = 0;
                if (!flag) {
                  index = 1;
                }
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              });
            },
            child: const Text('Short Term'),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize:
                  Size((width / 2) - 20, height * 0.06), // Set fixed size here
              backgroundColor: const Color.fromARGB(255, 33, 117, 243),
            ),
            onPressed: () {
              setState(() {
                flag = false;
                title = "Long Term";
                int index = 0;
                if (!flag) {
                  index = 1;
                }
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              });
            },
            child: const Text('Long Term'),
          ),
        ],
      ),
    );
  }

  addTask() {
    if (_controller.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Task shouldn\'t be empty',
          ),
          dismissDirection: DismissDirection.endToStart,
        ),
      );
    }
    String boxName;
    List<ShawtyData> list;
    if (flag) {
      boxName = "shortterm";
      list = shawtyList;
    } else {
      boxName = "longterm";
      list = longList;
    }
    setState(() {
      list.add(ShawtyData(completed: false, name: _controller.text));
    });
    ShawtyData.update(
        boxName, ShawtyData(name: _controller.text, completed: false));
    _controller.clear();
    Navigator.of(context).pop();
  }

  deleteTask(int index, List<ShawtyData> list) {
    String boxName;
    if (flag) {
      boxName = "shortterm";
    } else {
      boxName = "longterm";
    }
    ShawtyData.del(boxName, list[index].name);
    setState(() {
      list.removeAt(index);
    });
  }
}
