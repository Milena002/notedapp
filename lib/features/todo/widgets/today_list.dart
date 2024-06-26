import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/models/task.dart';
import 'package:notedapp/features/todo/controllers/todo/todo_notifier.dart';
import 'package:notedapp/features/todo/controllers/todo/todo_provider.dart';
import 'package:notedapp/features/todo/pages/update.dart';
import 'package:notedapp/common/widgets/todo_tile.dart';
import 'package:notedapp/common/utils/constants.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todosNotifierProvider);
    var today = ref.read(todosNotifierProvider.notifier).getToday();
    var pending = listData
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();

    
    return ListView.builder(
        itemCount: pending.length,
        itemBuilder: (context, index) {
          final data = pending[index];
          bool isCompleted = ref.read(todosNotifierProvider.notifier).getStatus(data);
          dynamic color = ref.read(todosNotifierProvider.notifier).getRandomColour();

          return TodoTile(
            title: data.title,
            color: color,
            description: data.desc,
            start: data.startTime,
            end: data.endTime,
             editIcon: GestureDetector(
                  onTap: () {
                    updateDescription = data.desc.toString();
                    updateTitle = data.title.toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Update(
                                  data: data,
                                )));
                  },
                  child:
                      const Icon(MaterialCommunityIcons.circle_edit_outline)),
            delete: () =>
                ref.watch(todosNotifierProvider.notifier).deleteTodos(data.id ?? 0),
            child: Switch(
              value: isCompleted,
              activeColor: AppConst.kLightGreen,
              inactiveTrackColor: AppConst.kmediumGrey,
              inactiveThumbColor: AppConst.kDarkGrey,
              onChanged: (value) {
                ref.read(todosNotifierProvider.notifier).markAsCompleted(
                      data.id ?? 0,
                      data.title.toString(),
                      data.desc.toString(),
                      data.date.toString(),
                      data.startTime.toString(),
                      data.endTime.toString(),
                    );
              },
            ),
          );
        });
  }
}

