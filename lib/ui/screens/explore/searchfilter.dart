import 'package:evento/core/assets/assets.dart';
import 'package:evento/ui/common/colors.dart';
import 'package:evento/ui/common/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int _selectedCategoryIndex = -1;
  int _selectedDateIndex = -1;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCategorySection(),
            const SizedBox(height: 16),
            _buildDateSection(),
            const SizedBox(height: 16),
            EventoTextField(
              hint: 'Select date',
              prefixIcon: SvgPicture.asset(Assets.calendarIcon),
              suffixIcon: SvgPicture.asset(
                Assets.arrowRightIcon,
                color: AppColor.primaryColor,
              ),
              onClickSuffixIcon: _showCalendar,
            ),
            const SizedBox(height: 16),
            _buildLocationSection(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: _resetFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppColor.primaryColor),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(color: AppColor.primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: _applyFilter,
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildCategoryItem('Music', 0),
            _buildCategoryItem('Sporting', 1),
            _buildCategoryItem('Tech', 2),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, int index) {
    bool isSelected = index == _selectedCategoryIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = isSelected ? -1 : index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Container(
          width: 75,
          height: 40,
          padding: EdgeInsets.all(8.w),
          decoration: ShapeDecoration(
            color: isSelected ? AppColor.primaryColor : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time & Date',
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildDateItem('Today', 0),
            _buildDateItem('Tomorrow', 1),
            _buildDateItem('This Week', 2),
          ],
        ),
      ],
    );
  }

  Widget _buildDateItem(String title, int index) {
    bool isSelected = index == _selectedDateIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDateIndex = isSelected ? -1 : index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Container(
          width: 75,
          height: 40,
          padding: EdgeInsets.all(8.w),
          decoration: ShapeDecoration(
            color: isSelected ? AppColor.primaryColor : Colors.transparent,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        EventoTextField(
          hint: 'Enter location',
          prefixIcon: SvgPicture.asset(
            Assets.locationIcon,
            color: AppColor.primaryColor,
          ),
          suffixIcon: SvgPicture.asset(
            Assets.arrowRightIcon,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }

  void _showCalendar() {}

  void _resetFilter() {
    setState(() {
      _selectedCategoryIndex = -1;
      _selectedDateIndex = -1;
    });
  }

  void _applyFilter() {
    Navigator.pop(context);
  }
}
