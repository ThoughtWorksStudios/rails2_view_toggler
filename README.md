rails2_view_toggler
===================

Simple view toggling framework for Rails 2.x.

You use it like this, by creating an initializer like this:

```
require 'rails2_view_toggler'

Rails2ViewToggler.enable({
        'shared/color_panel' => NEW_COLOR_TOGGLE,
        'color_palette_parameter_input' => PALETTE_TOGGLE
      })
```

What this means is that any call in your app to render the 'shared/color_panel' partial will render the original version if NEW_COLOR_TOGGLE is false and 'shared/new_color_panel' if it is true