import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view_model/recorridos_mantenimiento_view_model.dart';
import 'package:form_without_internet/types/status_recorrido_sucursal_type.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterStatusSucursalComponent extends ConsumerWidget {
  const FilterStatusSucursalComponent({super.key});

  static const style = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const todos = StatusRecorridoSucursalType.todos;
    final Set<StatusRecorridoSucursalType> selected = {
      ref.watch(
        recorridosMantenimientoViewModelProvider.select(
          (value) => value.filtersSucursales.filterStatusSucursal,
        ),
      )
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Filtrar por estado',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),
        ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStateProperty.resolveWith(
              (states) {
                if (selected.first == todos) {
                  return 0;
                }
                return 2;
              },
            ),
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) {
                if (selected.first == todos) {
                  return todos.color.withOpacity(0.2);
                }
                return Colors.white;
              },
            ),
          ),
          onPressed: () {
            ref
                .read(recorridosMantenimientoViewModelProvider.notifier)
                .filterStatusRecorridoSucursal(todos);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                todos.icon,
                color: todos.color,
              ),
              const Gap(10),
              Text(
                todos.value,
                style: style.copyWith(color: todos.color),
              ),
            ],
          ),
        ),
        const Gap(5),
        SegmentedButton(
            selected: selected,
            onSelectionChanged: (value) {
              final data = value.first;
              ref
                  .read(recorridosMantenimientoViewModelProvider.notifier)
                  .filterStatusRecorridoSucursal(data);
            },
            showSelectedIcon: false,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.selected)) {
                    return selected.first.color.withOpacity(0.2);
                  }
                  return Colors.white;
                },
              ),
            ),
            segments: [
              for (int i = 1; i < StatusRecorridoSucursalType.values.length; i++)
                ButtonSegment(
                  value: StatusRecorridoSucursalType.values[i],
                  icon: Icon(
                    StatusRecorridoSucursalType.values[i].icon,
                    color: StatusRecorridoSucursalType.values[i].color,
                  ),
                  label: Text(
                    StatusRecorridoSucursalType.values[i].value,
                    style: style.copyWith(
                      color: StatusRecorridoSucursalType.values[i].color,
                    ),
                  ),
                )
            ]),
      ],
    );
  }
}
