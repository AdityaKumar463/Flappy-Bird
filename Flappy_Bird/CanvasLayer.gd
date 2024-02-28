extends CanvasLayer
var score_dir :String 
var current_points : int
@onready var animation_player = $"../AnimationPlayer"

func _ready():
	DirAccess.make_dir_absolute(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("/My games/Flappy Bird"))
	score_dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).path_join("/My games/Flappy Bird/high_score.txt")
	$TextureRect.visible = false
	$TextureRect/new.visible = false
func _process(delta):
	current_points =  get_parent().points
	pass

func _on_game_over_pressed():
	$game_over.visible = false
	$TextureRect.visible = true
	$TextureRect/score.text = "%s" %current_points
	if current_points >= 10 :
		if current_points >= 20 :
			if current_points >= 30 :
				$TextureRect/medal.texture = load("res://Game Objects/medal_gold.png")
				$TextureRect/shine.texture = load("res://Game Objects/gold_shine.png")
			$TextureRect/medal.texture = load("res://Game Objects/medal_silver.png")
			$TextureRect/shine.texture = load("res://Game Objects/silver_shine.png")
		$TextureRect/medal.texture = load("res://Game Objects/medal_bronze.png")
		
	var high_score = load_file()
	if high_score < current_points :
		save(current_points)
		$TextureRect/new.visible = true
	$TextureRect/high_score.text = str(load_file())

func _on_ok_pressed():
	get_tree().reload_current_scene()


func save(content):
	var file = FileAccess.open(score_dir,FileAccess.WRITE)
	file.store_string("%s"%content)
	file.close()
func load_file():
	var file = FileAccess.open(score_dir,FileAccess.READ)
	if !file:
		save(0)
	var file2 = FileAccess.open(score_dir,FileAccess.READ)
	var file_data = file2.get_as_text()
	file2.close()
	return int(file_data)


func _on_reset_pressed():
	save(0)
