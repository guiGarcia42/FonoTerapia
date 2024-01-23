import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final titleHome = GoogleFonts.lexendDeca(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGray,
  );
  static final title = GoogleFonts.lexendDeca(
    fontSize: 35,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
  static final buttonText = GoogleFonts.lexendDeca(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
  );
  static final buttonDescription = GoogleFonts.lexendDeca(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.darkGray,
  );
  static final textRegular = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGray,
  );
  static final menuOptionDescription = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGray,
  );

}