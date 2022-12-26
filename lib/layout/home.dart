// ignore_for_file: unnecessary_new, camel_case_types, unnecessary_string_interpolations

import 'package:cryptography_app/model/algorithm.dart';
import 'package:cryptography_app/shared/component.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

List<String> items = [
  'Caeser',
  'PlayFair',
  'Vigenere',
  'Rail Fence',
  'RowColumn',
  'Autokey',
];
Logic? logic = new Logic();
String result = '___';

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController textController = TextEditingController();
  TextEditingController keyController = TextEditingController();

  int? v;
  var formKey = GlobalKey<FormState>();
  bool selcet = true;
  String? dropdownButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: const Border(
                          bottom: BorderSide(color: Colors.grey),
                          top: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                          left: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: result == "Invalid key"
                                  ? const Text('___')
                                  : Text(
                                      '$result',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0),
                                    ),
                            ),
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonFormField2(
                      value: dropdownButton,
                      isExpanded: true,
                      hint: const Text(
                        "Select Algorithm",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      buttonHeight: 20,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 13.0,
                          ),
                          isDense: true,
                          hintStyle: const TextStyle(fontSize: 14.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          )),
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownButton = value!;
                        });
                      }),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultContainer(
                      ontap: () {
                        setState(() {
                          selcet = !selcet;
                        });
                      },
                      colorBorder:
                          selcet ? Colors.blueAccent : Colors.grey.shade500,
                      colorText: selcet ? Colors.white : Colors.black,
                      text: 'Encrypt',
                      color: selcet ? Colors.blueAccent : Colors.white,
                    ),
                    const SizedBox(
                      width: 40.0,
                    ),
                    defaultContainer(
                      ontap: () {
                        setState(() {
                          selcet = !selcet;
                        });
                      },
                      colorBorder:
                          selcet ? Colors.grey.shade500 : Colors.blueAccent,
                      colorText: selcet ? Colors.black : Colors.white,
                      text: 'Decrypt',
                      color: selcet ? Colors.white : Colors.blueAccent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: defaultTextFormField(
                    controllder: textController,
                    text: 'Enter Plain Text',
                    perfix: Icons.text_fields_rounded,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plain Text is Empty please Enter Text";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                    submit: (value) {
                      setState(() {
                        if (dropdownButton == null) {
                          defaultToast(message: "Please Select Algorithm");
                        } else {
                          if (formKey.currentState!.validate()) {
                            if (selcet == true) {
                              if (dropdownButton == items[0]) {
                                result = logic!.caesar(
                                    textController.text, keyController.text,
                                    encrypt: true);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[1]) {
                                result = logic!.playfair(
                                  textController.text,
                                  keyController.text,
                                  encrypt: true,
                                );
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[2]) {
                                result = logic!.vignere(
                                  textController.text,
                                  keyController.text,
                                  encrypt: true,
                                );
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[3]) {
                                result = logic!.railfence(
                                    textController.text, keyController.text,
                                    encrypt: true);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[4]) {
                                result = logic!.rowColumnEncrypt(
                                    textController.text, keyController.text);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[5]) {
                                result = logic!.encryptAutokey(
                                    textController.text, keyController.text);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              }
                            } else {
                              if (dropdownButton == items[0]) {
                                result = logic!.caesar(
                                    textController.text, keyController.text,
                                    encrypt: false);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[1]) {
                                result = logic!.playfair(
                                  textController.text,
                                  keyController.text,
                                  encrypt: false,
                                );
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[2]) {
                                result = logic!.vignere(
                                  textController.text,
                                  keyController.text,
                                  encrypt: false,
                                );
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[3]) {
                                result = logic!.railfence(
                                    textController.text, keyController.text,
                                    encrypt: false);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[4]) {
                                result = logic!.rowColumnDecrypt(
                                    textController.text, keyController.text);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              } else if (dropdownButton == items[5]) {
                                result = logic!.decryptAutokey(
                                    textController.text, keyController.text);
                                result == 'Invalid key'
                                    ? defaultToast(message: result)
                                    : null;
                              }
                            }
                          }
                        }
                        // textController.text = '';
                        // keyController.text = '';
                      });
                    },
                    controllder: keyController,
                    text: "Enter key ",
                    perfix: Icons.lock,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Key is Empty please Enter Key';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (dropdownButton == null) {
                            defaultToast(message: "Please Select Algorithm");
                          } else {
                            if (formKey.currentState!.validate()) {
                              if (selcet == true) {
                                if (dropdownButton == items[0]) {
                                  result = logic!.caesar(
                                      textController.text, keyController.text,
                                      encrypt: true);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[1]) {
                                  result = logic!.playfair(
                                    textController.text,
                                    keyController.text,
                                    encrypt: true,
                                  );
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[2]) {
                                  result = logic!.vignere(
                                    textController.text,
                                    keyController.text,
                                    encrypt: true,
                                  );
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[3]) {
                                  result = logic!.railfence(
                                      textController.text, keyController.text,
                                      encrypt: true);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[4]) {
                                  result = logic!.rowColumnEncrypt(
                                      textController.text, keyController.text);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[5]) {
                                  result = logic!.encryptAutokey(
                                      textController.text, keyController.text);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                }
                              } else {
                                if (dropdownButton == items[0]) {
                                  result = logic!.caesar(
                                      textController.text, keyController.text,
                                      encrypt: false);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[1]) {
                                  result = logic!.playfair(
                                    textController.text,
                                    keyController.text,
                                    encrypt: false,
                                  );
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[2]) {
                                  result = logic!.vignere(
                                    textController.text,
                                    keyController.text,
                                    encrypt: false,
                                  );
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[3]) {
                                  result = logic!.railfence(
                                      textController.text, keyController.text,
                                      encrypt: false);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[4]) {
                                  result = logic!.rowColumnDecrypt(
                                      textController.text, keyController.text);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                } else if (dropdownButton == items[5]) {
                                  result = logic!.decryptAutokey(
                                      textController.text, keyController.text);
                                  result == 'Invalid key'
                                      ? defaultToast(message: result)
                                      : null;
                                }
                              }
                            }
                          }
                          // textController.text = '';
                          // keyController.text = '';
                        });
                      },
                      child: selcet
                          ? const Text('Encrypt',
                              style: TextStyle(color: Colors.white))
                          : const Text('Decrypt',
                              style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
