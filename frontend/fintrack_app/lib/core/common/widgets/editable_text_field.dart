import 'package:flutter/material.dart';

final class EditableTextField extends StatefulWidget {
  final String initialValue;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final InputDecoration? inputDecoration;
  final void Function(String newValue)? onSave;

  const EditableTextField({
    super.key,
    required this.initialValue,
    this.textStyle,
    this.hintStyle,
    this.inputDecoration,
    this.onSave,
    this.hintText,
  });

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

final class _EditableTextFieldState extends State<EditableTextField> {
  final FocusNode _focusNode = FocusNode();

  late TextEditingController _controller;

  bool _isEditing = false;

  void _saveChanges() {
    if (_controller.text.trim().isNotEmpty &&
        _controller.text != widget.initialValue) {
      widget.onSave?.call(_controller.text.trim());
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialValue);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _saveChanges();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? TextField(
            controller: _controller,
            focusNode: _focusNode,
            style: widget.textStyle,
            decoration: widget.inputDecoration ??
                InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle,
                ),
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
              _controller.text,
              style: widget.textStyle,
            ),
          );
  }
}
