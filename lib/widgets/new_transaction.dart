import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  // String titleInput;
  // String amountInput;                                 // important ! inputs always have to be strings, so in case of number, it needs to be converted !!
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController(); 
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);     // needs to be converted into a string, hence the .parse !

    print('Here under is titleController.text');
    print(_titleController.text);                        // Different way of logging !!!!!! DART !!!
    print('Here under is amountController.text');
    print(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){ return; }              // This blank return stops the fn in it's tracks here, no addTx !!!

    widget.addTx(                                                    // thanks to this widget property we can use the fn coming from another class !!!
        enteredTitle,
        enteredAmount
    ); 

    Navigator.of(context).pop();        // --> this closes the top-most screen.  In this case it will close the modal sheet at submit !!!
  }                                      // -> context here is made available because we extend State !!

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null ){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('loading...');
  }

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
              controller: _titleController,
              onSubmitted: (_) => _submitData(), 
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (val) {
              //   amountInput = val;                                    // note the two differnt syntax options and their requirements !
              // },
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),                                     // This is a convention "(_)", it means:"I get an argument, but I don't care, not used"
            ),                                                                      // Dart can be CORKY !!
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(                                                    // with Expanded it will only take as much space as it needs
                    child: Text(
                      _selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
