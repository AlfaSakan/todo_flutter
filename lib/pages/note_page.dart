import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import '../helpers/helpers.dart';

class NotePage extends StatefulWidget {
  static const routeName = 'NotePage';
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _controllerNote, _controllerTime;
  late TimeOfDay _timeNote;
  bool _isEdit = false;
  int _choosenIndex = -1;

  @override
  void initState() {
    super.initState();
    _controllerNote = TextEditingController();
    _controllerTime = TextEditingController();
    _timeNote = TimeOfDay.now();
  }

  @override
  void dispose() {
    _controllerNote.dispose();
    _controllerTime.dispose();
    super.dispose();
  }

  void _onPressButton() {
    if (_controllerNote.text.isEmpty || _controllerTime.text.isEmpty) {
      return;
    }

    if (_isEdit) {
      _onEditNote();
      return;
    }

    NotesList notes = context.read<NotesList>();

    bool isExist = notes.getNotes.any((element) =>
        element.getActivity.toLowerCase() ==
        _controllerNote.text.toLowerCase());

    if (isExist) {
      return;
    }

    _onSaveNote();
  }

  void _onSaveNote() {
    Note newNote = Note();
    NotesList notes = context.read<NotesList>();

    newNote.activity = _controllerNote.text;
    newNote.time = setHourAndMinute().millisecondsSinceEpoch;

    notes.addNote(newNote);

    setState(() {
      _clearController();
    });
  }

  void _onEditNote() {
    NotesList notes = context.read<NotesList>();
    Note choosenNote = notes.getNotes[_choosenIndex];

    setState(() {
      choosenNote.activity = _controllerNote.text;
      choosenNote.time = setHourAndMinute().millisecondsSinceEpoch;
      _isEdit = false;
      _clearController();
    });
    notes.sortNote();
  }

  DateTime setHourAndMinute() {
    final now = DateTime.now();
    DateTime dateSetted = DateTime(
      now.year,
      now.month,
      now.day,
      _timeNote.hour,
      _timeNote.minute,
    );
    return dateSetted;
  }

  void _clearController() {
    _controllerNote.clear();
    _controllerTime.clear();
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
            controller: _controllerTime,
            labelText: 'Jam',
            onTap: () async {
              // var selectedTimeRTL = await showTimePicker(
              //   context: context,
              //   initialTime: _timeNote,
              //   builder: (BuildContext context, Widget? child) {
              //     return Directionality(
              //       textDirection: TextDirection.rtl,
              //       child: child!,
              //     );
              //   },
              // );

              TimeOfDay? selectedTime24Hour = await showTimePicker(
                context: context,
                initialTime: _timeNote,
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              );

              if (selectedTime24Hour == null) {
                return;
              }

              setState(() {
                _timeNote = selectedTime24Hour;
                _controllerTime.text = selectedTime24Hour.to24hours();
              });
            },
          ),
          const SizedBox(height: 20),
          ButtonBase(
            text: _isEdit ? 'Simpan Perubahan' : 'Simpan Catatan',
            onPressed: _onPressButton,
          ),
          const SizedBox(height: 20),
          ...context.watch<NotesList>().getNotes.asMap().entries.map(
            (e) {
              Note note = e.value;
              int index = e.key;

              return ListTile(
                title: Text(toTitleCase(note.getActivity)),
                subtitle: Text(
                  note.displayTime(),
                ),
                trailing: IconBase(
                  onTap: () {
                    setState(() {
                      _controllerNote.text = note.getActivity;
                      _controllerTime.text = note.displayTime();
                      _isEdit = true;
                      _choosenIndex = index;
                    });
                  },
                  icon: Icons.edit,
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}
