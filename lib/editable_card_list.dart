import 'package:flutter/material.dart';

import 'kanban_card.dart';

class EditableCardList extends StatefulWidget {
  final KanbanCardModel model;
  final Function(KanbanCardModel kanbanCardModel) onChanged;

  const EditableCardList(ListTile listTile,
      {Key? key, required this.model, required this.onChanged})
      : super(key: key);

  @override
  State<EditableCardList> createState() => _EditableCardListState();
}

class _EditableCardListState extends State<EditableCardList> {
  late KanbanCardModel model;

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
    } else {
      return Text(model.title);
    }
  }

  Widget get subTitleWidget {
    if (editingModeMarker) {
      _subTitleEditingController = TextEditingController(text: model.body);
      return TextField(
        controller: _subTitleEditingController,
      );
    } else {
      return Text(model.body);
    }
  }

  Widget get trailingButton {
    if (editingModeMarker) {
      return IconButton(
        icon: const Icon(Icons.check),
        onPressed: commitTextEdits,
      );
    } else {
      return Wrap(
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: editingModeSetState,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: deleteCard,
          )
        ],
      );
    }
  }

  void editingModeSetState() {
    setState(() {
      editingModeMarker = !editingModeMarker;
    });
  }

  void commitTextEdits() {
    model = model
        .updateTitle(_titleEditingController.text)
        .updateBody(_subTitleEditingController.text);
    // model.title = _titleEditingController.text;
    // model.body = _subTitleEditingController.text;
    editingModeSetState();
    widget.onChanged(model);
  }

  void deleteCard() {
    _titleEditingController.clear();
    _subTitleEditingController.clear();
    widget.onChanged(model);
  }
}
