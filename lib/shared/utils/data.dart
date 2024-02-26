import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/model/menu_option.dart';
import 'package:fono_terapia/shared/themes/app_images.dart';

class MenuCategory {
  final String title;
  final List<MenuOption> options;

  MenuCategory(this.title, this.options);
}

const String aboutUs = """Fonoaudióloga há mais de 20 anos, atuando na reabilitação de adultos com Afasia, Demências, Disartria, Apraxia e Disfagia. Durante minha trajetória profissional, sempre percebi a carência de recursos adequados para estimular a linguagem em adultos. Motivada por essa lacuna, surgiu a ideia de desenvolver o aplicativo FonoTerapia, concebido como uma ferramenta destinada aos fonoaudiólogos que trabalham na reabilitação de adultos.\n
Além de minha vasta experiência clínica, atualmente sou doutoranda na UNIFESP - Baixada Santista em Ciências da Saúde. Possuo graduação em Fonoaudiologia pela UNIFESP (2002), especialização em Linguagem do Adulto e do Idoso pela USP (2003) e mestrado em Interdisciplinar em Ciências da Saúde pela UNIFESP (2020).""";

const String contacts = """Instagram: @Fono.jugonzalez
Email: gonzalezdiazjuliana@gmail.com
Telefone(Whatsapp): (13) 98143-0426""";

const String contactsDev = """Guilherme Garcia
Email: gui123.garcia@gmail.com
Telefone(Whatsapp): (11) 97262-2224""";

List<MenuCategory> buildMenuOptionsList(BuildContext context) {
  return [
    MenuCategory(
      "Compreensão Auditiva",
      [
        MenuOption(
          description: "Ouvir e escolher a imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 0),
        ),
        MenuOption(
          description: "Ler e responder sim ou não",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 1),
        ),
        MenuOption(
          description: "Pares Mínimos: Ouvir e escolher a imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 2),
        ),
        MenuOption(
          description: "Sentenças: Ouvir e escolher a imagem",
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
          description: "Ver a imagem e escolher a palavra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 1),
        ),
        MenuOption(
          description: "Ler e responder sim ou não",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 2),
        ),
        MenuOption(
          description: "Ouvir e escolher a palavra",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 3),
        ),
      ],
    ),
    MenuCategory(
      "Nomeação Oral",
      [
        MenuOption(
          description: "Falar o nome da imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 0),
        ),
        MenuOption(
          description: "Sentenças: Descrever imagem",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 1),
        ),
        MenuOption(
          description: "Repetição de palavras",
          imagePath: AppImages.logomini,
          onTap: () => navigateToGame(context, 2),
        ),
      ],
    ),
    MenuCategory(
      "Nomeação Escrita",
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
          description: "Ouvir e escrever a letra",
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
