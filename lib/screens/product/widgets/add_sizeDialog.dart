import 'package:flutter/material.dart';



class AddSizeDialog extends StatelessWidget {

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(right: 8,left: 8, top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop(_controller.text);
                  },
                  child: Text("Add")),
            )
          ],
        ),
      ),

    );
  }
}
