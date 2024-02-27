extends Node2D
@onready var timer = $Timer
@onready var gameover = $CanvasLayer
@onready var point = $point
@onready var button = $start/Button

var points :int = 0
const POLE = preload("res://pole.tscn")

var last_spawned_position_y : int
func _ready():

	$Bird.visible = false
	$start.visible = true
	$point.visible = false
	Global.point.connect(add_point)
	get_tree().paused = false
	gameover.visible = false
	$AnimationPlayer.play("new_animation")
	
func _on_bird_die():

	get_tree().paused = true
	gameover.visible = true

func spawn_pole():
	var spawn_position = Vector2i(400,randi_range(170,410))

	if last_spawned_position_y:
		if abs(last_spawned_position_y - spawn_position.y) > 70 :
			if (last_spawned_position_y - spawn_position.y) < 0 :
				spawn_position.y = last_spawned_position_y + randi_range(20,50)
			elif (last_spawned_position_y - spawn_position.y) > 0 :
				spawn_position.y = last_spawned_position_y + randi_range(-20,-50)
			else:
				spawn_position.y = spawn_position.y
	
	last_spawned_position_y = spawn_position.y
	
	var pole = POLE.instantiate()
	pole.global_position = spawn_position
	add_child(pole)
	timer.wait_time = randf_range(1.4,2.0)

func _on_timer_timeout():
	spawn_pole()
	
func add_point():
	points += 1
	point.text = '%s' %points
	$point_plus.play()


func _on_button_pressed():
	start()
	
func start():
	$Timer.start()
	$start.visible = false
	$point.visible = true
	$Bird.visible = true
	$Bird.gravity = Vector2(0,1200)




func _on_start_pressed():
	var childs : Array = get_children()
	for i in childs:
		if i.is_in_group("pole"):
			remove_child(i)
	points = 0
	point.text = str(0)
	$CanvasLayer.visible = false
	get_tree().paused = false
	$Bird.reload()
	$CanvasLayer.visible = false
	$CanvasLayer/TextureRect.visible = false
	$CanvasLayer/game_over.visible = true
	$CanvasLayer/TextureRect/new.visible = false
	$CanvasLayer/TextureRect/medal.texture = null
	$CanvasLayer/TextureRect/shine.texture = null

