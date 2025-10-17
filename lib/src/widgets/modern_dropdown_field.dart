import 'package:flutter/material.dart';

class DropdownItem<T> {
  const DropdownItem({
    required this.value,
    required this.label,
    this.description,
    this.icon,
  });

  final T value;
  final String label;
  final String? description;
  final IconData? icon;
}

class ModernDropdownField<T> extends StatefulWidget {
  const ModernDropdownField({
    super.key,
    this.value,
    this.label,
    this.hint,
    this.prefixIcon,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  final T? value;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final List<DropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;

  @override
  State<ModernDropdownField<T>> createState() => _ModernDropdownFieldState<T>();
}

class _ModernDropdownFieldState<T> extends State<ModernDropdownField<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconRotation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconRotation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (FormFieldState<T> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.enabled
                    ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3)
                    : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: field.hasError
                      ? Theme.of(context).colorScheme.error
                      : _isExpanded
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  width: _isExpanded ? 2 : 1,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: DropdownButtonFormField<T>(
                  value: widget.value,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    hintText: widget.hint,
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(
                      widget.prefixIcon,
                      color: _isExpanded
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    )
                        : null,
                    suffixIcon: AnimatedBuilder(
                      animation: _iconRotation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _iconRotation.value * 3.14159,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: _isExpanded
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    errorStyle: const TextStyle(height: 0),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.enabled
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).disabledColor,
                  ),
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  isExpanded: true,
                  icon: const SizedBox.shrink(),
                  // Add menuMaxHeight to prevent overflow
                  menuMaxHeight: 300,
                  items: widget.items.map((item) {
                    return DropdownMenuItem<T>(
                      value: item.value,
                      child: IntrinsicHeight(
                        child: _buildDropdownItem(item),
                      ),
                    );
                  }).toList(),
                  onChanged: widget.enabled
                      ? (value) {
                    setState(() {
                      _isExpanded = false;
                    });
                    _animationController.reverse();
                    field.didChange(value);
                    widget.onChanged?.call(value);
                  }
                      : null,
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                    _animationController.forward();
                  },
                ),
              ),
            ),
            // Error message is rendered below the dropdown, never inside a dropdown menu item.
            if (field.hasError) ...[
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildDropdownItem(DropdownItem<T> item) {
    // Calculate dynamic height based on content
    double itemHeight = 48.0; // Base height
    if (item.description != null) {
      itemHeight = 64.0; // Increased height for items with descriptions
    }

    return SizedBox(
      height: itemHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            if (item.icon != null) ...[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      item.description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}