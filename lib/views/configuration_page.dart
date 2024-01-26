import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:language_voice_bot/controller/state_controller.dart';
import 'package:language_voice_bot/utils/constants.dart';
import 'package:language_voice_bot/views/chat_page.dart';
import 'package:language_voice_bot/views/transition_widget.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  List<String> selectedValues = List.filled(4, "");

  final ChatPage chatPage = const ChatPage();
  final _formKey = GlobalKey<FormState>();

  OutlineInputBorder getFieldOutlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    );
  }

  TextStyle getTextStyle() {
    return const TextStyle(fontSize: 14);
  }

  TextFormField getTextFormField(String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        hintStyle: getTextStyle(),
        border: getFieldOutlineBorder(),
      ),
    );
  }

  Widget getDropDownButtonFormField(
      String hintText, List<String> items, int fieldIndex) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: getFieldOutlineBorder(),
      ),
      hint: Text(
        hintText,
        style: getTextStyle(),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: getTextStyle(),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return "Mandatory field";
        }
        return null;
      },
      onChanged: (value) {
        //Do something when selected item is changed.
      },
      onSaved: (value) {
        selectedValues[fieldIndex] = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 16,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        scrollPadding: const EdgeInsets.symmetric(horizontal: 16),
        maxHeight: 200,
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget getSpaceWidget() {
    return const SizedBox(
      height: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Roleplay Lingo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                ),
              ),
              getSpaceWidget(),
              getDropDownButtonFormField(
                  "Language you want to practise?", languages, 0),
              getSpaceWidget(),
              getDropDownButtonFormField(
                  "Language you already know?", languages, 1),
              getSpaceWidget(),
              getDropDownButtonFormField(
                  "Language level you want to practise?", levels, 2),
              getSpaceWidget(),
              getDropDownButtonFormField("Roleplay scenario?", situations, 3),
              getSpaceWidget(),
              const Text(
                rules,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                  var controller = context.read<StateController>();
                  controller.languageToPractise = selectedValues[0];
                  controller.languageUserKnow = selectedValues[1];
                  controller.languageLevel = selectedValues[2];
                  controller.situation = selectedValues[3];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransitionWidget(),
                    ),
                  );
                },
                child: const Text(
                  'Start conversation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
