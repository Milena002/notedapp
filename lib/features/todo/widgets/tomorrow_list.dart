import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/xpansion_tile.dart';
import 'package:notedapp/features/todo/controllers/todo/todo_notifier.dart';
import 'package:notedapp/features/todo/controllers/xpansion_provider.dart';
import 'package:notedapp/features/todo/pages/update.dart';
import 'package:notedapp/common/widgets/todo_tile.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosNotifierProvider);
    String tomorrow = ref
        .read(todosNotifierProvider.notifier)
        .getTomorrow()
        .toString()
        .substring(0, 10);
    var tommorrowTodos =
        todos.where((element) => element.date!.contains(tomorrow));
    dynamic color = ref.read(todosNotifierProvider.notifier).getRandomColour();
    return XpansionTile(
      text: "Tomorrow Tasks",
      text2: "Tomorrow tasks are shown here",
      onExpansionChanged: (bool expanded) {
        ref.read(xpansionStateProvider.notifier).changeState(expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.0.w),
        child: ref.watch(xpansionStateProvider)
            ? const Icon(AntDesign.closecircleo, color: AppConst.kDarkGrey)
            : const Icon(AntDesign.circledown, color: AppConst.kDarkGrey),
      ),
      children: [
        for (final todo in tommorrowTodos)
          TodoTile(
              title: todo.title,
              description: todo.desc,
              color: color,
              start: todo.startTime,
              end: todo.endTime,
              editIcon: GestureDetector(
                
                  onTap: () {
                    updateDescription = todo.desc.toString();
                    updateTitle = todo.title.toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Update(
                                  data: todo,
                                )));
                  },
                  child:
                      const Icon(MaterialCommunityIcons.circle_edit_outline)),
              delete: () =>
                  ref.watch(todosNotifierProvider.notifier).deleteTodos(todo.id ?? 0),
              child: const SizedBox.shrink())
      ],
    );
  }
}
