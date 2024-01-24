import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/model/menu_option.dart';
import 'package:fono_terapia/shared/themes/app_images.dart';

List<String> menuTitles = [
  "Compreensão Auditiva",
  "Compreensão Escrita",
  "Escrita",
  "Nomeação",
];



List<List<MenuOption>> buildMenuOptionsList(BuildContext context) {
  return [
    [
      MenuOption(
        description: "Ouvir e escolher a palavra",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 0),
      ),
      MenuOption(
        description: "Ouvir e escolher a imagem",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 1),
      ),
      MenuOption(
        description: "Ouvir e escolher a letra",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 2),
      ),
      MenuOption(
        description: "Ouvir e escrever a palavra",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 3),
      ),
    ],

    [
      MenuOption(
        description: "Ler e escolher a imagem",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 0),
      ),
      MenuOption(
        description: "Ver e escolher a palavra",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 1),
      ),
      MenuOption(
        description: "Emparelhar maiúsculas e minúsculas",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 2),
      ),
      MenuOption(
        description: "Ler e responder sim ou não",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 3),
      ),
      MenuOption(
        description: "Ouvir e escolher a letra",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 4),
      ),
      MenuOption(
        description: "Ouvir e escolher a palavra",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 5),
      ),
    ],

    [
      MenuOption(
        description: "Escrever o nome da imagem",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 0),
      ),
      MenuOption(
        description: "Ouvir e escrever a palavra",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 1),
      ),
      MenuOption(
        description: "Escrever a letra ditada",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 2),
      ),
    ],

    [
      MenuOption(
        description: "Nomeação oral",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 0),
      ),
      MenuOption(
        description: "Escrever o nome da imagem",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 1),
      ),
      MenuOption(
        description: "Repetição",
        imagePath: AppImages.logomini,
        onTap: () => Navigator.pushNamed(context, '/game', arguments: 2),
      ),
    ],
  ];
}
