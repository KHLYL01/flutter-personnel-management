import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../constants/app_colors.dart';

PlutoGridConfiguration getPlutoConfig() {
  return PlutoGridConfiguration(
    columnSize: const PlutoGridColumnSizeConfig(
      autoSizeMode: PlutoAutoSizeMode.scale,
    ),
    style: PlutoGridStyleConfig(
      rowHeight: 20,
      columnHeight: 30,
      activatedBorderColor: AppColors.greyLight,
      gridBackgroundColor: Colors.white,
      gridBorderColor: AppColors.greyLight,
      gridBorderRadius: BorderRadius.circular(9),
      gridPopupBorderRadius: BorderRadius.circular(9),
    ),
    enableMoveDownAfterSelecting: false,
  );
}
