import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';
import '../providers/providers.dart';
import '../helpers/helpers.dart';

class MoneyPage extends StatefulWidget {
  static const routeName = 'MoneyPage';
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  late TextEditingController _controllerAmount, _controllerDescription;
  late bool _isEdit;
  late String? _incomeOutcome;
  late int _choosenIndex;

  String _formatNumber(String s) => NumberFormat.currency(
        locale: 'id',
        decimalDigits: 0,
        symbol: '',
      ).format(
        int.parse(s),
      );

  @override
  void initState() {
    super.initState();
    _controllerAmount = TextEditingController();
    _controllerDescription = TextEditingController();
    _incomeOutcome = null;
    _isEdit = false;
    _choosenIndex = -1;
  }

  @override
  void dispose() {
    _controllerAmount.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  void _onPressButton() {
    if (_controllerAmount.text.isEmpty ||
        _controllerDescription.text.isEmpty ||
        _incomeOutcome == null) {
      return;
    }

    if (_isEdit) {
      _onSubmitEdit();
      return;
    }

    _onSubmit();
    _clearController();
  }

  void _clearController() {
    setState(() {
      _controllerAmount.clear();
      _controllerDescription.clear();
      _incomeOutcome = null;
      _choosenIndex = -1;
      _isEdit = false;
    });
  }

  void _onSubmitEdit() {
    MoneyHistory moneyHistory = context.read<MoneyHistory>();

    MoneyFlow choosenHistory = moneyHistory.getHistoryList[_choosenIndex];

    choosenHistory.amount =
        int.parse(_controllerAmount.text.replaceAll('.', ''));
    choosenHistory.description = _controllerDescription.text;
    choosenHistory.isIncome = _incomeOutcome == 'Pemasukan';

    _clearController();
  }

  void _onSubmit() {
    MoneyHistory history = context.read<MoneyHistory>();

    MoneyFlow newItem = MoneyFlow();

    newItem.amount = int.parse(_controllerAmount.text.replaceAll('.', ''));
    newItem.description = _controllerDescription.text;
    newItem.isIncome = _incomeOutcome == "Pemasukan";

    history.addHistory(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catatan Keuangan',
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
          TextFieldNumber(
            controller: _controllerAmount,
            labelText: 'Jumlah Uang',
            hintText: '10.000',
            prefixText: 'IDR',
            onChanged: (string) {
              var amount = _formatNumber(string.replaceAll('.', ''));
              _controllerAmount.value = TextEditingValue(
                  text: amount,
                  selection: TextSelection.collapsed(offset: amount.length));
            },
          ),
          const SizedBox(height: 20),
          TextFieldBase(
            controller: _controllerDescription,
            labelText: 'Keterangan',
          ),
          const SizedBox(height: 20),
          DropdownButton(
            value: _incomeOutcome,
            items: ['Pemasukan', 'Pengeluaran'].asMap().entries.map((e) {
              return DropdownMenuItem(
                child: Text(e.value),
                value: e.value,
              );
            }).toList(),
            onChanged: (String? value) {
              if (value == null) {
                return;
              }
              setState(() {
                _incomeOutcome = value;
              });
            },
            hint: const Text('Pilih Aliran Uang'),
            isExpanded: true,
          ),
          const SizedBox(height: 20),
          ButtonBase(
            text: _isEdit ? 'Simpan Perubahan' : 'Simpan Catatan',
            onPressed: _onPressButton,
          ),
          const SizedBox(height: 20),
          ...context.watch<MoneyHistory>().getHistoryList.asMap().entries.map(
            (e) {
              MoneyFlow history = e.value;
              int index = e.key;

              return ListTile(
                title: Text(
                  NumberFormat.currency(
                    locale: 'id',
                    decimalDigits: 0,
                  ).format(
                    history.getAmount,
                  ),
                  style: TextStyle(
                    color: history.getIsIncome ? Colors.green : Colors.red,
                  ),
                ),
                subtitle: Text(
                  history.getDescription,
                ),
                trailing: IconBase(
                  onTap: () {
                    setState(() {
                      _isEdit = true;
                      _controllerAmount.text = history.getAmount.toString();
                      _controllerDescription.text = history.getDescription;
                      _incomeOutcome = history.typeMoneyFlow();
                      _choosenIndex = index;
                    });
                  },
                  icon: Icons.edit,
                  color: history.getIsIncome ? Colors.green : Colors.red,
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
