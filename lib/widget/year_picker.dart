import 'package:flutter/material.dart';

class YearPickerWidget extends StatefulWidget {
  final int startYear;
  final int endYear;
  final Function(int?) onYearChanged;

  YearPickerWidget({
    required this.startYear,
    required this.endYear,
    required this.onYearChanged,
  });

  @override
  _YearPickerWidgetState createState() => _YearPickerWidgetState();
}

class _YearPickerWidgetState extends State<YearPickerWidget> {
  int? _selectedYear;

  @override
  Widget build(BuildContext context) {
    List<int> years = List<int>.generate(
      widget.endYear - widget.startYear + 1,
          (index) => widget.startYear + index,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedYear,
          hint: Text('Select Year'),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down),
          items: years.map((int year) {
            return DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              _selectedYear = newValue;
            });
            widget.onYearChanged(newValue);
          },
        ),
      ),
    );
  }
}
