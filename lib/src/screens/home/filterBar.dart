import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/filterBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);

    return SliverAppBar(
      title: Row(
        children: <Widget>[
          SizedBox(width: 12),
          Icon(
            Icons.filter_list,
            color: AppColors.grey,
          ),
          SizedBox(width: 10),
          StreamBuilder<Object>(
            stream: filterBloc.filterStream,
            builder: (context, snapshot) {
              final List<String> filters = snapshot.data;
              if (filters != null && filters.length > 0) {
                return SizedBox(
                  width: 42,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FloatingActionButton(
                      key: Key("clearFilters"),
                      heroTag: "clearFilters",
                      backgroundColor: AppColors.black,
                      foregroundColor: AppColors.white,
                      mini: true,
                      elevation: 0,
                      onPressed: () {
                        print("clear filters");
                        filterBloc.clear();
                      },
                      child: Icon(Icons.clear),
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  ),
                );
              }
              return Container(width: 0);
            },
          ),
          Expanded(
            child: StreamBuilder<Object>(
                stream: filterBloc.filterStream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: filterBloc.filters.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final filter = filterBloc.filters[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: FilterChip(
                          key: Key("filter_$filter"),
                          label: Text(filter),
                          onSelected: (selected) {
                            filterBloc.toggle(filter);
                          },
                          selectedColor: AppColors.primary,
                          disabledColor: AppColors.redAccent,
                          selected: filterBloc.isSelected(filter),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
      titleSpacing: 0,
      floating: true,
      elevation: 1,
      forceElevated: true,
    );
  }
}
