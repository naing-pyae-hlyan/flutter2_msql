import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter2_mysql/models/user_model.dart';
import 'package:flutter2_mysql/view/widget/common_button.dart';
import 'package:flutter2_mysql/view/widget/text_utils.dart';

Future<void> openCrudDialog(
  BuildContext context, {
  UserModel data,
  @required ValueChanged<UserModel> saveOnPressed,
}) async {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: CrudDialog(
          data: data,
          saveOnPressed: saveOnPressed,
        ),
      ),
    );
  });
}

class CrudDialog extends StatefulWidget {
  const CrudDialog({this.data, this.saveOnPressed});

  final UserModel data;
  final ValueChanged<UserModel> saveOnPressed;

  @override
  _CrudDialogState createState() => _CrudDialogState();
}

class _CrudDialogState extends State<CrudDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final FocusNode _nameFn = FocusNode();
  final FocusNode _emailFn = FocusNode();
  final FocusNode _ageFn = FocusNode();

  @override
  void initState() {
    if (widget.data != null) {
      _nameController.text = widget.data.name;
      _emailController.text = widget.data.email;
      _ageController.text = widget.data.age;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _nameFn.dispose();
    _emailFn.dispose();
    _ageFn.dispose();
    super.dispose();
  }

  void _saveUser() {
    if (_nameController.text.isEmpty) {
      _nameFn.requestFocus();
      return;
    } else if (_emailController.text.isEmpty) {
      _emailFn.requestFocus();
      return;
    } else if (_ageController.text.isEmpty) {
      _ageFn.requestFocus();
      return;
    }

    Navigator.pop(context);

    widget.saveOnPressed.call(
      new UserModel(
        _nameController.text,
        _emailController.text,
        _ageController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextUtils.headerText('CRUD'),
          SizedBox(height: 16),
          _inputForm(
            controller: _nameController,
            fn: _nameFn,
            hint: 'Name',
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
          ),
          SizedBox(height: 8),
          _inputForm(
            controller: _emailController,
            fn: _emailFn,
            hint: 'Email',
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(height: 8),
          _inputForm(
            controller: _ageController,
            fn: _ageFn,
            hint: 'Age',
            inputAction: TextInputAction.done,
            inputType: TextInputType.number,
          ),
          SizedBox(height: 16),
          _rowButton,
        ],
      ),
    );
  }

  Widget _inputForm({
    @required TextEditingController controller,
    @required FocusNode fn,
    @required String hint,
    @required TextInputAction inputAction,
    @required TextInputType inputType,
  }) {
    return TextField(
      controller: controller,
      focusNode: fn,
      textInputAction: inputAction,
      keyboardType: inputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hint,
      ),
    );
  }

  Widget get _rowButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        MyButton(
          'Cancel',
          color: Colors.grey,
          onPressed: () => Navigator.pop(context),
        ),
        MyButton(
          'Save',
          onPressed: () => _saveUser(),
        ),
      ],
    );
  }
}
