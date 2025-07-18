extends Node


var level = 1
var points = 0
var energys = 0
var character = "fire"

func _ready() -> void:
	level = 1
	points = 0
	energys = 0
	
func getcoin():
	energys += 1
	
func getpoint():
	points += 5
	
func getlevel():
	level += 5
