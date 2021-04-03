import 'dart:io';

import 'menu.object.dart';

void main() {
  //null safety concepts

  var mapMenu = Map<int, dynamic>();

  mapMenu[1] = MenuObject('1. Null safety test.', firstPart);
  mapMenu[2] = MenuObject('2. Null assetion operator.', secondPart);
  mapMenu[3] = MenuObject('3. Not implemented.', thirdPart);

  stdout.writeln('Which part do you wanna execute?');

  for (var menuObject in mapMenu.values) {
    stdout.writeln(menuObject.description);
  }
  int? option = null;
  do {
    option = int.parse(stdin.readLineSync() ?? '0');
  } while (validateInputOption(mapMenu, option));

  mapMenu[option].functionReference();
  /*switch (option) {
    case 1:
      firstPart();
      break;
    case 2:
      secondPart();
      break;
    default:
  }*/
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

void thirdPart() {
  print('Not implemented.');
}
