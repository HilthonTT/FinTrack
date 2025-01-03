import 'package:flutter/material.dart';

final class EditableNumericField extends StatefulWidget {
  final double initialValue;
  final TextStyle? textStyle;
  final InputDecoration? inputDecoration;
  final void Function(double newValue)? onSave;

  const EditableNumericField({
    super.key,
    required this.initialValue,
    this.textStyle,
    this.inputDecoration,
    this.onSave,
  });

  @override
  State<EditableNumericField> createState() => _EditableNumericFieldState();
}

final class _EditableNumericFieldState extends State<EditableNumericField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;

  bool _isEditing = false;

  void _saveChanges() {
    final newValue = double.tryParse(_controller.text.trim());
    if (newValue != null && newValue != widget.initialValue) {
      widget.onSave?.call(newValue);
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue.toStringAsFixed(2),
    );

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _saveChanges();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? TextField(
            controller: _controller,
            focusNode: _focusNode,
            style: widget.textStyle,
            keyboardType: TextInputType.number,
            decoration: widget.inputDecoration ??
                const InputDecoration(border: InputBorder.none),
            inputFormatters: [],
            autofocus: true,
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                _isEditing = true;
              });
              _focusNode.requestFocus();
            },
            child: Text(
              widget.initialValue.toStringAsFixed(2),
              style: widget.textStyle,
            ),
          );
  }
}
