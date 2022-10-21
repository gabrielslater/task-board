import 'package:flutter/material.dart';

import 'card_list_editor.dart';

class EditableCardList extends StatefulWidget {
  final ListModel model;
  final Function(ListModel listModel) onChanged;
  const EditableCardList(
      {Key? key, required this.model, required this.onChanged})
      : super(key: key);

  @override
  _EditableCardListState createState() => _EditableCardListState();
}

class _EditableCardListState extends State<EditableCardList> {
  late ListModel model;

  late bool editingModeMarker;

  late TextEditingController _titleEditingController,
      _subTitleEditingController;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    editingModeMarker = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: titleWidget,
      subtitle: subTitleWidget,
      trailing: trailingButton,
    );
  }

  Widget get titleWidget {
    if (editingModeMarker) {
      _titleEditingController = TextEditingController(text: model.title);
      return TextField(
        controller: _titleEditingController,
      );
    } else
      return Text(model.title);
  }

  Widget get subTitleWidget {
    if (editingModeMarker) {
      _subTitleEditingController = TextEditingController(text: model.subTitle);
      return TextField(
        controller: _subTitleEditingController,
      );
    } else
      return Text(model.subTitle);
  }

  Widget get trailingButton {
    if (editingModeMarker) {
      return IconButton(
        icon: Icon(Icons.check),
        onPressed: commitTextEdits,
      );
    } else
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: editingModeSetState,
      );
  }

  void editingModeSetState() {
    setState(() {
      editingModeMarker = !editingModeMarker;
    });
  }

  void commitTextEdits() {
    this.model.title = _titleEditingController.text;
    this.model.subTitle = _subTitleEditingController.text;
    editingModeSetState();
    if (widget.onChanged != null) {
      widget.onChanged(this.model);
    }
  }
}
