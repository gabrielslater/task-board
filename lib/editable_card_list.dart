import 'package:flutter/material.dart';

class KanbanCard extends StatefulWidget {
  final String title;
  final String body;
  final int id;

  final Function(String title, String body, int id) onEdit;
  final Function(int id) onDelete;

  const KanbanCard({
    Key? key,
    required this.title,
    required this.body,
    required this.id,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanCardState();
}

class _KanbanCardState extends State<KanbanCard> {
  bool _isEditingText = false;
  late TextEditingController _titleEditingController;
  late TextEditingController _bodyEditingController;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget.title);
    _bodyEditingController = TextEditingController(text: widget.body);
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _bodyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              title,
              const Spacer(),
              _buildEditButton(),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
          body,
        ],
      ),
    );
  }

  Widget get title {
    if (_isEditingText) {
      return ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 200),
          child: TextField(controller: _titleEditingController));
    } else {
      return Text(
        widget.title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Widget get body {
    if (_isEditingText) {
      return TextField(controller: _bodyEditingController);
    } else {
      return Text(widget.body);
    }
  }

  Widget _buildEditButton() {
    if (_isEditingText) {
      return IconButton(
        onPressed: () {
          setState(() {
            widget.onEdit(
              _titleEditingController.text,
              _bodyEditingController.text,
              widget.id,
            );
            _isEditingText = false;
          });
        },
        icon: const Icon(Icons.check),
        color: Colors.green,
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            _isEditingText = true;
          });
        },
        icon: const Icon(Icons.edit),
        color: Colors.lightBlue,
      );
    }
  }

  void onDelete() {
    widget.onDelete(widget.id);
  }
}

// class _KanbanCardState extends State<KanbanCard> {
//   late KanbanCardModel model;
//
//   late bool _isEditing;
//
//   late TextEditingController _titleEditingController, _bodyEditingController;
//
//   @override
//   void initState() {
//     super.initState();
//     model = widget.model;
//     _titleEditingController = TextEditingController(text: model.title);
//     _bodyEditingController = TextEditingController(text: model.body);
//     _isEditing = false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(model.id);
//     return ListTile(
//       title: title,
//       subtitle: body,
//       trailing: trailingButton,
//     );
//   }
//
//   @override
//   void dispose() {
//     _titleEditingController.dispose();
//     _bodyEditingController.dispose();
//     super.dispose();
//   }
//
//   Widget get title {
//     if (_isEditing) {
//       _titleEditingController = TextEditingController(text: model.title);
//       return TextField(
//         controller: _titleEditingController,
//       );
//     } else {
//       return Text(model.title);
//     }
//   }
//
//   Widget get body {
//     if (_isEditing) {
//       _bodyEditingController = TextEditingController(text: model.body);
//       return TextField(
//         controller: _bodyEditingController,
//       );
//     } else {
//       return Text(model.body);
//     }
//   }
//
//   Widget get trailingButton {
//     if (_isEditing) {
//       return IconButton(
//         icon: const Icon(Icons.check),
//         onPressed: editText,
//       );
//     } else {
//       return Wrap(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.edit, color: Colors.green),
//             onPressed: () {
//               setState(() {
//                 _isEditing = true;
//               });
//             },
//           ),
//           // IconButton(
//           //   icon: const Icon(Icons.delete, color: Colors.red),
//           //   onPressed: deleteCard,
//           // )
//         ],
//       );
//     }
//   }
//
//   void editText() {
//     setState(() {
//       model = model
//           .updateTitle(_titleEditingController.text)
//           .updateBody(_bodyEditingController.text);
//       _isEditing = false;
//     });
//     // widget.onChanged(model, false, model.id);
//   }
//
//   void deleteCard() {
//     widget.onDelete(model);
//   }
// }
