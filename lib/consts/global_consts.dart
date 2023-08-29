import 'package:flutter/material.dart';

List<String> imageList = ['welcome_1.png', 'welcome_2.png', 'welcome_3.png'];

List<String> titleList = [
  'Welcome',
  'The Ideal Smart Home Calculator',
  'Unique Backup Calculator'
];

List<String> titleTextList = [
  'Your one stop app for calculating power and  backup for all your gadgets and appliances!',
  'Now you can easily calculate the total power rating of your gadgets and appliances',
  'Unique app for calculating ideal backup for your inverter!'
];

// TextEditingController textEditingController = TextEditingController();
List<TextEditingController> myControllers =
    List.generate(3, (i) => TextEditingController());

//FocusNode focusNode = FocusNode();

List<FocusNode> focusNodes = List.generate(3, (i) => FocusNode());

List<String> applianceList = [];
List<String> quantityList = [];
List<String> powerList = [];

//final _formKey = GlobalKey<FormState>();
List formKeys = List.generate(3, (i) => GlobalKey<FormState>());
