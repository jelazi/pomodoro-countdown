import 'package:flutter/material.dart';

class QuestionDialog extends StatefulWidget {
  String textDialog;
  String textQuestion;
  String textYesBtn;
  String textNoBtn;
  Function answerYes;
  QuestionDialog(this.textDialog, this.textQuestion, this.textYesBtn,
      this.textNoBtn, this.answerYes);

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      contentPadding: const EdgeInsets.all(5.0),
      content: Container(
        color: Colors.black87,
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Text(
                widget.textDialog,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Text(
                widget.textQuestion,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: clickYes, child: Text(widget.textYesBtn)),
                ElevatedButton(
                    onPressed: clickNo, child: Text(widget.textNoBtn)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  clickYes() {
    widget.answerYes();
    Navigator.pop(context);
  }

  clickNo() {
    Navigator.pop(context);
  }
}
