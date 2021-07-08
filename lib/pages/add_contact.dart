import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  void showToast(){
    Fluttertoast.showToast(
      msg: "Details added",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 18.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text(
          "Add a Contact",
          style: TextStyle(
            color: Color(0xFFEDF0DA),
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0077B6),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Empty Field";
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contact Name",
                    hintText: "Enter the person's name",
                    suffixIcon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Empty Field";
                    else if(value.length != 10)
                      return "Invalid Mobile Number";
                    return null;
                  },
                  controller: numberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mobile Number",
                    hintText: "Enter the mobile number",
                    suffixIcon: Icon(Icons.contacts),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Empty Field";
                    else if(!value.contains('@'))
                      return "Invalid Email";
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email Address",
                    hintText: "Enter the email address",
                    suffixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height:30.0),
                TextButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      showToast();
                      String name = nameController.text;
                      String number = numberController.text;
                      String email = emailController.text;
                      nameController.clear();
                      numberController.clear();
                      emailController.clear();
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pushReplacementNamed(context, '/home', arguments: {
                          "name": name,
                          "number": number,
                          "email": email
                        });
                      });
                    }},
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF0096C7)),
                    fixedSize: MaterialStateProperty.all(Size.fromHeight(50.0)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
