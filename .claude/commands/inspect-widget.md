# Inspect Selected Widget

Workflow for investigating and modifying widgets selected in the simulator.

## Procedure

1. **Enable widget selection mode**
   - Execute `set_widget_selection_mode(enabled: true)`
   - Tell the user "Please tap on a widget in the simulator to select it"

2. **Wait for user selection**
   - Wait until user reports "selected", "ok", "y", etc.

3. **Get selected widget**
   - Get selection info with `get_selected_widget()`
   - Check widget type, properties, source code location

4. **Investigate related code**
   - Read file from source code location
   - Check widget implementation
   - Investigate parent widgets and related Providers as needed

5. **Propose or execute modifications**
   - Propose/execute modifications based on user instructions
   - After modification, apply immediately with `hot_reload()`

6. **Disable selection mode**
   - After work is complete, execute `set_widget_selection_mode(enabled: false)`

## Dart MCP Tools Used

- `set_widget_selection_mode` - Toggle selection mode ON/OFF
- `get_selected_widget` - Get selected widget information
- `hot_reload` - Apply changes immediately

## Notes

- Execute in a state where DTD connection is established
- Selection mode interferes with app UI interaction, so always turn it OFF after investigation
