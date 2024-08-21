import 'package:flutter/material.dart';
import 'package:fono_terapia/modules/startup/loading_view.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class SignInButton extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback onPressed;

  const SignInButton({
    required this.image,
    required this.name,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double size =
        responsiveSize.scaleSize(TextStyles.googleButton.fontSize!);

    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

      // TODO: Login into firebase
      // TODO: If login accepts, verify if it has premium to proceeds, if not navigate to goPremiumView
      onPressed: onPressed,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size * 0.1, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: size * 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: MyText(
                'Continuar com $name',
                style: TextStyles.googleButton.copyWith(
                  fontSize: size,
                  color: AppColors.darkGray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
