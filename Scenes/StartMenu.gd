extends Control


func _on_StartGame_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_QuitGame_pressed():
	get_tree().quit()
