extends Area2D

@onready var canvas_group: CanvasGroup = $CanvasGroup
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready() -> void:
	canvas_group.material.set_shader_parameter("line_thickness", 7.0)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func open() -> void:
	if animation_player.assigned_animation == "open":
		return
	input_pickable = false
	animation_player.play("open")

func _input_event(viewport: Viewport, event: InputEvent, shape_index: int):
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and
		event.is_pressed()
	)

	if event_is_mouse_click:
		open()

func _on_mouse_entered() -> void:
	var tween := create_tween()
	tween.tween_method(set_outline_thickness, 7.0, 12.0, 0.08)
	
func _on_mouse_exited() -> void:
	var tween := create_tween()
	tween.tween_method(set_outline_thickness, 12.0, 7.0, 0.08)

func set_outline_thickness(new_thickness: float) -> void:
	canvas_group.material.set_shader_parameter("line_thickness", new_thickness)
