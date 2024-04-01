import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_texi_app/models/message_model.dart';
import 'package:new_texi_app/models/my_variables.dart';
import 'package:provider/provider.dart';

import '../../view-models/on_image_select_view_model.dart';

class OnImageSelectView extends StatelessWidget {
  const OnImageSelectView(
      {super.key, required this.imageUrl, required this.messageModel});
  final String imageUrl;
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnImageSelectViewModel(),
      child: Consumer<OnImageSelectViewModel>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    )
                  : Stack(
                      children: [
                        Container(
                          height: MyVariables.height(context),
                          width: MyVariables.width(context),
                          color: Colors.black,
                          child: Image.file(
                            File(imageUrl),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5),
                              child: Icon(Icons.close,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                log("provider.isLoading: ${provider.isLoading}");
                if (provider.isLoading == false) {
                  log("provider.isLoading: ${provider.isLoading}");
                  provider.sendImage(
                      messageModel: messageModel,
                      context: context,
                      imageUrl: imageUrl);
                }
              },
              child: const Icon(
                Icons.send,
              ),
            ),
          );
        },
      ),
    );
  }
}
