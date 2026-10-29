import 'package:flutter/material.dart';

class TaskFilter extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onChanged;

  const TaskFilter({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(child: _buildChip('all', 'Todas')),
          const SizedBox(width: 8),
          Expanded(child: _buildChip('pending', 'Pendentes')),
          const SizedBox(width: 8),
          Expanded(child: _buildChip('completed', 'Concluídas')),
        ],
      ),
    );
  }

  Widget _buildChip(String value, String label) {
    final isSelected = selectedFilter == value;

    return FilterChip(
      selected: isSelected,
      label: Center(child: Text(label)),
      showCheckmark: false,
      onSelected: (_) => onChanged(value),
    );
  }
} 
