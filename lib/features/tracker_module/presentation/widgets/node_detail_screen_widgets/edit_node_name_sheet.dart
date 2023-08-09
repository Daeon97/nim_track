// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_name_bloc/tracker_module_name_bloc.dart';

class EditNodeNameSheet extends StatefulWidget {
  const EditNodeNameSheet({
    required this.id,
    this.name,
    super.key,
  });

  final int id;
  final String? name;

  @override
  State<EditNodeNameSheet> createState() => _EditNodeNameSheetState();
}

class _EditNodeNameSheetState extends State<EditNodeNameSheet> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nodeNameController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nodeNameController = TextEditingController(
      text: widget.name,
    );
    super.initState();
  }

  @override
  void dispose() {
    _nodeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.all(
            spacing,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ),
              const SizedBox(
                height: spacing,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nodeNameController,
                      keyboardType: TextInputType.text,
                      keyboardAppearance: switch (context
                          .read<ThemeBloc>()
                          .state
                          .themeEntity
                          .fakeBrightness) {
                        enums.Brightness.light => Brightness.light,
                        enums.Brightness.dark => Brightness.dark
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: nodeNameLiteral,
                        errorMaxLines: tinySpacing.toInt(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return enterValidNameLiteral;
                        } else if (widget.name != null &&
                            value == widget.name) {
                          return enterDifferentNameLiteral;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: spacing,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<TrackerModuleNameBloc>().add(
                                UpdateTrackerModuleNameEvent(
                                  id: widget.id,
                                  name: _nodeNameController.text,
                                ),
                              );
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Center(
                        child: Text(
                          okayLiteral,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
