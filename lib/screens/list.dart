import 'package:accountantapp/boxes.dart';
import 'package:accountantapp/model/member.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int _totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 119, 255),
        title: Text('Uye Listesi'),
      ),
      body: boxMembers.isEmpty
          ? Center(child: Text('Henuz uye yok'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: boxMembers.length,
                    itemBuilder: (context, index) {
                      Member member = boxMembers.getAt(index);

                      _totalPrice += member.price;

                      return ListTile(
                          // titleTextStyle: TextStyle(fontSize: 20),
                          tileColor: Color.fromARGB(255, 225, 214, 244),
                          title: Text('${member.fullname}',
                              style: TextStyle(fontSize: 18)),
                          subtitle: Text(
                              '${member.membership} // ${member.date.day}-${member.date.month}-${member.date.year} '),
                          trailing: Text(
                            '${member.price}',
                            style: TextStyle(fontSize: 18),
                          ),

                          // textColor: Colors.white,
                          leading: IconButton(
                              onPressed: () {
                                boxMembers.deleteAt(index);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete)));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Toplam: $_totalPrice')),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAlertDialog();
        },
        child: Icon(Icons.close),
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Silme Onayi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Tum bilgiler kalici olarak silinecek!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hayir'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () {
                boxMembers.clear();
                setState(() {});

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
