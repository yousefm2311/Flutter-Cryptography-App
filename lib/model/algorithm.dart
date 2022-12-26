// ignore_for_file: curly_braces_in_flow_control_structures, prefer_is_empty, prefer_interpolation_to_compose_strings, unused_import
import 'dart:convert';
class Logic {
  // ascii code in dart a-z = 97 - 122 && A-Z = 65 - 90
  static int _offsetFor(int ch) {
    return (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) ? 97 : 65;
  }

  String error = 'Invalid key';
  String caesar(
    String input,
    String shift, {
    bool encrypt = false,
  }) {
    String output = '';

    // check input is a String
    if (nonAlphaRegExp.allMatches(input).length != 0) {
      return 'Invalid characters in Caeser';
    }

    int? shiftBy = int.tryParse(shift);
    if (shiftBy == null) {
      return error;
    }
    for (int i = 0; i < input.length; i++) {
      if (input[i] != ' ') {

        // check if the input is a (a-z)  || (A-Z)

        int offset = _offsetFor(input.codeUnitAt(i));

        // encrypt & Decrypt the input (encrypt == true, decrypt == false)
        output += String.fromCharCode(encrypt
            ? (input.codeUnitAt(i) + shiftBy - offset) % 26 + offset
            : (input.codeUnitAt(i) - shiftBy - offset) % 26 + offset);
      } else {
        output += input[i];
      }
    }

    return output;
  }

// Vigenere Cipher encryption and decryption
  String vignere(String input, String key, {bool encrypt = false}) {
    String output = '';

    input = input.toUpperCase();


    // check input is a String
    if (nonAlphaRegExp.allMatches(input).length != 0)
      return 'Invalid characters Vigenere';
    // replace "  " to "" and convert key to uppercase
    key = key.replaceAll(' ', '').toUpperCase();

    // check key is not empty
    if (key.isEmpty) return 'Invalid key. Cannot be blank.';

     // check input is a String
    if (nonAlphaRegExp.allMatches(key).length != 0) return error;

    int j = 0;
    for (int i = 0; i < input.length; i++) {

       // encrypt & Decrypt the input (encrypt == true, decrypt == false)
      if (input[i] != ' ') {
        output += String.fromCharCode(encrypt
            ? (input.codeUnitAt(i) + key.codeUnitAt(j)) % 26 + 65
            : (input.codeUnitAt(i) - key.codeUnitAt(j) + 26) % 26 + 65);

        // repetition key 
        if (j < key.length - 1) {
          j++;
        } else {
          j = 0;
        }
      } else {
        output += input[i];
      }
    }

    return output;
  }

// Rail fence keyword encryption and decryption


// create list to store data
  static List<dynamic> _fence(dynamic input, int numRails) {
    List<List<dynamic>> fence = List<List<dynamic>>.generate(
        numRails, (i) => List<dynamic>.generate(input.length, (j) => null));
    List<int> rails = List.generate(numRails - 1, (i) => i);
    rails.addAll(List<int>.generate(numRails - 1, (i) => (numRails - i - 1)));

    for (int i = 0; i < input.length; i++) {
      fence[rails[i % rails.length]][i] = input[i];
    }

    List<dynamic> output = [];
    for (var rail in fence) {
      for (var c in rail) {
        if (c != null) output.add(c);
      }
    }
    return output;
  }

  // 

  String railfence(String input, String rails, {bool encrypt = false}) {

    // check input is a String
    if (nonAlphaRegExp.allMatches(input).length != 0)
      return 'Invalid characters RailFence';

    // try convert String to  integer 
    int? key = int.tryParse(rails);
    if (key == null) return error;

    // join list
    var fence = _fence(input, key);
    if (encrypt)
      return fence.join('');
    else {
      List<int> range = List.generate(input.length, (i) => (i));
      var pos = _fence(range, key);
      List<String> deciphered = [];

      for (int i in range) {
        deciphered.add(input[pos.indexWhere((element) => element == i)]);
      }
      return deciphered.join('');
    }
  }

// Playfair cipher encryption & decryption

//  This function determines the position of the character
  static XYCoordinate _getRowCol(String element, List<String> matrix) {
    int index = matrix.indexOf(element);
    return XYCoordinate((index / 5).floor(), index % 5);
  }



// encryption Palyfair algorithm

  static String _findPair(String oldPair, List<String> matrix, bool encrypt) {
    String newPair;
    int direction = encrypt ? 1 : -1;


    XYCoordinate one = _getRowCol(oldPair[0], matrix);
    XYCoordinate two = _getRowCol(oldPair[1], matrix);

    if (one.x == two.x) {
      // same row
      newPair = matrix[(5 + (one.y + direction)) % 5 + (one.x * 5)] +
          matrix[(5 + (two.y + direction)) % 5 + (two.x * 5)];
    } else if (one.y == two.y) {
      // same column
      newPair = matrix[((one.x * 5) + one.y + (5 * direction)) % 25] +
          matrix[((two.x * 5) + two.y + (5 * direction)) % 25];
    } else {
      // rectangle, otherwise
      newPair = matrix[(one.x * 5) + one.y + (two.y - one.y)] +
          matrix[(two.x * 5) + two.y + (one.y - two.y)];
    }

    return newPair;
  }

