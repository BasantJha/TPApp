import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DisableShortcut extends StatelessWidget {
  final Widget child;

  const DisableShortcut({
    Key? key,
     required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: {
        selectableKeySetwindows: SelectionIntent(),
        pasteKeySetwindows: PasteIntent(),
        copyKeySetwindows: CopyIntent(),

      },
      actions: {
        SelectionIntent: CallbackAction(
          onInvoke: (intent) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Selection not allowed")));
            return FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
        PasteIntent: CallbackAction(
          onInvoke: (intent) async {
            // ClipboardData? data = await Clipboard.getData('text/plain');
            // //print(" paste callBack ${data!.text}");
            return ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Paste not allowed")));
          },
        ),

        CopyIntent: CallbackAction(
          onInvoke: (intent) async {
            // ClipboardData? data = await Clipboard.getData('text/plain');
            // //print(" paste callBack ${data!.text}");
            return ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Copy not allowed")));
          },
        )

      },
      autofocus: false,
      child: child,
    );
  }
}

class SelectionIntent extends Intent {}

class PasteIntent extends Intent {}

class CopyIntent extends Intent {}

///* for mac replace  LogicalKeyboardKey.control, with LogicalKeyboardKey.meta
final selectableKeySetwindows = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.keyA,
);
final pasteKeySetwindows = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.keyV,
);

final copyKeySetwindows = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.keyC,
);

/// i dont have any ios device 😅,let me know what it produce.
final selectableKeySetMac = LogicalKeySet(
  LogicalKeyboardKey.meta,
  LogicalKeyboardKey.keyA,
);