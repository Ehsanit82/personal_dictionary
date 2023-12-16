
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_dictionary/src/domain/models/file_manager.dart';
import 'package:your_dictionary/src/presentation/resources/color_manager.dart';
import 'package:your_dictionary/src/presentation/settings_page/widgets/language_mode_widget.dart';

import '../../bloc/word/word_bloc.dart';
import 'widgets/list_tile_item.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FileManager fileManager = FileManager();
  FileStorageManager fileStorageManager = FileStorageManager();
  void exportFile() {
    fileManager.exportFile(fileStorageManager).then((_) {
      if (fileManager.fileInDirectoryToSave != null) {
        context.read<WordBloc>().add(
            ExportDataEvent(exportFile: fileManager.fileInDirectoryToSave!));
      }
    });
  }

  void importFile() {
    fileManager.importFile().then((_) {
      if (fileManager.fileInDirectoryToSelect != null) {
        context
            .read<WordBloc>()
            .add(ImportDataEvent(importFile: fileManager.fileInDirectoryToSelect!));
      }
    });
  }
  // File? fileInDirectoryToSave;

  // File? fileInDirectoryToSelect;

  // String? message;

  // Future<void> selectFile() async {
  //   try {
  //     FilePickerResult? fileRes = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ["json"],
  //     );
  //     if (fileRes != null) {
  //       fileInDirectoryToSelect = File(fileRes.files.single.path!);
  //     }
  //   } catch (e) {
  //     message = "The process has encountered an error";
  //     Fluttertoast.showToast(
  //         msg: message ?? "",
  //         gravity: ToastGravity.BOTTOM,
  //         toastLength: Toast.LENGTH_LONG,
  //         backgroundColor: ColorManager.primary,
  //         fontSize: 14);
  //   }
  // }

  // Future<void> saveFile() async {
  //   try {
  //     if (await Permission.manageExternalStorage.isGranted) {
  //       Directory personalDictionaryDirectory =
  //           Directory("/storage/emulated/0/Personal Dictionary");
  //       String res = "";

  //       if (await personalDictionaryDirectory.exists()) {
  //         res = personalDictionaryDirectory.path;
  //       } else {
  //         Directory appDirectory =
  //             await personalDictionaryDirectory.create(recursive: true);
  //         res = appDirectory.path;
  //       }
  //       String filePath = '$res/data.json';

  //       int suffix = 1;
  //       while (await File(filePath).exists()) {
  //         filePath = '$res/data_$suffix.json';
  //         suffix++;
  //       }
  //       fileInDirectoryToSave = File(filePath);
  //       print("Saved at: $filePath");
  //       message = "Saved at: $filePath";
  //       Fluttertoast.showToast(
  //           msg: message ?? "",
  //           gravity: ToastGravity.BOTTOM,
  //           toastLength: Toast.LENGTH_LONG,
  //           backgroundColor: ColorManager.primary,
  //           fontSize: 14);
  //     } else {
  //       await Permission.manageExternalStorage.request();
  //     }
  //   } catch (e) {
  //     message = "The process has encountered an error";
  //     Fluttertoast.showToast(
  //         msg: message ?? "",
  //         gravity: ToastGravity.BOTTOM,
  //         toastLength: Toast.LENGTH_LONG,
  //         backgroundColor: ColorManager.primary,
  //         fontSize: 14);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.15,
                    child: AppBar(
                      backgroundColor: ColorManager.white,
                      elevation: 0,
                      leading: IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 25,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          color: ColorManager.primary,
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .15,
                    width: constraints.maxWidth,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.7,
                    width: constraints.maxWidth,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        listTileItem(
                          constraints,
                          'Language mode',
                          () {},
                          const LanguageModeWidget(),
                        ),
                        customDivider(),
                        listTileItem(
                            constraints,
                            // Item title
                            'Export words',
                            // export file function
                            exportFile,
                            const Icon(
                              Icons.file_download_outlined,
                              size: 30,
                            )),
                        customDivider(),
                        listTileItem(
                            constraints,
                            'Import words',
                           importFile,
                            const Icon(
                              Icons.file_upload_outlined,
                              size: 30,
                            )),
                      ],
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  Widget customDivider() {
    return Divider(
      color: ColorManager.grey,
      indent: 10,
      endIndent: 10,
      thickness: 1,
    );
  }
}
