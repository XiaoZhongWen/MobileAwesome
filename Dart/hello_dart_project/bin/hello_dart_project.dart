/*
 * @Author: your name
 * @Date: 2021-09-08 22:20:14
 * @LastEditTime: 2021-09-11 10:12:13
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /hello_dart_project/bin/hello_dart_project.dart
 */
import 'package:characters/characters.dart';

void main(List<String> arguments) {
  Person p1 = Person("xiaozhongwen", 34);
  // Person p2 = Person("xiaozhongwen", 34);
  // Person p3 = Person("xiaozhongwen", 34);

  // print(p1 == p2);
  // print(p2 == p3);
  // print(p3 == p1);

  print(UIApplication() == UIApplication.instance);

  String? name;
  name = "julien";
  print(name.length);

  User u = User();
  print(u.name);
}

class Person {
  const Person(this.name, this.age);

  final String name;
  final int age;

  // const Person.anonymous() : this();
}

class UIApplication {
  UIApplication._();
  static final UIApplication instance = UIApplication._();
  factory UIApplication() => instance;
}

class User {
  late String name;
}
