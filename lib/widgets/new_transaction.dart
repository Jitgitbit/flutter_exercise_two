import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  // String titleInput;
  // String amountInput;                                 // important ! inputs always have to be strings, so in case of number, it needs to be converted !!
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController =
      TextEditingController(); 
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);     // needs to be converted into a string, hence the .parse !

    print('Here under is titleController.text');
    print(titleController.text);                        // Different way of logging !!!!!! DART !!!
    print('Here under is amountController.text');
    print(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){ return; }              // This blank return stops the fn in it's tracks here, no addTx !!!

    widget.addTx(                                                    // thanks to this widget property we can use the fn coming from another class !!!
        enteredTitle,
        enteredAmount
    ); 

    Navigator.of(context).pop();        // --> this closes the top-most screen.  In this case it will close the modal sheet at submit !!!
  }                                      // -> context here is made available because we extend State !!

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(                                              // Padding is a Container widget dedicated to add only a padding !
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
