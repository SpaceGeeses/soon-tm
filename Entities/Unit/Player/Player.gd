extends CharacterBody2D
@export var max_speed: int = 300
@onready var sprite = $Sprite2D

var target_position = Vector2()
var arrive_radius = 1
var selected = false


func _ready():
	EventBus.selection_created.connect(on_selection_created)
	target_position = position


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb") and selected:
		target_position = get_global_mouse_position()


func _process(delta: float) -> void:
	var direction = (target_position - position).normalized()
	var distance_to_target = position.distance_to(target_position)

	if distance_to_target < arrive_radius:
		velocity = Vector2()
	else:
		velocity = direction * max_speed

	move_and_slide()


func on_selection_created(start_position: Vector2, end_position: Vector2) -> void:
	selected = false
	modulate = Color(1, 1, 1)
	var selection_rect = Rect2(start_position, end_position - start_position).abs()
	if selection_rect.has_point(global_position):
		selected = true
		modulate = Color(1, 1, 0.5)
