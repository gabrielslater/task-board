import 'package:flutter/material.dart';

import 'kanban_card.dart';

class KanbanCard extends StatefulWidget {
  final KanbanCardModel model;
  final Function(KanbanCardModel kanbanCardModel) onDelete;

  const KanbanCard(ListTile listTile,
      {Key? key, required this.model, required this.onDelete})
      : super(key: key);

  @override
  State<KanbanCard> createState() => _KanbanCardState();
}

class _KanbanCardState extends State<KanbanCard> {
  late KanbanCardModel model;

  late bool _isEditing;

  late TextEditingController _titleEditingController, _bodyEditingController;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    _titleEditingController = TextEditingController(text: model.title);
    _bodyEditingController = TextEditingController(text: model.body);
    _isEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    print(model.id);
    return ListTile(
      title: title,
      subtitle: body,
      trailing: trailingButton,
    );
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _bodyEditingController.dispose();
    super.dispose();
  }

  Widget get title {
    if (_isEditing) {
      _titleEditingController = TextEditingController(text: model.title);
      return TextField(
        controller: _titleEditingController,
      );
    } else {
      return Text(model.title);
    }
  }

  Widget get body {
    if (_isEditing) {
      _bodyEditingController = TextEditingController(text: model.body);
      return TextField(
        controller: _bodyEditingController,
      );
    } else {
      return Text(model.body);
    }
  }

  Widget get trailingButton {
    if (_isEditing) {
      return IconButton(
        icon: const Icon(Icons.check),
        onPressed: editText,
      );
    } else {
      return Wrap(
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.delete, color: Colors.red),
          //   onPressed: deleteCard,
          // )
        ],
      );
    }
  }

  void editText() {
    setState(() {
      model = model
          .updateTitle(_titleEditingController.text)
          .updateBody(_bodyEditingController.text);
      _isEditing = false;
    });
    // widget.onChanged(model, false, model.id);
  }

  void deleteCard() {
    widget.onDelete(model);
  }
}
