import 'package:get/get.dart';
import 'package:twake/blocs/channels_cubit/channels_cubit.dart';
import 'package:twake/di/add_channel_binding.dart';
import 'package:twake/pages/account/account_info.dart';
import 'package:twake/pages/account/account_settings.dart';
import 'package:twake/pages/channel/new_channel/new_channel_widget.dart';
import 'package:twake/pages/chat/chat.dart';
import 'package:twake/pages/initial_page.dart';
import 'package:twake/pages/thread_page.dart';
import 'package:twake/routing/route_paths.dart';

final routePages = [
  GetPage(
    name: RoutePaths.initial,
    page: () => InitialPage(),
    children: [
      GetPage(
        name: RoutePaths.channelMessages.name,
        page: () => Chat<ChannelsCubit>(),
        transition: Transition.native,
      ),
      GetPage(
        name: RoutePaths.newChannel.name,
        page: () => NewChannelWidget(),
        transition: Transition.native,
        binding: AddChannelBinding()
      ),
      GetPage(
        name: RoutePaths.directMessages.name,
        page: () => Chat<DirectsCubit>(),
        transition: Transition.native,
      ),
      GetPage(
        name: RoutePaths.messageThread.name,
        page: () => ThreadPage<ChannelsCubit>(),
        transition: Transition.native,
      ),
      GetPage(
        name: RoutePaths.accountSettings.name,
        page: () => AccountSettings(),
        transition: Transition.native,
      ),
      GetPage(
        name: RoutePaths.accountInfo.name,
        page: () => AccountInfo(),
        transition: Transition.native,
      ),
    ],
  ),
];
