// Card(                       
//                   child: Row(                     
//                     children: <Widget>[
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                           color: Theme.of(context).primaryColorDark,
//                           width: 2,
//                         )),
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           '\$${transactions[index].amount.toStringAsFixed(2)}',              // two decimals, always
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             transactions[index].title,
//                             // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                             style: Theme.of(context).textTheme.title,
//                           ),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index].date),
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );