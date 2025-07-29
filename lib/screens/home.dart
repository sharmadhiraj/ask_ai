import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String? _error;
  bool _listening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _listening ? null : _startListeningTheQuestion,
        backgroundColor: Colors.teal,
        child: _listening
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Icon(
                Icons.abc,
                color: Colors.white,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text("Ask AI"));
  }

  Widget _buildBody() {
    if (_error != null) {
      return _buildError();
    } else if (_listening) {
      return _buildListening();
    }
    return _buildIntroLabel();
  }

  Widget _buildIntroLabel() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Tap on mic and ask the question .....",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildListening() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Listening your question .....",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          _error!,
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _startListeningTheQuestion() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        setState(() {
          if (status == "listening") {
            _listening = true;
            _error = null;
          } else if (status == "done") {
            _listening = false;
          }
        });
      },
      onError: (error) => setState(() => _error = error.toString()),
    );
    if (available) {
      _speech.listen(
        onResult: (result) {
          debugPrint("Result");
          debugPrint(result.toJson().toString());
        },
      );
    } else {
      debugPrint("The user has denied the use of speech recognition.");
    }
  }
}
