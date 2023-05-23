import 'package:advanced_project/SizeCalc.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dropdown_button extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit,TeamStates>(builder: (context,state){
      var cubit=TeamCubit.get(context);
      return Container(
        height: getHeight(context, 50),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5)
        ),
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Team Ctegory',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: cubit.category
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            value: cubit.selectedValue,
            onChanged: (value) {
             cubit.SelectValue(value);
            },
            buttonStyleData:  ButtonStyleData(
              height: getHeight(context, 60),

            ),
            dropdownStyleData:  DropdownStyleData(
              maxHeight: getHeight(context, 400),
            ),
            menuItemStyleData:  MenuItemStyleData(
              height: getHeight(context, 50),
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: cubit.teamDropDownListController,
              searchInnerWidgetHeight: getHeight(context, 50),
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: cubit.teamDropDownListController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an category...',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (item.value.toString().contains(searchValue));
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                cubit.teamDropDownListController.clear();
              }
            },
          ),
        ),
      );
    },
        listener: (context,state){}) ;
  }
}
