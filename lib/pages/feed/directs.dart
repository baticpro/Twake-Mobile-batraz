import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twake/blocs/directs_bloc/directs_bloc.dart';
import 'package:twake/blocs/notification_bloc/notification_bloc.dart';
import 'package:twake/models/direct.dart';
import 'package:twake/pages/feed/channel_tile.dart';

class Directs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectsBloc, ChannelState>(
      buildWhen: (_, current) =>
      current is ChannelsLoading ||
          current is ChannelsLoaded ||
          current is ChannelsEmpty,
      builder: (context, state) {
        var channels = <Direct>[];
        if (state is ChannelsLoaded) {
          channels = state.channels;
        }
        return RefreshIndicator(
          onRefresh: () {
            BlocProvider.of<DirectsBloc>(context)
                .add(ReloadChannels(forceFromApi: true));
            BlocProvider.of<NotificationBloc>(context)
                .add(ReinitSubscriptions());
            return Future.delayed(Duration(seconds: 1));
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 12.0),
            itemCount: channels.length,
            itemBuilder: (context, index) {
              final channel = channels[index];
              return ChannelTile(
                id: channel.id,
                name: channel.name,
                icon: channel.icon,
                hasUnread: channel.hasUnread == 1,
                isPrivate: false,
                lastActivity: channel.lastActivity,
                lastMessage: channel.lastMessage,
                messagesUnread: channel.messagesUnread,
              );
            },
          ),
        );
      },
    );
  }
}
