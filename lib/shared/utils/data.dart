import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/model/menu_option.dart';
import 'package:fono_terapia/shared/themes/app_images.dart';

class MenuCategory {
  final String title;
  final List<MenuOption> options;

  MenuCategory(this.title, this.options);
}

List<MenuCategory> buildMenuOptionsList(BuildContext context) {
  return [
    MenuCategory(
      "Compreensão Auditiva",
      [
        MenuOption(
          description: "Ouvir e escolher a palavra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 0),
        ),
        MenuOption(
          description: "Ouvir e escolher a imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 1),
        ),
        MenuOption(
          description: "Ouvir e escolher a letra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 2),
        ),
        MenuOption(
          description: "Ouvir e escrever a palavra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 3),
        ),
      ],
    ),
    MenuCategory(
      "Compreensão Escrita",
      [
        MenuOption(
          description: "Ler e escolher a imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 0),
        ),
        MenuOption(
          description: "Ver e escolher a palavra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 1),
        ),
        MenuOption(
          description: "Emparelhar maiúsculas e minúsculas",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 2),
        ),
        MenuOption(
          description: "Ler e responder sim ou não",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 3),
        ),
        MenuOption(
          description: "Ouvir e escolher a letra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 4),
        ),
        MenuOption(
          description: "Ouvir e escolher a palavra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 5),
        ),
      ],
    ),
    MenuCategory(
      "Escrita",
      [
        MenuOption(
          description: "Escrever o nome da imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 0),
        ),
        MenuOption(
          description: "Ouvir e escrever a palavra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 1),
        ),
        MenuOption(
          description: "Escrever a letra ditada",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 2),
        ),
      ],
    ),
    MenuCategory(
      "Nomeação",
      [
        MenuOption(
          description: "Nomeação oral",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 0),
        ),
        MenuOption(
          description: "Repetição",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 1),
        ),
        MenuOption(
          description: "Escrever o nome da imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 2),
        ),
      ],
    ),
  ];
}

void navigateToGame(BuildContext context, int code) {
  Navigator.pushNamed(context, '/game', arguments: code);
}
