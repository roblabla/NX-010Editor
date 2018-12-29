meta:
  id: hid_shared_mem
  file-extension: bin
  endian: le
enums:
  controller_type:
    0: pro_controller_or_hid_gamepad
    1: joycons_handheld
    2: joycons_pair
    3: joycon_left
    4: joycon_right
    5: default_digital
    6: default
seq:
  - id: header
    size: 0x400
  - id: touchscreen
    type: touchscreen
    size: 0x3000
  - id: mouse
    type: mouse
    size: 0x400
  - id: keyboard
    type: keyboard
    size: 0x400
  - id: unknown1
    size: 0x400
  - id: unknown2
    size: 0x400
  - id: unknown3
    size: 0x400
  - id: unknown4
    size: 0x400
  - id: unknown5
    size: 0x200
  - id: unknown6
    size: 0x200
  - id: unknown7
    size: 0x200
  - id: unknown8
    size: 0x800
  - id: controller_serials
    size: 0x4000
  - id: controllers
    type: controllers
    size: 0x32000
types:
  touch_header:
    seq:
      - id: timestamp_in_ticks
        type: u8
      - id: entries_number
        type: u8
      - id: latest_entry_index
        type: u8
      - id: maximum_entry_index
        type: u8
      - id: timestamp_in_samples
        type: u8
  touch_entry_header:
    seq:
      - id: timestamp_in_samples
        type: u8
      - id: touches_number
        type: u8
  touch_entry_data:
    seq:
      - id: timestamp_in_samples
        type: u8
      - id: padding
        type: u8
      - id: touch_index
        type: u4
      - id: x
        type: u4
      - id: y
        type: u4
      - id: x_diameter
        type: u4
      - id: y_diameter
        type: u4
      - id: angle
        type: u4
  touch_entry:
    seq:
      - id: header
        size: 0x10
        type: touch_entry_header
      - id: data
        size: 0x28
        repeat: expr
        repeat-expr: 16
        type: touch_entry_data
  touchscreen:
    seq:
      - id: header
        size: 0x28
        type: touch_header
      - id: entries
        size: 0x298
        repeat: expr
        repeat-expr: 17
        type: touch_entry
  mouse_header:
    seq:
      - id: timestamp_in_ticks
        type: u8
      - id: entries_number
        type: u8
      - id: latest_entry_index
        type: u8
      - id: maximum_entry_index
        type: u8
  mouse_entry:
    seq:
      - id: timestamp_in_samples
        type: u8
      - id: timestamp_in_samples_duplicate
        type: u8
      - id: x
        type: u4
      - id: y
        type: u4
      - id: x_velocity
        type: u4
      - id: y_velocity
        type: u4
      # TODO: check order (x y or y x), not the same in libnx and switchbrew
      - id: x_scroll_velocity
        type: u4
      - id: y_scroll_velocity
        type: u4
      - id: buttons
        size: 0x8
  mouse:
    seq:
      - id: header
        size: 0x20
        type: mouse_header
      - id: entries
        size: 0x30
        repeat: expr
        repeat-expr: 17
        type: mouse_entry
  keyboard_header:
    seq:
      - id: timestamp_in_ticks
        type: u8
      - id: entries_number
        type: u8
      - id: latest_entry_index
        type: u8
      - id: maximum_entry_index
        type: u8
  keyboard_entry:
    seq:
      - id: timestamp_in_samples
        type: u8
      - id: timestamp_in_samples_duplicate
        type: u8
      - id: modifier_mask
        type: u8
      - id: keys_down
        size: 0x20
  keyboard:
    seq:
      - id: header
        size: 0x20
        type: keyboard_header
      - id: entries
        size: 0x38
        repeat: expr
        repeat-expr: 17
        type: keyboard_entry
  controller_color_descriptor:
    seq:
      - id: colors_non_existent
        type: b1
  controller_header:
    seq:
      - id: status
        type: u4
        enum: controller_type
      - id: is_half_joycon
        type: u4
      - id: single_colors_descriptor
        type: controller_color_descriptor
        size: 0x4
      - id: rgba_body_color
        type: u4
      - id: rgba_buttons_color
        type: u4
      - id: split_colors_descriptor
        type: controller_color_descriptor
        size: 0x4
      # TODO : check order (left right or right left), not the same in libnx and switchbrew
      - id: left_joycon_rgba_body_color
        type: u4
      - id: left_joycon_rgba_buttons_color
        type: u4
      - id: right_joycon_rgba_body_color
        type: u4
      - id: right_joycon_rgba_buttons_color
        type: u4
  controller_state_header:
    seq:
      - id: timestamp_in_ticks
        type: u8
      - id: entries_number
        type: u8
      - id: latest_entry_index
        type: u8
      - id: maximum_entry_index
        type: u8
  button_state:
    seq:
      - id: a
        type: b1
      - id: b
        type: b1
      - id: x
        type: b1
      - id: y
        type: b1
      - id: left_stick_pressed
        type: b1
      - id: right_stick_pressed
        type: b1
      - id: l
        type: b1
      - id: r
        type: b1
      - id: zl
        type: b1
      - id: zr
        type: b1
      - id: plus
        type: b1
      - id: minus
        type: b1
      - id: left
        type: b1
      - id: up
        type: b1
      - id: right
        type: b1
      - id: down
        type: b1
      - id: left_stick_left
        type: b1
      - id: left_stick_up
        type: b1
      - id: left_stick_right
        type: b1
      - id: left_stick_down
        type: b1
      - id: right_stick_left
        type: b1
      - id: right_stick_up
        type: b1
      - id: right_stick_right
        type: b1
      - id: right_stick_down
        type: b1
      - id: sl
        type: b1
      - id: sr
        type: b1
  controller_state_content:
    seq:
      - id: timestamp_in_samples
        type: u8
      - id: timestamp_in_samples_duplicate
        type: u8
      - id: buttons
        type: button_state
      - id: left_joystick_x
        type: u4
      - id: left_joystick_y
        type: u4
      - id: right_joystick_x
        type: u4
      - id: right_joystick_y
        type: u4
      - id: is_connected
        type: b1
      - id: is_wired
        type: b1
  controller_state:
    seq:
      - id: header
        type: controller_state_header
      - id: state
        size: 0x30
        repeat: expr
        repeat-expr: 17
        type: controller_state_content
  six_axis_sensor_controller_state_header:
    seq:
      - id: timestamp_in_ticks
        type: u8
      - id: entries_number
        type: u8
      - id: latest_entry_index
        type: u8
      - id: maximum_entry_index
        type: u8
  controller_sensor:
    seq:
      - id: value1
        type: f4
      - id: value2
        type: f4
      - id: value3
        type: f4
  controller_orientation_sensor:
    seq:
      - id: value1
        type: f4
      - id: value2
        type: f4
      - id: value3
        type: f4
      - id: value4
        type: f4
      - id: value5
        type: f4
      - id: value6
        type: f4
      - id: value7
        type: f4
      - id: value8
        type: f4
      - id: value9
        type: f4
  six_axis_sensor_controller_state_content:
    seq:
      - id: timestamp_in_samples
        type: u8
      - id: unknown1
        type: u8
      - id: timestamp_in_samples_duplicate
        type: u8
      - id: accelerometer
        type: controller_sensor
        size: 0xc
      - id: gyroscope
        type: controller_sensor
        size: 0xc
      - id: unknown_sensor
        type: controller_sensor
        size: 0xc
      - id: orientation_basis
        type: controller_orientation_sensor
        size: 0x24
      - id: unknown2
        type: u8
  six_axis_sensor_controller_state:
    seq:
      - id: header
        type: six_axis_sensor_controller_state_header
        size: 0x20
      - id: state
        size: 0x68
        repeat: expr
        repeat-expr: 17
        type: six_axis_sensor_controller_state_content
  controller:
    seq:
      - id: header
        size: 0x28
        type: controller_header
      - id: pro_controller_state
        type: controller_state
        size: 0x350
      - id: handheld_joined_state
        type: controller_state
        size: 0x350
      - id: joined_joycons_state
        type: controller_state
        size: 0x350
      - id: left_joycon_state
        type: controller_state
        size: 0x350
      - id: right_joycon_state
        type: controller_state
        size: 0x350
      - id: main_controller_state_without_sticks
        type: controller_state
        size: 0x350
      - id: main_controller_state
        type: controller_state
        size: 0x350
      - id: six_axis_sensor_pro_controller_state
        type: six_axis_sensor_controller_state
        size: 0x708
      - id: six_axis_sensor_handheld_state
        type: six_axis_sensor_controller_state
        size: 0x708
      - id: six_axis_sensor_pair_left_state
        type: six_axis_sensor_controller_state
        size: 0x708
      - id: six_axis_sensor_pair_right_state
        type: six_axis_sensor_controller_state
        size: 0x708
      - id: six_axis_sensor_single_left_state
        type: six_axis_sensor_controller_state
        size: 0x708
      - id: six_axis_sensor_single_right_state
        type: six_axis_sensor_controller_state
        size: 0x708
      - id: controller_mac_1
        size: 0x10
      - id: controller_mac_2
        size: 0x10
  controllers:
    seq:
      - id: controllers
        size: 0x5000
        repeat: expr
        repeat-expr: 8
        type: controller
      - id: handheld_mode
        size: 0x5000
        type: controller