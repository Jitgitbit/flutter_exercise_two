import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // String titleInput;
  // String amountInput;                                 // important ! inputs always have to be strings, so in case of number, it needs to be converted !!
  final titleController = TextEditingController();
  final amountController =
      TextEditingController(); // this also a solution flutter likes in a stateless widget !
  final Function addTx;

  NewTransaction(this.addTx);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);     // needs to be converted into a string, hence the .parse !

    print('Here under is titleController.text');
    print(titleController.text);                        // Different way of logging !!!!!! DART !!!
    print('Here under is amountController.text');
    print(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){ return; }              // This blank return stops the fn in it's tracks here, no addTx !!!

    addTx(
        enteredTitle,
        enteredAmount
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        // Padding is a Container widget dedicated to add only a padding !
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) => titleInput = value,                // note the two differnt syntax options and their requirements !
              controller: titleController,
              onSubmitted: (_) => submitData(), 
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (val) {
              //   amountInput = val;                                    // note the two differnt syntax options and their requirements !
              // },
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),                                     // This is a convention "(_)", it means:"I get an argument, but I don't care, not used"
            ),                                                                   // Dart can be CORKY !!
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
