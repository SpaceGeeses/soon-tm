extends Camera2D

var dragging = false
@export var edge_pan_speed: float = 200
@export var edge_pan_margin: int = 10
@export var max_zoom_out: Vector2 = Vector2(0.5, 0.5)
@export var max_zoom_in: Vector2 = Vector2(5.0, 5.0)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mmb"):
		dragging = true
	if dragging and event is InputEventMouseMotion:
		position -= event.relative
	if event.is_action_released("mmb"):
		dragging = false
	if event.is_action_pressed("scroll up") && zoom < max_zoom_in:
		zoom *= 1.1
	if event.is_action_pressed("scroll down") && zoom > max_zoom_out:
		zoom *= 0.9


func _process(delta: float) -> void:
	if dragging:
		return

	var viewport_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

	if mouse_position.x <= edge_pan_margin:
		position.x -= edge_pan_speed * delta
	elif mouse_position.x >= viewport_size.x - edge_pan_margin:
		position.x += edge_pan_speed * delta

	if mouse_position.y <= edge_pan_margin:
		position.y -= edge_pan_speed * delta
	elif mouse_position.y >= viewport_size.y - edge_pan_margin:
		position.y += edge_pan_speed * delta
