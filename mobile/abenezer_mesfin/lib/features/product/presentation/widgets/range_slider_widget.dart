import 'package:flutter/material.dart';

class RangeSliderWidget extends StatefulWidget {
  final double start;
  final double end;
  final Function(RangeValues) onChanged;

  const RangeSliderWidget({
    super.key,
    required this.start,
    required this.end,
    required this.onChanged,
  });

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _values = RangeValues(widget.start, widget.end);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Price Range',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        RangeSlider(
          values: _values,
          min: 0,
          max: 500,
          divisions: 100,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            '\$${_values.start.toStringAsFixed(0)}',
            '\$${_values.end.toStringAsFixed(0)}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _values = values;
            });
            widget.onChanged(values);
          },
        ),
      ],
    );
  }
}
