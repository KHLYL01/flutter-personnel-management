import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/custom_styles.dart';
import 'custom_button.dart';
import 'custom_text_feild.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({
    super.key,
    required this.columns,
    required this.rows,
    // required this.onTapDelete,
  });

  final List<String> columns;
  final List<DataRow> rows;
  // final VoidCallback? onTapDelete;

  void showEditDialog(BuildContext context, List<dynamic> rowData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تحديث البيانات'),
          content: Column(
            children: List.generate(
              rowData.length,
              (index) {
                var controller =
                    TextEditingController(text: rowData[index].toString());
                return CustomTextField(
                    customWidth: 225,
                    customHeight: 35,
                    label: columns[index],
                    controller: controller);
              },
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: 'حفظ',
                  onPressed: () {},
                  height: 35,
                  width: 70,
                ),
                CustomButton(
                  text: 'الغاء',
                  onPressed: () {
                    Get.back();
                  },
                  height: 35,
                  width: 70,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        border: TableBorder(
          top: tableBorderSide(2, AppColors.black),
          left: tableBorderSide(2, AppColors.black),
          right: tableBorderSide(2, AppColors.black),
          bottom: tableBorderSide(2, AppColors.black),
          verticalInside: tableBorderSide(2, AppColors.tableBorderColor),
          horizontalInside: tableBorderSide(2, AppColors.tableBorderColor),
        ),
        headingRowColor: MaterialStateProperty.all(AppColors.grey),
        columns: [
          const DataColumn(label: Text('العمليات')),
          ...columns.map(
            (column) => DataColumn(
              label: Expanded(child: Text(column)),
            ),
          ),
        ],
        rows: rows,
      ),
    );
  }
}
