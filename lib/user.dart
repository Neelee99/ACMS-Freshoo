import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acms/services/database.dart';
import 'package:acms/dashboard.dart';
//import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:acms/widgets/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:acms/models/uid.dart';
import 'package:toast/toast.dart';
import 'package:acms/globals.dart';
import 'package:acms/user.dart';



final scaffoldKey = new GlobalKey<ScaffoldState>();

class ManageCards1 extends StatelessWidget {



  final _formKey = GlobalKey<FormState>();
    int balance=0;
    String h;
    int fb;
    

 bool validate() {
    final form = _formKey.currentState; //all the text fields will be set to values
    form.save(); // to save the form
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  
  void showToast(String msg,context, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }


  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: StreamBuilder(
        stream: getUsersTripsStreamSnapshots1(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading...");
          return new ListView.builder(
            
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildTripCard1(context, snapshot.data.documents[index]));
        }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots1(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    

    yield* Firestore.instance.collectionGroup('item').where('item_name',isEqualTo:'$it').snapshots();
 //print(Firestore.instance.collection('shops').getDocuments());
    
  }

  Widget buildTripCard1(BuildContext context, DocumentSnapshot card) {
    
    
    print("hello");
    return new Container(

      child:SingleChildScrollView(
        
      child: Card(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text("Retailer Name: "+card['retailer_name'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  new RaisedButton(
                                  child: new Text("Restock",
                                  style:TextStyle(
                                    fontSize:18,
                                    color:Colors.black54,
                                  )),
                                  onPressed: (){
                                    showDialog(
                                      context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Quantity to be added"),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSaved: (val)=>balance=int.parse(val),
                            ),
                          ),
                          
                          
                        ],
                      ),
                    ),
                  );
                }
                
                );
                  //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards()));
                                  }//performSubmit,
                  ),
                  Spacer(),
                ]),
              ),
              
              
              
                  

              
            ],
          ),
        ),
        

         
    ))
    );
  
  }
}

                