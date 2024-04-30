import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notedapp/common/helpers/notification_helper.dart';
import 'package:notedapp/common/utils/constants.dart';
import 'package:notedapp/common/widgets/appstyle.dart';
import 'package:notedapp/common/widgets/custom_textfield.dart';
import 'package:notedapp/common/widgets/height_spacer.dart';
import 'package:notedapp/common/widgets/reusable_text.dart';
import 'package:notedapp/common/widgets/width_spacer.dart';
import 'package:notedapp/features/auth/controllers/user_state.dart';
import 'package:notedapp/features/onboarding/pages/onboarding.dart';
import 'package:notedapp/features/todo/controllers/todo/todo_notifier.dart';
import 'package:notedapp/features/todo/pages/add.dart';
import 'package:notedapp/features/todo/widgets/completed_list.dart';
import 'package:notedapp/features/todo/widgets/after_tomorrow.dart';
import 'package:notedapp/features/todo/widgets/today_list.dart';
import 'package:notedapp/features/todo/widgets/tomorrow_list.dart';
import 'package:notedapp/main.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController = TabController(
    length: 2,
    vsync: this,
  );

  late NotificationsHelper controller;
  late var notifyHelper;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      controller = NotificationsHelper(ref: ref);
    });

    notifyHelper = NotificationsHelper(ref: ref);

    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(userProvider.notifier).logout(1);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnBoarding()),
                                (route)=> false);
                      },
                      child: const RotatedBox(
                          quarterTurns: 2, child: Icon(AntDesign.logout)),
                    ),
                    ReusableText(
                        text: "Dashboard ",
                        style: appstyle(20, AppConst.kZomp, FontWeight.bold)),
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: const BoxDecoration(
                        color: AppConst.kLightGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddTask()));
                        },
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: AppConst.kCharcoal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                  hintStyle: appstyle(16, AppConst.kCharcoal, FontWeight.w600),
                  prefixIcon: Container(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                        
                        },
                        child: const Icon(
                          AntDesign.search1,
                          color: AppConst.kCharcoal,
                        ),
                      )),
                  suffixIcon: const Icon(FontAwesome.lightbulb_o,
                      color: AppConst.kCharcoal),
                  keyboard: TextInputType.phone,
                  hintText: "Search",
                  controller: search),
              const HeightSpacer(height: 15),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer(
            builder: (context, ref, child) {
              ref.watch(todosNotifierProvider.notifier).refresh();
              return ListView(
                children: [
                  const HeightSpacer(height: 25),
                  Row(
                    children: [
                      const Icon(
                        FontAwesome.tasks,
                        size: 20,
                        color: AppConst.kZomp,
                      ),
                      const WidthSpacer(wydth: 10),
                      ReusableText(
                          text: "Today's Tasks:",
                          style:
                              appstyle(18, AppConst.kZomp, FontWeight.bold)),
                    ],
                  ),
                  const HeightSpacer(height: 25),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppConst.kZomp,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: const BoxDecoration(
                          color: AppConst.kLightGreen,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        controller: tabController,
                        labelPadding: EdgeInsets.zero,
                        isScrollable: false,
                        labelColor: AppConst.kZomp,
                        labelStyle:
                            appstyle(24, AppConst.kZomp, FontWeight.w700),
                        unselectedLabelColor: AppConst.kAntiqueWhite,
                        tabs: [
                          Tab(
                            child: SizedBox(
                              width: AppConst.kWidth * 0.5,
                              child: Center(
                                child: ReusableText(
                                    text: "Pending",
                                    style: appstyle(
                                        16,
                                        AppConst.kDarkGrey,
                                        FontWeight.bold)),
                              ),
                            ),
                          ),
                          Tab(
                              child: Container(
                            padding: EdgeInsets.only(left: 30.h),
                            width: AppConst.kWidth * 0.5,
                            child: ReusableText(
                                text: "Completed",
                                style: appstyle(16, AppConst.kDarkGrey,
                                    FontWeight.bold)),
                          ))
                        ]),
                  ),
                  const HeightSpacer(height: 20),
                  SizedBox(
                    height: AppConst.kHeight * 0.26,
                    width: AppConst.kWidth,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: TabBarView(controller: tabController, children: [
                        Container(
                          color: AppConst.kGrey,
                          height: AppConst.kHeight * 0.3,
                          child: const TodoListView(),
                        ),
                        Container(
                          color: AppConst.kveryLightGreen,
                          height: AppConst.kHeight * 0.3,
                          child: const CompletedListView(),
                        ),
                      ]),
                    ),
                  ),
                  const HeightSpacer(height: 20),
                  const TomorrowList(),
                  const HeightSpacer(height: 20),
                  const DayAfterTomorrow()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
