extends CharacterBody2D
class_name Player

@onready var sprite = $Sprite2D
@onready var state_chart = $StateChart
@onready var navigation_agent = $NavigationAgent2D


func _ready():
	EventBus.selection_created.connect(_on_selection_created)


func _on_selection_created(start_position: Vector2, end_position: Vector2) -> void:
	var selection_rect = Rect2(start_position, end_position - start_position).abs()
	var sprite_global_rect = Rect2(
		global_position - sprite.texture.get_size() * sprite.scale / 2,
		sprite.texture.get_size() * sprite.scale
	)
	if selection_rect.intersects(sprite_global_rect):
		state_chart.send_event("selected")
	else:
		state_chart.send_event("deselected")


func _on_selected_state_entered() -> void:
	modulate = Color.BLUE


func _on_unselected_state_entered() -> void:
	modulate = Color.WHITE


func _on_idle_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb"):
		validate_input()


func _on_pathing_state_physics_processing(_delta: float) -> void:
	var path_positioning = navigation_agent.get_next_path_position()
	velocity = (path_positioning - position).normalized() * navigation_agent.max_speed
	move_and_slide()


func _on_pathing_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb"):
		validate_input()


func _on_determine_input_context_state_entered() -> void:
	var target = state_chart.get_expression_property("target_position")
	if target:
		navigation_agent.set_target_position(target)
		state_chart.send_event("path_to_flag")


func validate_input() -> void:
	var target_position = get_global_mouse_position()
	state_chart.set_expression_property("target_position", target_position)
	state_chart.send_event("determine_input_context")
