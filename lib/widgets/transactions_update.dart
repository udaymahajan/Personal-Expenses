import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateTransaction extends StatefulWidget {
  final Function function;

  UpdateTransaction(this.function);

  @override
  _UpdateTransactionState createState() => _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        double.parse(_amountController.text) <= 0 || _pickedDate == null) {
      return;
    }
    widget.function(_titleController.text, double.parse(_amountController.text),
        _pickedDate);

    Navigator.of(context).pop();
  }

  void _chooseDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light().copyWith(
                  primary: Colors.red,
                ),
              ),
              child: child);
        }
        ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          height: 300,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  // onChanged: (val) => titleInput = val,
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  // onChanged: (val) => amountInput = val,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      _pickedDate == null
                          ? 'Picked Date: No Date Chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_pickedDate)}',
                    )),
                    TextButton(
                        child: Text('Choose Date'),
                        onPressed: _chooseDate,
                        style: TextButton.styleFrom(primary: Colors.purple),),
                  ],
                ),
                ElevatedButton(
                  child: Text('Add Transaction'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    onPrimary: Colors.black,
                  ),
                  onPressed: _submitData,
                ),
              ],
            ),
          ),
        ));
  }
}
