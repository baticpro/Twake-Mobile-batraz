import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twake/repositories/add_channel_repository.dart';
import 'package:twake/widgets/sheets/channel_info_text_form.dart';
import 'package:twake/widgets/sheets/channel_name_container.dart';
import 'package:twake/widgets/sheets/hint_line.dart';
import 'package:twake/widgets/sheets/sheet_title_bar.dart';
import 'package:twake/blocs/add_channel_bloc.dart';

class ChannelTypeForm extends StatefulWidget {
  @override
  _ChannelTypeFormState createState() => _ChannelTypeFormState();
}

class _ChannelTypeFormState extends State<ChannelTypeForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SheetTitleBar(
          title: 'New Channel',
          leadingTitle: 'Back',
          leadingAction: () => print('BACK!'),
          trailingTitle: 'Create',
          trailingAction: () => print('CREATE!'),
        ),
        SizedBox(height: 23),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 100.0),
          child: Text(
            'CHANNEL TYPE',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ),
        SizedBox(height: 6),
        ChannelTypesContainer(
          selectedType: ChannelType.public,
        ),
        SizedBox(height: 8),
        HintLine(
          text:
              'Direct channels involve correspondence between selected members',
        ),
        // Container(
        //   padding: const EdgeInsets.only(left: 14.0, right: 7),
        //   color: Colors.white,
        //   child: ChannelInfoTextForm(
        //     hint: 'Channel description',
        //     controller: _descriptionController,
        //     focusNode: _channelDescriptionFocusNode,
        //   ),
        // ),
        SizedBox(height: 8),
        HintLine(
          text: 'Only available for direct channels',
        ),
      ],
    );
  }
}

class ChannelTypesContainer extends StatelessWidget {
  final ChannelType selectedType;

  const ChannelTypesContainer({Key key, this.selectedType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Divider(
          thickness: 0.5,
          height: 0.5,
          color: Colors.black.withOpacity(0.2),
        ),
        SelectableItem(
          title: 'Public',
          selected: selectedType == ChannelType.public,
          onTap: () => print('select public'),
        ),
        SelectableItem(
          title: 'Private',
          selected: selectedType == ChannelType.private,
          onTap: () => print('select private'),
        ),
        SelectableItem(
          title: 'Direct',
          selected: selectedType == ChannelType.direct,
          onTap: () => print('select direct'),
        ),
      ],
    );
  }
}

class SelectableItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onTap;

  const SelectableItem({
    Key key,
    @required this.title,
    @required this.selected,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.0,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  if (selected)
                    Icon(
                      CupertinoIcons.check_mark,
                      color: Color(0xff837cfe),
                    ),
                ],
              ),
            ),
            Divider(
              indent: 15.0,
              thickness: 0.5,
              height: 0.5,
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
