extends Node2D

@onready var timer: Timer = $Timer
@onready var bird: Sprite2D = $Bird
@onready var shadow: Sprite2D = $Shadow


func _ready() -> void:
	timer.wait_time = 2.0
	timer.start()

func hop_around() -> void:
	var random_angle := randf_range(0.0, 2.0 * PI)
	var random_direction := Vector2(1.0, 0.0).rotated(random_angle)
	var random_distance := randf_range(15.0, 20.0)
	
	var land_position := random_direction * random_distance
	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2.0
	var tween := create_tween()
	tween.set_parallel()
	tween.tween_property(bird, "position:x", land_position.x, FLIGHT_TIME)
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	var jump_height := randf_range(20.0, 60.0)
	tween.tween_property(bird, "position:y", land_position.y - jump_height, HALF_FLIGHT_TIME)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(bird, "position:y", land_position.y, HALF_FLIGHT_TIME)
	if tween.finished:
		timer.start()
	
	tween = create_tween()
	tween.set_parallel()
	tween.tween_property(shadow, "position:x", land_position.x, FLIGHT_TIME)
	tween.tween_property(shadow, "position:y", land_position.y, FLIGHT_TIME)


func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(2.0, 5.0)
	z_index = 100
	hop_around()
