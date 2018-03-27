# Base State Class

extends Node

func Enter():
	# Called when switching to this state
	pass

func Execute(delta):
	# Called by StateMachine.Update()
	pass

func Exit():
	# Called when switching from this state
	pass