  static final RegExp nonAlphaRegExp = RegExp('[^a-zA-Z ]');


  String playfair(String input, String key, {bool encrypt = false}) {
    if (nonAlphaRegExp.allMatches(input).length != 0)
      return 'Invalid characters in plaintext!';

    input = input.toUpperCase().replaceAll('J', 'I').replaceAll(' ', '');

    if (nonAlphaRegExp.allMatches(key).length != 0) return error;

    key = key.toUpperCase().replaceAll('J', 'I').replaceAll(' ', '');

    if (input.isEmpty || key.isEmpty) return error;

    List<String> matrix = List<String>.from(key.split('')).toSet().toList();

    for (int i = 0; i < 26; i++) {
      if (i != 9 && !matrix.contains(String.fromCharCode(i + 65))) {
        // do not put a J (== I)
        matrix.add(String.fromCharCode(i + 65));
      }
    }

    String target = '';
    for (int i = 0; i < input.length; i = i + 2) {
      if (i + 2 > input.length) {
        input += (input[i] == 'Z')
            ? 'X'
            : 'Z'; // Stick a Z at the end (X if Z already present)
      }
      if (input[i] == input[i + 1]) {
        // If this digraph's letters match, insert an X
        input = input.substring(0, i + 1) + 'X' + input.substring(i + 1);
      }

      target += _findPair(input[i] + input[i + 1], matrix, encrypt);
    }
    return target;
  }

// Keyword cipher encryption and decryption

  String rowColumnEncrypt(String text, String key) {
    String fullKey = '', result = '';
    key = key.toUpperCase();
    text = text.toUpperCase();

    for (var i = 0; i < key.length; i++)
      if (fullKey.contains(key[i]) == false && key[i] != ' ') fullKey += key[i];

    for (var i = 'A'.codeUnitAt(0); i <= 'Z'.codeUnitAt(0); i++)
      if (fullKey.contains(String.fromCharCode(i)) == false)
        fullKey += String.fromCharCode(i);

    for (var i = 0; i < text.length; i++) {
      if (text[i] == ' ')
        result += ' ';
      else
        result += fullKey[text[i].codeUnitAt(0) - 65];
    }

    return result;
  }

  String rowColumnDecrypt(String text, String key) {
    String fullKey = '', result = '';
    key = key.toUpperCase();
    text = text.toUpperCase();

    for (var i = 0; i < key.length; i++)
      if (fullKey.contains(key[i]) == false &&
          key[i] != ' ' &&
          key[i].codeUnitAt(0) >= 'A'.codeUnitAt(0) &&
          key[i].codeUnitAt(0) <= 'Z'.codeUnitAt(0)) fullKey += key[i];

    for (var i = 'A'.codeUnitAt(0); i <= 'Z'.codeUnitAt(0); i++)
      if (fullKey.contains(String.fromCharCode(i)) == false)
        fullKey += String.fromCharCode(i);

    for (var i = 0; i < text.length; i++) {
      if (text[i] == ' ')
        result += ' ';
      else {
        result +=
            String.fromCharCode(fullKey.indexOf(text[i]) + 'A'.codeUnitAt(0));
      }
    }

    return result;
  }




String encryptAutokey(String plaintext, String key) {
  // Convert the plaintext and key to uppercase
  plaintext = plaintext.toUpperCase();
  key = key.toUpperCase();

  // Convert the plaintext and key to lists of integers
  List<int> plaintextInts = plaintext.codeUnits;
  List<int> keyInts = key.codeUnits;

  // Initialize the result as an empty list of integers
  List<int> result = [];

  // Iterate over the plaintext, applying the Autokey Cipher to each character
  for (int i = 0; i < plaintextInts.length; i++) {
    int p = plaintextInts[i];

    // The Autokey Cipher formula is: c = (p + k) % 26
    // where c is the ciphertext character, p is the plaintext character, and k is the key character
    int k = i < keyInts.length ? keyInts[i] : plaintextInts[i - keyInts.length];
    int c = (p + k - 2 * 65) % 26 + 65;
    result.add(c);
  }

  // Convert the result list of integers to a string and return it
  return String.fromCharCodes(result);
}

String decryptAutokey(String ciphertext, String key) {
  // Convert the ciphertext and key to uppercase
  ciphertext = ciphertext.toUpperCase();
  key = key.toUpperCase();

  // Convert the ciphertext and key to lists of integers
  List<int> ciphertextInts = ciphertext.codeUnits;
  List<int> keyInts = key.codeUnits;

  // Initialize the result as an empty list of integers
  List<int> result = [];

  // Iterate over the ciphertext, applying the reverse of the Autokey Cipher to each character
  for (int i = 0; i < ciphertextInts.length; i++) {
    int c = ciphertextInts[i];

    // The reverse of the Autokey Cipher formula is: p = (c - k + 26) % 26
    // where p is the plaintext character, c is the ciphertext character, and k is the key character
    int k = i < keyInts.length ? keyInts[i] : result[i - keyInts.length];
    int p = (c - k + 26) % 26 + 65;
    result.add(p);
  }

  // Convert the result list of integers to a string and return it
  return String.fromCharCodes(result);
}


// End of function
}

class XYCoordinate {
  final int x;
  final int y;

  XYCoordinate(this.x, this.y);
}
