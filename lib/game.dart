import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import './register.dart';

class GuessTheNumberGame extends StatefulWidget {
  const GuessTheNumberGame({Key? key}) : super(key: key);

  @override
  _GuessTheNumberGameState createState() => _GuessTheNumberGameState();
}

class _GuessTheNumberGameState extends State<GuessTheNumberGame> {
  TextEditingController guessController = TextEditingController();
  int targetNumber = 0;
  int userGuess = 0;
  int attempts = 0;
  bool gameWon = false;

  @override
  void initState() {
    super.initState();
    generateTargetNumber();
  }

  void generateTargetNumber() {
    final Random random = Random();
    targetNumber = random.nextInt(100) + 1;
  }

  void makeGuess() {
    setState(() {
      attempts++;
      print('Username: $loggedInUsername, Attempts: $attempts');
      if (userGuess == targetNumber) {
        gameWon = true;
        showEndGameDialog();
      } else if (userGuess < targetNumber) {
        showHintDialog('$loggedInUsername, Too low! Try a higher number.');
      } else {
        showHintDialog('$loggedInUsername, Too high! Try a lower number.');
      }
    });
  }



  void showHintDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hint'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showEndGameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('$loggedInUsername, You guessed the number in $attempts attempts.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Try Again", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    ).then((value) {
      updateHits('$loggedInUsername', attempts);
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }


  Future<void> updateHits(String username, int attempts) async {
    try {
      final response = await http.post(
        Uri.parse('https://guessnumber1.000webhostapp.com/record_hit.php'),
        body: {
          'username': username,
          'attempts': attempts.toString(),
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

      }
    } catch (e) {
      print('Error updating hits: $e');
      showAlert('Error', 'Failed to update hits. Please try again.');
    }
  }



  void showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess The Number'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/backgroundIMG.jpeg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Guess the number \nbetween 1 and 100.\n',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: guessController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      userGuess = int.tryParse(value) ?? 0;
                    },

                    decoration: const InputDecoration(

                      hintText: 'Enter your guess',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: makeGuess,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 30.0,
                      ),
                    ),
                    child: const Text('Make Guess', style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    guessController.dispose();
    super.dispose();
  }

}

