extends Node2D

var start_position: Vector2
var current_position: Vector2
var start_drawing: bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lmb"):
		if !start_drawing:
			start_position = get_global_mouse_position()
			start_drawing = true
	if start_drawing and event is InputEventMouseMotion:
		current_position = get_global_mouse_position()

	if event.is_action_released("lmb"):
		start_drawing = false
	queue_redraw()


func _draw() -> void:
	print("Drawing selection rect at: ", start_position, " to ", current_position)
	if start_drawing:
		draw_rect(
			Rect2(start_position, current_position - start_position), Color(0, 0, 0, 0.6), false, 1
		)
