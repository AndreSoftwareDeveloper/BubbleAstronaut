extends Node2D


@onready var game_over_label: Label = $gameOver
@onready var main_script = get_node("/root/Main")
var high_scores_file := FileAccess.open("user://scores.txt", FileAccess.READ)

func _ready() -> void:	
	while not high_scores_file.eof_reached():
		var line = int(high_scores_file.get_line().strip_edges())
		game_over_label.text = "GAME OVER\n SCORE: %s" % main_script.score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
