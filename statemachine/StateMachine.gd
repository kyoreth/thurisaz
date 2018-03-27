# StateMachine, for keeping track of states and switching between them

extends Node

var currentState
var previousState
var globalState

func ChangeState(newState):
	currentState.Exit()
	previousState = currentState
	currentState = newState
	currentState.Enter()

func Update(delta):
	# Called each frame by _physics_process()
	currentState.Execute(delta)
	globalState.Execute(delta)