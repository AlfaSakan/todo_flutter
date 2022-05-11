import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class NotePage extends StatefulWidget {
  static const routeName = 'NotePage';
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _controllerNote, _controllerDate;
  late DateTime _dateTime;
  final List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _controllerNote = TextEditingController();
    _controllerDate = TextEditingController();
    _dateTime = DateTime.now();

    Note dummyDate = Note();
    dummyDate.activity = 'Makan';

    notes.add(dummyDate);
  }

  @override
  void dispose() {
    _controllerNote.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catatan Harian',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        children: [
          TextFieldBase(
            controller: _controllerNote,
            labelText: 'Catatan',
          ),
          const SizedBox(height: 20),
          TextFieldDatePicker(
            controller: _controllerDate,
            labelText: 'Tanggal',
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: _dateTime,
                firstDate: DateTime(2021),
                lastDate: DateTime(2222),
                currentDate: _dateTime,
              ).then((value) {
                setState(() {
                  _dateTime = value!;
                  _controllerDate.text =
                      '${_dateTime.day}-${_dateTime.month}-${_dateTime.year}';
                });
              });
            },
          ),
          const SizedBox(height: 20),
          ButtonBase(
            text: 'Simpan Catatan',
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          ...notes.map(
            (e) {
              return ListTile(
                title: Text(e.getActivity),
                subtitle: Text(
                  e.formatedDate(),
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
