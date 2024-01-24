import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:fono_terapia/shared/themes/app_images.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.30,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Image.asset(
                  AppImages.logoSobre,
                  height: size.height * 0.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:EdgeInsets.symmetric(
                  horizontal: size.width * 0.035, vertical: size.height * 0.025),
              child: SingleChildScrollView(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dictum volutpat nulla, non semper nibh sodales ac. Aenean gravida dui consequat urna vulputate sagittis. Curabitur id tincidunt lacus, sit amet eleifend nibh. Nulla nibh nisl, lacinia nec ex sit amet, imperdiet ultrices odio. In hac habitasse platea dictumst. Nam sagittis ante a neque faucibus aliquet. Sed a nunc vel ligula eleifend aliquam. Suspendisse metus lectus, ultrices nec elementum semper, vehicula ut metus. Etiam tristique pharetra mauris. Praesent tempus interdum nisl, quis faucibus erat vulputate eu. Sed eget arcu faucibus, aliquet ipsum ut, pretium lorem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas dictum volutpat nulla, non semper nibh sodales ac. Aenean gravida dui consequat urna vulputate sagittis. Curabitur id tincidunt lacus, sit amet eleifend nibh. Nulla nibh nisl, lacinia nec ex sit amet, imperdiet ultrices odio. In hac habitasse platea dictumst. Nam sagittis ante a neque faucibus aliquet. Sed a nunc vel ligula eleifend aliquam. Suspendisse metus lectus, ultrices nec elementum semper, vehicula ut metus. Etiam tristique pharetra mauris. Praesent tempus interdum nisl, quis faucibus erat vulputate eu. Sed eget arcu faucibus, aliquet ipsum ut, pretium lorem.",
                  style: TextStyles.textRegular,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: ElevatedTextButton(
              size: size,
              text: "Voltar",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
