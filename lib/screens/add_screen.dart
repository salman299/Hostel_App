import 'package:flutter/material.dart';
import 'package:hostel_app/module/hostels.dart';
import 'package:hostel_app/screens/add_hostel.dart';
import 'package:provider/provider.dart';

class AddHostelScreen extends StatefulWidget {
  @override
  _AddHostelScreenState createState() => _AddHostelScreenState();
}

class _AddHostelScreenState extends State<AddHostelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddHostel.routeName);
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: Provider.of<Hostels>(context, listen: false).fetchMyHostel(),
          builder: (context, snap) => snap.connectionState ==
                  ConnectionState.waiting
              ? CircularProgressIndicator()
              : Consumer<Hostels>(
                  builder: (ctx, data, ch) => ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    itemCount: data.myHostel.length,
                    itemBuilder: (ctx, index) => Card(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).pushNamed(AddHostel.routeName,arguments: index);
                        },
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        title: Text(data.myHostel[index].name),
                        trailing: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
