import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
// import './widgets/user_transactions.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([                            //----> Forcing Portrait only !
  //   DeviceOrientation.portraitUp, 
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoenix Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Colors.amber,
        // accentColor: Color.fromRGBO(139, 0, 0, 1),
        accentColor: Colors.amber,
        // errorColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(         
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'new shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'new hat',
    //   amount: 39.15,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {                                     // .where is a DART specific method !
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),));    // .isAfter is a DART specific method !
    }).toList();                                                                // --> it expects a List
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle, 
      amount: txAmount, 
      date: chosenDate, 
      id: DateTime.now().toString()          // not ideal for id, but it is unique !!
    );   

    setState(() {
      _userTransactions.add(newTx);
    });
  } 
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (bCtx){
      return GestureDetector(
        onTap: (){},                                            // safety to prevent modal closing when sheet itself is tapped
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addNewTransaction),
      );
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);        // Dart is so easy !
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarVar = AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Phoenix Expenses App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      );
    return Scaffold(
      appBar: appBarVar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch(value: _showChart, onChanged: (val){
                  setState(() {
                    _showChart = val;
                  });
                }),
              ],
            ),
            _showChart
              ? Container(
                  height: (
                    MediaQuery.of(context).size.height 
                    - appBarVar.preferredSize.height                //---> this represents the space taken by the appBar !
                    - MediaQuery.of(context).padding.top           //----> this represents the space taken by the statusBar !
                  ) * 0.7,                                        //-----> finally responsiveness! 0.4 is ratio to 1, 40% !
                  child: Chart(_recentTransactions)
                )
              : Container(                                                   //===>> THE WHOLE SCREEN IS TAKEN INTO ACCOUNT NOW !
                  height: (
                    MediaQuery.of(context).size.height 
                    - appBarVar.preferredSize.height                                  //---> again this represents the space taken by the appBar !
                    - MediaQuery.of(context).padding.top                             //----> again this represents the space taken by the statusBar !
                  ) * 0.7,                                                          //-----> finally responsiveness! 0.6 is ratio to 1, 60% !
                  child: TransactionList(_userTransactions, _deleteTransaction)
                ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
