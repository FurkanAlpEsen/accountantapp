import 'package:accountantapp/boxes.dart';
import 'package:accountantapp/common.dart';
import 'package:accountantapp/model/member.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  final TextEditingController _fullnameConttroller = TextEditingController();
  final TextEditingController _membershipConttroller = TextEditingController();
  final TextEditingController _priceConttroller = TextEditingController();

  var _selectedDay;
  var _focusedDay;

  @override
  void dispose() {
    _fullnameConttroller.dispose();
    _membershipConttroller.dispose();
    _priceConttroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 138, 152, 232),
        title: Text('Uye Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _fullnameConttroller,
                  decoration: InputDecoration(
                    // errorText: _fullnameConttroller.text.isEmpty
                    //     ? 'Uye ad soyad bos birakilamaz'
                    //     : null,
                    border: OutlineInputBorder(),
                    hintText: 'Uye Ad Soyad',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _membershipConttroller,
                  decoration: InputDecoration(
                    // errorText: 'Uye ad soyad bos birakilamaz',
                    border: OutlineInputBorder(),
                    hintText: 'Uyelik Turu',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _priceConttroller,
                  decoration: InputDecoration(
                    // errorText: 'Uye ad soyad bos birakilamaz',
                    border: OutlineInputBorder(),
                    hintText: 'Alinan Ucret',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Tarih Secilmeli',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                TableCalendar(
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Color(0xff3968fa),
                          borderRadius: BorderRadius.circular(10))),
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    if (_fullnameConttroller.text.isEmpty) {
                      _formSnackBar('Uye ad soyad bos birakilamaz');
                    }
                    if (_membershipConttroller.text.isEmpty) {
                      _formSnackBar('Uyelik turu bos birakilamaz');
                    }
                    if (_priceConttroller.text.isEmpty) {
                      _formSnackBar('Uyelik ucreti bos birakilamaz');
                    } else {
                      setState(() {
                        boxMembers.put(
                            'key_${_fullnameConttroller.text}',
                            Member(
                                fullname: _fullnameConttroller.text,
                                membership: _membershipConttroller.text,
                                price: int.parse(_priceConttroller.text),
                                date: _selectedDay == null
                                    ? DateTime.now()
                                    : _selectedDay));
                      });

                      _customSnackBar();
                    }

                    _fullnameConttroller.clear();
                    _membershipConttroller.clear();
                    _priceConttroller.clear();
                  },
                  child: const Text('Kaydet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _formSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _customSnackBar() {
    final materialBanner = MaterialBanner(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: 'Harika',
        message: 'Bilgiler Basari ile Kaydedildi',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
        // to configure for material banner
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }
}
