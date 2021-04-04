import 'dart:io';
import 'menu.object.dart';

void main() {
  //null safety concepts

  var mapMenu = Map<int, dynamic>();

  mapMenu[1] = MenuObject('1. Null safety test.', firstPart);
  mapMenu[2] = MenuObject('2. Null assetion operator.', secondPart);
  mapMenu[3] = MenuObject('3. Type promotion. Definite assignment.', thirdPart);
  mapMenu[4] = MenuObject('4. Promotion with exceptions.', fourthPart);
  mapMenu[5] = MenuObject('5. Late.', fifthPart);
  mapMenu[6] = MenuObject('6. Late with exception.', sixthPart);
  mapMenu[7] = MenuObject('7. Late circular references.', seventhPart);
  mapMenu[8] = MenuObject('8. Late for lazy initialize.', eighthPart);

  stdout.writeln('Which part do you wanna execute?');

  for (var menuObject in mapMenu.values) {
    stdout.writeln(menuObject.description);
  }
  int? option = null;
  do {
    option = int.parse(stdin.readLineSync() ?? '0');
  } while (validateInputOption(mapMenu, option));

  mapMenu[option].functionReference();
}

bool validateInputOption(Map<int, dynamic> mapMenu, int menuOption) {
  bool isMenuOption = mapMenu.keys.contains(menuOption);

  if (!isMenuOption) {
    stdout.writeln('Option doesn\'t exists :(');
    stdout.writeln('Try again!');
  }
  return !isMenuOption;
}

void firstPart() {
  //'a' cannot be null so we need to indicate that variable is possibly null or initialize it
  int? a;
  a = null;
  print('a is $a.');
}

//Uses of null assertion operator ! to indicate that variable or a value won't be null
//If you're wrong, like Dart documentation mentioned, Dart throws  an exception at run-time
void secondPart() {
  int? couldReturnNullButDoesnt() => -3;
  int? couldBeNullButIsnt = 1;
  List<int?> listThatCouldHoldNulls = [2, null, 4];

  int a = couldBeNullButIsnt;
  int b = listThatCouldHoldNulls.first!; // first item in the list
  int c = couldReturnNullButDoesnt()!.abs(); // absolute value

  print('a is $a.');
  print('b is $b.');
  print('c is $c.');
}

//Type promotion -> consider that nullable variables that can't possibly contain null  values  are treated like
//non-nullable variables
void thirdPart() {
  String text;

  if (DateTime.now().hour < 12) {
    text = "It's morning! Let's make aloo paratha!";
  } else {
    text = "It's afternoon! Let's make biryani!";
  }

  print(text);
  print(text.length);
}

void fourthPart() {
  int getLength(String? str) {
    // Try throwing an exception here if `str` is null.
    if (str == null) {
      throw Exception('Parameter must not be null.');
    }
    return str.length;
  }

  print(getLength(null));
}

class Meal {
  late String description;

  void setDescription(String str) {
    description = str;
  }
}

//indicate that variable is 'late' when we gonna assign it a value later
void fifthPart() {
  final myMeal = Meal();
  myMeal.setDescription('Feijoada!');
  print(myMeal.description);
}

//if no value is assign, an error is thrown
void sixthPart() {
  final myMeal = Meal();
  //myMeal.setDescription('Feijoada!');
  print(myMeal.description);
}

class Team {
  late final Coach coach;
}

class Coach {
  late final Team team;
}

//late is great for circular references
void seventhPart() {
  final myTeam = Team();
  final myCoach = Coach();
  myTeam.coach = myCoach;
  myCoach.team = myTeam;

  print('All done!');
}

int _computeValue() {
  print('In _computeValue... Processed just when the variable is read.');
  return 3;
}

class CachedValueProvider {
  int get value => _cache;
  late final _cache = _computeValue();
}

//great for lazy initializations
void eighthPart() {
  print('Calling constructor...');
  var provider = CachedValueProvider();
  print('Getting value...');
  print('The value is ${provider.value}!');
}
