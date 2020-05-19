import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        accentColor: Colors.amber,
        // errorColor: Color.fromRGBO(139, 0, 0, 1),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(         
          headline6: TextStyle(
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
            headline6: TextStyle(
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

  Widget _buildLandscapeContent(){
    return Row(                             
              mainAxisAlignment: MainAxisAlignment.center,       
              children: <Widget>[
                Text('Show Chart', style: Theme.of(context).textTheme.headline6,),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart, 
                  onChanged: (val){
                    setState(() {
                      _showChart = val;
                    });
                  }),
              ],
            );
  }

  Widget _buildPortraitContent(MediaQueryData mediaQueryVar, AppBar appBarVar,){
    return Container(                                        
                  height: (
                    mediaQueryVar.size.height 
                    - appBarVar.preferredSize.height                //---> again this represents the space taken by the appBar !
                    - mediaQueryVar.padding.top                    //----> again this represents the space taken by the statusBar !
                  ) * 0.3,                                        //-----> finally responsiveness! 0.3 is ratio to 1, 30% !
                  child: Chart(_recentTransactions)
                );
  }

  @override
  Widget build(BuildContext context) {

    final PreferredSizeWidget appBarVar = Platform.isIOS 
      ? CupertinoNavigationBar(
          middle: Text('Phoenix Expenses App'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              ),
            ],
          ),
      ) 
      : AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Phoenix Expenses App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add), 
              onPressed: () => _startAddNewTransaction(context),
            ),
          ],
        );

    print("======>> Under here, what's the appBar height?");
    print(appBarVar.preferredSize.height);

    final mediaQueryVar = MediaQuery.of(context);                       //======>> using a var like this will improve performance (less recalculating !)

    final txListWidget = Container(                                                   
                  height: (
                    mediaQueryVar.size.height 
                    - appBarVar.preferredSize.height                                  //---> this represents the space taken by the appBar !
                    - mediaQueryVar.padding.top                                      //----> this represents the space taken by the statusBar !
                  ) * 0.7,                                                          //-----> finally responsiveness! 0.7 is ratio to 1, 70% !
                  child: TransactionList(_userTransactions, _deleteTransaction)
                );

    final isLandscape = mediaQueryVar.orientation == Orientation.landscape;

    final pageBody = SafeArea(child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape)_buildLandscapeContent(),                           // !!! DO NOT USE {} AFTER THIS IF STATEMENT,
            if(!isLandscape)_buildPortraitContent(mediaQueryVar, appBarVar),  // IT'S A SPECIAL "IF INSIDE OF A LIST" SYNTAX IN DART !!!
            if(!isLandscape)txListWidget,                        
            if(isLandscape)_showChart                           
              ? Container(                                            //===>> THE WHOLE SCREEN IS TAKEN INTO ACCOUNT NOW !
                  height: (
                    mediaQueryVar.size.height 
                    - appBarVar.preferredSize.height                //---> again this represents the space taken by the appBar !
                    - mediaQueryVar.padding.top                    //----> again this represents the space taken by the statusBar !
                  ) * 0.7,                                        //-----> finally responsiveness! 0.7 is ratio to 1, 70% !
                  child: Chart(_recentTransactions)
                )
              : txListWidget
          ],
        ),
      ),
    );

    return Platform.isIOS ? CupertinoPageScaffold(child: pageBody, navigationBar: appBarVar,) : Scaffold(
      appBar: appBarVar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS 
        ? Container() 
        : FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
    );
  }
}
