extends Node

var tile_size: Vector2 = ProjectSettings.get_setting("global/tile_size")

func get_grid_position(position: Vector2) -> Vector2:
    return (position / tile_size).floor()
