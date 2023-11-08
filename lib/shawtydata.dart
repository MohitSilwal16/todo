import 'package:hive/hive.dart';

part 'shawtydata.g.dart'; // Generate HiveAdapter

@HiveType(typeId: 0)
class ShawtyData {
  ShawtyData({
    required this.name,
    required this.completed,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  bool completed;

  static void dateStamp() {
    DateTime currentDate = DateTime.now();
    DateTime currentDateOnly =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    var box = Hive.box('date');
    String? dt = box.get('lastdate');
    if (dt != null) {
      DateTime storedDate = DateTime.parse(dt);
      if (storedDate.isBefore(currentDateOnly)) {
        var shortBox = Hive.box('shortterm');
        box.put('lastdate', currentDateOnly.toIso8601String());

        for (String temp in shortBox.keys) {
          shortBox.put(temp, false);
        }
      }
    } else {
      box.put('lastdate', currentDateOnly.toIso8601String());
    }
  }

  static List<ShawtyData> genShawty() {
    var box = Hive.box('shortterm');
    List<ShawtyData> shawtyList = [];

    for (String temp in box.keys) {
      shawtyList.add(
        ShawtyData(
          name: temp,
          completed: box.get(temp) as bool? ?? false,
        ),
      );
    }
    return shawtyList;
  }

  static List<ShawtyData> genDekai() {
    var box = Hive.box('longterm');
    List<ShawtyData> shawtyList = [];

    for (String temp in box.keys) {
      shawtyList.add(
          ShawtyData(name: temp, completed: box.get(temp) as bool? ?? false));
    }
    return shawtyList;
  }

  static update(String boxName, ShawtyData obj) {
    var box = Hive.box(boxName);
    box.put(obj.name, obj.completed);
  }

  static del(String boxName, String name) {
    var box = Hive.box(boxName);
    box.delete(name);
  }
}
