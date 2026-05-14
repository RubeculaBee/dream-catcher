extends Resource
class_name FigmentBlueprint

@export var speciesName: String
@export var sprite: Texture2D
@export var shape: Texture2D
@export var type1: Type
@export var type2: Type
@export var moves: Array[Move]

@export var will: Stat
@export var coherence: Stat
@export var lucidity: Stat
@export var acuity: Stat
@export var creativity: Stat

enum Type {NONE, LAND, SEA, SKY, MIND, BODY, LIGHT, DARK, SYNTH, FEAR}
static var typeColours = {
	Type.NONE: Color.WHITE,
	Type.LAND: Color.GREEN,
	Type.SEA: Color.BLUE,
	Type.SKY: Color.LIGHT_BLUE,
	Type.MIND: Color.PURPLE,
	Type.BODY: Color.RED,
	Type.LIGHT: Color.YELLOW,
	Type.DARK: Color.DARK_GRAY,
	Type.SYNTH: Color.LIGHT_GRAY,
	Type.FEAR: Color.BLACK,
}
