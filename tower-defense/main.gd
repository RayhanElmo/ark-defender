extends Node2D

const FIRST_MAP = [
	"############",
	"####.......R",
	"####.HHHHHH#",
	"B..........R",
	"####.HHHHHH#",
	"####.......R",
	"############",
]
const OPERATORS = [
	["Milesis", 1200, 220, 12, 20, 10.0, 1.0, 2],
	["Eirelios", 2800, 90, 15, 25, 5.0, 1.3, 4],
	["Noira", 700, 300, 18, 25, 15.0, 2.0, 0],
	["Yoine", 800, 120, 14, 20, 10.0, 2.0, 0],
	["Ionia", 1300, 200, 13, 22, 10.0, 1.0, 2],
	["Jorganda", 3200, 80, 16, 25, 15.0, 1.3, 4],
	["Liorenoy", 750, 280, 19, 28, 20.0, 2.0, 0],
	["Amaya", 850, 100, 15, 25, 15.0, 2.0, 0],
	["Valtheon", 1400, 190, 14, 22, 12.0, 1.0, 2],
	["Selvira", 900, 110, 15, 25, 10.0, 2.0, 0],
	["Asterin", 680, 310, 19, 25, 12.0, 2.0, 0],
	["Virelda", 760, 260, 17, 23, 12.0, 2.0, 0],
	["Kaelith", 710, 275, 18, 24, 12.0, 2.0, 0],
	["Bastira", 3000, 85, 17, 26, 10.0, 1.3, 4],
	["Tarian", 3100, 75, 16, 24, 12.0, 1.3, 4],
	["Ravika", 1250, 205, 13, 20, 10.0, 1.0, 2],
	["Tavira", 880, 95, 14, 22, 12.0, 2.0, 0],
]
# Wave start, spawn lanes, and whether each enemy is ranged.
const ASTERIN = 10
const VIRELDA = 11
const KAELITH = 12
const BASTIRA = 13
const TARIAN = 14
const RAVIKA = 15
const TAVIRA = 16
const ROLES = [0, 1, 2, 3, 0, 1, 2, 3, 0, 3, 2, 2, 2, 1, 1, 0, 3]
const ROLE_NAMES = ["Striker", "Guardian", "Caster", "Supporter"]
const SKILL_NAMES = [
	"Serangan cepat", "Stun area", "Serangan area", "Heal ganda",
	"Damage berkala", "Pantulan damage", "Tiga target", "Buff ATK tim",
	"Serangan dan lifesteal", "Perisai area",
	"Bidikan Jauh", "Tanda Retak", "Rantai Petir",
	"Benteng Pengganti", "Formasi Rapat", "Tebas Balik", "Panggil Cadangan",
]
const MAX_SQUAD = 8
const FIRST_WAVES = [
	[8.0, [[0, false], [0, false], [0, false]]],
	[30.0, [[1, false], [1, false], [1, false], [2, true], [2, true]]],
	[58.0, [[0, false], [1, false], [2, false], [0, false], [1, true], [2, true], [0, false], [2, false]]],
]
const STAGES = [
	{
		"name": "Jaga Persimpangan", "map": FIRST_MAP, "waves": FIRST_WAVES,
		"routes": [
			[Vector2i(11, 3), Vector2i(0, 3)],
			[Vector2i(11, 1), Vector2i(4, 1), Vector2i(4, 3), Vector2i(0, 3)],
			[Vector2i(11, 5), Vector2i(4, 5), Vector2i(4, 3), Vector2i(0, 3)],
		],
	},
	{
		"name": "Lorong Ganda",
		"map": ["############", "##.........R", "##.HHHHHHHH#", "B...HH######", "###.HHHHHHH#", "###........R", "############"],
		"routes": [
			[Vector2i(11, 1), Vector2i(2, 1), Vector2i(2, 3), Vector2i(0, 3)],
			[Vector2i(11, 5), Vector2i(3, 5), Vector2i(3, 3), Vector2i(0, 3)],
		],
		"waves": [
			[8.0, [[0, false], [0, false], [0, false], [0, true]]],
			[32.0, [[1, false], [1, false], [0, true], [1, false], [1, true]]],
			[57.0, [[0, false], [1, false], [0, false], [1, false], [0, true], [1, true], [0, false], [1, false]]],
		],
	},
	{
		"name": "Benteng Terakhir",
		"map": ["######.....R", "##.....HHHH#", "B..HHH.HHHH#", "##.HHH.....R", "##.HHHHHHHH#", "##.........R", "############"],
		"routes": [
			[Vector2i(11, 0), Vector2i(6, 0), Vector2i(6, 1), Vector2i(2, 1), Vector2i(2, 2), Vector2i(0, 2)],
			[Vector2i(11, 3), Vector2i(6, 3), Vector2i(6, 1), Vector2i(2, 1), Vector2i(2, 2), Vector2i(0, 2)],
			[Vector2i(11, 5), Vector2i(2, 5), Vector2i(2, 2), Vector2i(0, 2)],
		],
		"waves": [
			[8.0, [[1, false], [1, false], [0, false]]],
			[30.0, [[2, false], [0, false], [1, true], [2, false], [0, true]]],
			[56.0, [[1, false], [2, false], [1, false, true], [0, true], [2, true], [1, false]]],
		],
	},
	{
		"name": "Gerbang Besi",
		"map": ["############","#HHHHHHHHHH#","#HHHHHH....R","#HHHHHH.HHH#","B.......HHH#","#HHH.......R","############"],
		"routes": [
			[Vector2i(11, 2), Vector2i(7, 2), Vector2i(7, 4), Vector2i(0, 4)],
			[Vector2i(11, 5), Vector2i(4, 5), Vector2i(4, 4), Vector2i(0, 4)],
		],
		"waves": [
			[7.0, [[0, false], [0, false], [0, false], [0, true]]],
			[28.0, [[1, false], [1, false], [0, false], [1, true], [1, false], [0, true]]],
			[54.0, [[0, false], [1, false], [0, false], [1, false], [0, true], [1, true], [0, false], [1, false], [0, true]]],
		],
	},
	{
		"name": "Jalur Silang",
		"map": ["############","#HHHHHHH...R","#HHHHHHH.HH#","B..........R","#HHHH.HHHHH#","#HHHH......R","############"],
		"routes": [
			[Vector2i(11, 1), Vector2i(8, 1), Vector2i(8, 3), Vector2i(0, 3)],
			[Vector2i(11, 3), Vector2i(0, 3)],
			[Vector2i(11, 5), Vector2i(5, 5), Vector2i(5, 3), Vector2i(0, 3)],
		],
		"waves": [
			[7.0, [[0, false], [1, false], [2, false], [1, false], [0, true]]],
			[27.0, [[2, false], [0, false], [1, true], [1, false], [2, true], [2, false]]],
			[53.0, [[0, false], [2, false], [1, false], [0, true], [2, true], [2, false], [1, true], [0, false], [1, false], [2, false]]],
		],
	},
	{
		"name": "Koridor Senja",
		"map": ["######.....R","#HHHHH.HHHH#","#HH....HHHH#","#HH.HHHH...R","B...HHHH.HH#","#HH......HH#","############"],
		"routes": [
			[Vector2i(11, 0), Vector2i(6, 0), Vector2i(6, 2), Vector2i(3, 2), Vector2i(3, 4), Vector2i(0, 4)],
			[Vector2i(11, 3), Vector2i(8, 3), Vector2i(8, 5), Vector2i(3, 5), Vector2i(3, 4), Vector2i(0, 4)],
		],
		"waves": [
			[6.0, [[0, false], [0, false], [1, false], [0, true], [1, false]]],
			[25.0, [[1, false], [1, true], [0, false], [0, true], [1, false], [0, false], [1, true]]],
			[49.0, [[0, false], [1, false], [0, true], [1, true], [1, false], [0, false], [0, true], [1, true], [1, false], [0, false]]],
		],
	},
	{
		"name": "Takhta Reruntuhan",
		"map": ["############","#HHHHHH....R","#HHHHHH.HHH#","#H.........R","B....HHHHHH#","#HHH.......R","############"],
		"routes": [
			[Vector2i(11, 1), Vector2i(7, 1), Vector2i(7, 3), Vector2i(2, 3), Vector2i(2, 4), Vector2i(0, 4)],
			[Vector2i(11, 3), Vector2i(2, 3), Vector2i(2, 4), Vector2i(0, 4)],
			[Vector2i(11, 5), Vector2i(4, 5), Vector2i(4, 4), Vector2i(0, 4)],
		],
		"waves": [
			[7.0, [[0, false], [1, false], [2, false], [0, false], [0, true]]],
			[29.0, [[2, false], [2, true], [1, false], [0, false], [1, true], [2, false], [0, true]]],
			[55.0, [[1, false], [2, false], [1, false, 2], [0, true], [2, true], [0, false], [2, false], [1, true], [1, false], [2, false]]],
		],
	},
]
var ORIGIN := Vector2(160, 80)
var CELL := 80
const COLORS = [Color("#ff6b6b"), Color("#4dabf7"), Color("#b197fc"), Color("#51cf66")]
# UI palette (military tactical dark)
const COL_BG = Color("#0a0f1a")
const COL_PANEL = Color("#141c2b")
const COL_PANEL_BORDER = Color("#2a3a50")
const COL_TEXT = Color("#e8edf5")
const COL_TEXT_DIM = Color("#8a9bb5")
const COL_ACCENT = Color("#f5c842")
const COL_DANGER = Color("#ff5a6b")
const COL_SUCCESS = Color("#4ade80")
const COL_TILE_PATH = Color("#2a3344")
const COL_TILE_HIGH = Color("#3a4558")
const COL_TILE_SPAWN = Color("#8b2a3a")
const COL_TILE_BASE = Color("#1e4a7a")

var stage_index = 0
var boss: Dictionary = {}
var boss_label: Label
var audio_voices: Array[AudioStreamPlayer] = []
var voice_cursor = 0
var sounds: Dictionary = {}
var muted = false
var screen = "menu"
var ui: Control
var hud: Label
var hint: Label
var skill_button: Button
var retreat_button: Button
var unit_info: Label
var cards: Array[Button] = []
var units: Dictionary = {}
var enemies: Array[Dictionary] = []
var cooldowns: Array[float] = []
var squad: Array[int] = [0, 1, 2, 3]
var squad_cards: Dictionary = {}
var squad_count: Label
var squad_start: Button
var squad_filter_role: int = -1
var squad_tab_buttons: Array[Button] = []
var clock = 0.0
var points = 10.0
var lives = 10
var wave = 0
var spawn_index = 0
var speed = 1.0
var paused = false
var chosen = -1
var selected = -1
var pending = Vector2i(-1, -1)
var facing = Vector2i.RIGHT
var effects: Array[Dictionary] = []
var tile_textures: Dictionary = {}
var menu_bg_texture: Texture2D
var operator_textures = []
var enemy_textures = []
var inspected = -1
var squad_detail_panel: Panel
var squad_detail_avatar: TextureRect
var squad_detail_title: Label
var squad_detail_role: Label
var squad_detail_stats: Label
var squad_detail_skill: Label
var squad_slot_panel: Panel
var unit_panel: Panel
var unit_avatar: TextureRect
var unit_title: Label
var unit_role: Label
var unit_stats: Label
var unit_skill: Label
var card_plain: Array[StyleBoxFlat] = []
var card_gold: StyleBoxFlat

func _ready():
	for _voice in 6:
		var player = AudioStreamPlayer.new()
		add_child(player)
		audio_voices.append(player)
	# Load tile textures
	var tile_map = {
		".": "res://assets/tiles/tile_path.svg",
		"H": "res://assets/tiles/tile_high.svg",
		"R": "res://assets/tiles/tile_spawn.svg",
		"B": "res://assets/tiles/tile_base.svg",
		"#": "res://assets/tiles/tile_obstacle.svg",
	}
	for key in tile_map:
		var tex = load(tile_map[key])
		if tex:
			tile_textures[key] = tex
	if ResourceLoader.exists("res://assets/ui/menu_bg.png"):
		menu_bg_texture = load("res://assets/ui/menu_bg.png")
	elif ResourceLoader.exists("res://assets/ui/menu_bg.jpg"):
		menu_bg_texture = load("res://assets/ui/menu_bg.jpg")
	else:
		menu_bg_texture = load("res://assets/ui/menu_bg.svg")
	load_character_textures()
	sounds = {
		"deploy": make_tone(500.0, 760.0, 0.16),
		"skill": make_tone(440.0, 880.0, 0.28),
		"impact": make_tone(150.0, 70.0, 0.24),
		"heal_3": make_melody([[659.25, 0.08], [783.99, 0.12]]),
		"heal_7": make_melody([[523.25, 0.08], [659.25, 0.12]]),
		"heal_9": make_melody([[783.99, 0.08], [987.77, 0.12]]),
		"atk_0": make_tone(880.0, 660.0, 0.07),
		"atk_1": make_tone(220.0, 180.0, 0.10),
		"atk_2": make_tone(1046.5, 784.0, 0.09),
		"atk_4": make_tone(988.0, 740.0, 0.08),
		"atk_5": make_tone(196.0, 165.0, 0.11),
		"atk_6": make_tone(1175.0, 880.0, 0.09),
		"atk_8": make_tone(740.0, 587.0, 0.08),
		"win": make_melody([[523.25, 0.12], [659.25, 0.12], [783.99, 0.12], [1046.5, 0.32]]),
		"lose": make_melody([[392.0, 0.18], [329.63, 0.18], [261.63, 0.22], [196.0, 0.32]]),
	}
	for sfx_id in ATTACK_SFX:
		sounds["atk_%d" % sfx_id] = make_sfx(ATTACK_SFX[sfx_id], 4200 + int(sfx_id) * 977)
	get_viewport().size_changed.connect(on_viewport_resized)
	show_menu()

# Chibi sprites, indexed to match OPERATORS and the melee/ranged/boss enemy kinds.
const OPERATOR_ASSET_NAMES = [
	"milesis", "eirelios", "noira", "yoine", "ionia",
	"jorganda", "liorenoy", "amaya", "valtheon", "selvira",
	"asterin", "virelda", "kaelith", "bastira", "tarian",
	"ravika", "tavira"
]
const ENEMY_ASSET_NAMES = ["melee", "ranged", "boss"]

func load_character_textures():
	for asset_name in OPERATOR_ASSET_NAMES:
		var path = "res://assets/operators/%s.png" % asset_name
		if ResourceLoader.exists(path):
			operator_textures.append(load(path))
		else:
			operator_textures.append(operator_textures[0] if not operator_textures.is_empty() else null)
	for asset_name in ENEMY_ASSET_NAMES:
		enemy_textures.append(load("res://assets/enemies/%s.png" % asset_name))

func operator_portrait(id: int) -> Texture2D:
	if id >= 0 and id < operator_textures.size() and operator_textures[id] != null:
		return operator_textures[id]
	return operator_textures[0] if not operator_textures.is_empty() else null

func operator_effect_color(id: int) -> Color:
	match id:
		ASTERIN: return Color("#a9dcff")
		VIRELDA: return Color("#ffa7ca")
		KAELITH: return Color("#e4c0ff")
		BASTIRA: return Color("#e5b977")
		TARIAN: return Color("#83e0e9")
		RAVIKA: return Color("#f5a5a5")
		TAVIRA: return Color("#c4f79e")
	return COLORS[ROLES[id]]

func operator_tint(_id: int) -> Color:
	return Color.WHITE

func draw_chibi(tex: Texture2D, at: Vector2, size: float, flip := false, tint := Color.WHITE):
	draw_set_transform(at, 0.0, Vector2(-size if flip else size, size))
	draw_texture_rect(tex, Rect2(-0.5, -0.5, 1.0, 1.0), false, tint)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

func make_tone(start_hz: float, end_hz: float, duration: float) -> AudioStreamWAV:
	var sound = AudioStreamWAV.new()
	sound.format = AudioStreamWAV.FORMAT_16_BITS
	sound.mix_rate = 22050
	var samples = roundi(duration * sound.mix_rate)
	var pcm = PackedByteArray()
	pcm.resize(samples * 2)
	var phase = 0.0
	for i in samples:
		var progress = float(i) / samples
		phase += TAU * lerpf(start_hz, end_hz, progress) / sound.mix_rate
		var envelope = minf(progress * 50.0, 1.0) * pow(1.0 - progress, 2.0)
		pcm.encode_s16(i * 2, roundi(sin(phase) * envelope * 4800.0))
	sound.data = pcm
	return sound

func play_sound(key: String):
	if muted or not sounds.has(key):
		return
	var voice = audio_voices[voice_cursor]
	voice_cursor = (voice_cursor + 1) % audio_voices.size()
	if voice.playing:
		voice.stop()
	voice.stream = sounds[key]
	voice.play()

# Per-key timbre: from/to is the pitch sweep, noise_lp is the brightness of the noise
# layer, burst splits one hit into repeated strikes, sub adds a layer one octave lower.
const ATTACK_SFX = {
	0: {"wave": "metal", "from": 2000.0, "to": 900.0, "len": 0.18, "gain": 7600.0, "noise": 0.30, "noise_lp": 0.35, "decay": 4.0, "trem_hz": 0.0, "trem_depth": 0.0, "sub": 0.0, "burst": 2.0},
	1: {"wave": "metal", "from": 260.0, "to": 150.0, "len": 0.30, "gain": 5200.0, "noise": 0.45, "noise_lp": 0.12, "decay": 3.0, "trem_hz": 0.0, "trem_depth": 0.0, "sub": 0.50, "burst": 1.0},
	2: {"wave": "sine", "from": 1200.0, "to": 260.0, "len": 0.34, "gain": 5900.0, "noise": 0.55, "noise_lp": 0.25, "decay": 2.2, "trem_hz": 22.0, "trem_depth": 0.35, "sub": 0.15, "burst": 1.0},
	3: {"wave": "bell", "from": 660.0, "to": 620.0, "len": 0.45, "gain": 4000.0, "noise": 0.05, "noise_lp": 0.50, "decay": 1.6, "trem_hz": 0.0, "trem_depth": 0.0, "sub": 0.20, "burst": 1.0},
	4: {"wave": "square", "from": 2600.0, "to": 1500.0, "len": 0.08, "gain": 5000.0, "noise": 0.20, "noise_lp": 0.70, "decay": 8.0, "trem_hz": 0.0, "trem_depth": 0.0, "sub": 0.0, "burst": 1.0},
	5: {"wave": "metal", "from": 180.0, "to": 95.0, "len": 0.42, "gain": 4750.0, "noise": 0.50, "noise_lp": 0.08, "decay": 2.4, "trem_hz": 0.0, "trem_depth": 0.0, "sub": 0.65, "burst": 1.0},
	6: {"wave": "saw", "from": 1500.0, "to": 1100.0, "len": 0.26, "gain": 5000.0, "noise": 0.60, "noise_lp": 1.00, "decay": 2.8, "trem_hz": 42.0, "trem_depth": 0.60, "sub": 0.0, "burst": 1.0},
	7: {"wave": "saw", "from": 900.0, "to": 1350.0, "len": 0.22, "gain": 5470.0, "noise": 0.12, "noise_lp": 0.40, "decay": 3.2, "trem_hz": 8.0, "trem_depth": 0.15, "sub": 0.25, "burst": 2.0},
	8: {"wave": "square", "from": 700.0, "to": 120.0, "len": 0.26, "gain": 3750.0, "noise": 0.35, "noise_lp": 0.18, "decay": 3.0, "trem_hz": 30.0, "trem_depth": 0.25, "sub": 0.50, "burst": 1.0},
	9: {"wave": "bell", "from": 1760.0, "to": 1320.0, "len": 0.50, "gain": 4400.0, "noise": 0.10, "noise_lp": 0.60, "decay": 1.4, "trem_hz": 6.0, "trem_depth": 0.12, "sub": 0.30, "burst": 1.0},
	10: {"wave": "sine", "from": 2400.0, "to": 700.0, "len": 0.26, "gain": 3900.0, "noise": 0.18, "noise_lp": 0.30, "decay": 2.4, "trem_hz": 0.0, "trem_depth": 0.0, "sub": 0.35, "burst": 1.0},
	11: {"wave": "bell", "from": 1300.0, "to": 2400.0, "len": 0.28, "gain": 4950.0, "noise": 0.35, "noise_lp": 0.85, "decay": 2.2, "trem_hz": 33.0, "trem_depth": 0.30, "sub": 0.20, "burst": 1.0},
	12: {"wave": "square", "from": 900.0, "to": 220.0, "len": 0.20, "gain": 4400.0, "noise": 0.75, "noise_lp": 1.00, "decay": 6.0, "trem_hz": 90.0, "trem_depth": 0.60, "sub": 0.10, "burst": 4.0},
}

const BELL_RATIOS = [1.0, 2.76, 5.40, 8.93]
const BELL_WEIGHTS = [1.0, 0.45, 0.28, 0.16]
const METAL_RATIOS = [1.0, 1.41, 1.93, 2.61, 3.83]
const METAL_WEIGHTS = [1.0, 0.72, 0.55, 0.42, 0.30]

func wave_value(kind: String, phase: float) -> float:
	if kind == "sine":
		return sin(phase)
	if kind == "square":
		return 1.0 if sin(phase) >= 0.0 else -1.0
	if kind == "saw":
		return 2.0 * (fmod(phase, TAU) / TAU) - 1.0
	var ratios = BELL_RATIOS if kind == "bell" else METAL_RATIOS
	var weights = BELL_WEIGHTS if kind == "bell" else METAL_WEIGHTS
	var total = 0.0
	var norm = 0.0
	for partial in ratios.size():
		total += sin(phase * ratios[partial]) * weights[partial]
		norm += weights[partial]
	return total / norm

func make_sfx(spec: Dictionary, seed_value: int) -> AudioStreamWAV:
	var sound = AudioStreamWAV.new()
	sound.format = AudioStreamWAV.FORMAT_16_BITS
	sound.mix_rate = 22050
	var samples = maxi(1, roundi(spec.len * sound.mix_rate))
	var pcm = PackedByteArray()
	pcm.resize(samples * 2)
	var rng = RandomNumberGenerator.new()
	rng.seed = seed_value
	var noise = 0.0
	var phase = 0.0
	for i in samples:
		var progress = float(i) / samples
		phase += TAU * lerpf(spec.from, spec.to, progress) / sound.mix_rate
		noise = lerpf(noise, rng.randf_range(-1.0, 1.0), spec.noise_lp)
		var voice = lerpf(wave_value(spec.wave, phase), noise, spec.noise) + spec.sub * sin(phase * 0.5)
		var strike = fmod(progress * spec.burst, 1.0)
		var envelope = minf(strike * 80.0, 1.0) * pow(1.0 - strike, spec.decay)
		var tremolo = 1.0 - spec.trem_depth * (0.5 + 0.5 * cos(TAU * spec.trem_hz * progress * spec.len))
		pcm.encode_s16(i * 2, roundi(clampf(voice * envelope * tremolo * spec.gain, -32000.0, 32000.0)))
	sound.data = pcm
	return sound

func make_melody(notes: Array, mix_rate: int = 22050) -> AudioStreamWAV:
	var sound = AudioStreamWAV.new()
	sound.format = AudioStreamWAV.FORMAT_16_BITS
	sound.mix_rate = mix_rate
	var total_samples = 0
	for n in notes:
		total_samples += roundi(n[1] * mix_rate)
	var pcm = PackedByteArray()
	pcm.resize(total_samples * 2)
	var cursor = 0
	var phase = 0.0
	for n in notes:
		var freq: float = n[0]
		var dur: float = n[1]
		var samples = roundi(dur * mix_rate)
		for i in samples:
			var progress = float(i) / samples
			phase += TAU * freq / mix_rate
			var envelope = minf(progress * 20.0, 1.0) * pow(1.0 - progress, 1.5)
			pcm.encode_s16((cursor + i) * 2, roundi(sin(phase) * envelope * 6000.0))
		cursor += samples
	sound.data = pcm
	return sound

func toggle_audio():
	muted = not muted
	if muted:
		for voice in audio_voices:
			voice.stop()

func make_screen(next: String):
	screen = next
	if is_instance_valid(ui):
		remove_child(ui)
		ui.queue_free()
	ui = Control.new()
	ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(ui)
	queue_redraw()

func compute_battle_layout():
	var vp = get_viewport_rect().size
	var hud_h = 52.0
	var card_h = 150.0
	var pad_x = 10.0
	var avail_w = vp.x - pad_x * 2.0
	var avail_h = vp.y - hud_h - card_h
	CELL = floori(minf(avail_w / 12.0, avail_h / 7.0))
	var map_w = CELL * 12
	var map_h = CELL * 7
	ORIGIN = Vector2(
		floorf((vp.x - map_w) * 0.5),
		hud_h + floorf((avail_h - map_h) * 0.5)
	)

func compute_preview_layout():
	var vp = get_viewport_rect().size
	var header_h = 76.0
	var footer_h = 72.0
	# Map sits in the right column: x from (24+340+16)=380 to vp.x-24
	var left_col_w = 24.0 + 340.0 + 16.0
	var pad_r = 24.0
	var avail_w = vp.x - left_col_w - pad_r
	var avail_h = vp.y - header_h - footer_h
	CELL = floori(minf(avail_w / 12.0, avail_h / 7.0))
	var map_w = CELL * 12
	var map_h = CELL * 7
	ORIGIN = Vector2(
		left_col_w + floorf((avail_w - map_w) * 0.5),
		header_h + floorf((avail_h - map_h) * 0.5)
	)

func make_scroll_area(y_start: float, y_end: float) -> ScrollContainer:
	var vp = get_viewport_rect().size
	var scroll = ScrollContainer.new()
	scroll.position = Vector2(0, y_start)
	scroll.size = Vector2(vp.x, y_end - y_start)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	ui.add_child(scroll)
	var content = Control.new()
	content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(content)
	return scroll

func label(value: String, at: Vector2, font_size: int) -> Label:
	var item = Label.new()
	item.text = value
	item.position = at
	item.add_theme_font_size_override("font_size", font_size)
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ui.add_child(item)
	return item

func button(value: String, at: Vector2, action: Callable, dimensions := Vector2(220, 46)) -> Button:
	var item = Button.new()
	item.text = value
	item.position = at
	item.custom_minimum_size = dimensions
	var box = StyleBoxFlat.new()
	box.bg_color = Color("#1a2538")
	box.border_color = Color("#3a4f6b")
	box.set_border_width_all(1)
	box.set_corner_radius_all(6)
	box.content_margin_left = 8
	box.content_margin_right = 8
	box.content_margin_top = 4
	box.content_margin_bottom = 4
	item.add_theme_stylebox_override("normal", box)
	var hover = box.duplicate()
	hover.bg_color = Color("#24324a")
	hover.border_color = Color("#4dabf7")
	item.add_theme_stylebox_override("hover", hover)
	var pressed = box.duplicate()
	pressed.bg_color = Color("#0f1828")
	pressed.border_color = Color("#f5c842")
	item.add_theme_stylebox_override("pressed", pressed)
	item.add_theme_color_override("font_color", Color("#e8edf5"))
	item.add_theme_font_size_override("font_size", 13)
	item.pressed.connect(action)
	ui.add_child(item)
	return item

func card_box(fill: Color, border: Color) -> StyleBoxFlat:
	var box = StyleBoxFlat.new()
	box.bg_color = fill
	box.border_color = border
	box.set_border_width_all(2)
	box.set_corner_radius_all(9)
	box.content_margin_left = 6.0
	box.content_margin_right = 6.0
	box.content_margin_top = 4.0
	box.content_margin_bottom = 4.0
	return box

func skin_card(item: Button, accent: Color, fill := Color("#151f2e")) -> StyleBoxFlat:
	var normal = card_box(fill, accent)
	item.add_theme_stylebox_override("normal", normal)
	item.add_theme_stylebox_override("hover", card_box(Color("#1e2b3d"), accent.lightened(0.2)))
	item.add_theme_stylebox_override("pressed", card_box(Color("#1b3a2b"), COL_SUCCESS))
	item.add_theme_stylebox_override("hover_pressed", card_box(Color("#224836"), COL_SUCCESS))
	item.add_theme_stylebox_override("disabled", card_box(Color("#11161f"), Color("#2b3646")))
	item.add_theme_color_override("font_color", COL_TEXT)
	item.add_theme_color_override("font_hover_color", Color.WHITE)
	item.add_theme_color_override("font_pressed_color", COL_SUCCESS)
	item.add_theme_color_override("font_disabled_color", COL_TEXT_DIM)
	return normal

func avatar_card(item: Button, id: int, font_size: int):
	item.icon = operator_portrait(id)
	item.expand_icon = true
	item.alignment = HORIZONTAL_ALIGNMENT_LEFT
	item.add_theme_font_size_override("font_size", font_size)

func ui_panel(at: Vector2, item_size: Vector2, border: Color) -> Panel:
	var item = Panel.new()
	item.position = at
	item.size = item_size
	item.add_theme_stylebox_override("panel", card_box(Color(0.07, 0.1, 0.16, 0.95), border))
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ui.add_child(item)
	return item

func ui_avatar(host: Control, at: Vector2, avatar_size: float) -> TextureRect:
	var item = TextureRect.new()
	item.position = at
	item.size = Vector2(avatar_size, avatar_size)
	item.custom_minimum_size = Vector2(avatar_size, avatar_size)
	item.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	item.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	host.add_child(item)
	return item

func panel_label(host: Control, value: String, at: Vector2, font_size: int) -> Label:
	var item = Label.new()
	item.text = value
	item.position = at
	item.add_theme_font_size_override("font_size", font_size)
	item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	host.add_child(item)
	return item

func set_avatar(item: TextureRect, id: int):
	item.texture = operator_portrait(id)
	item.modulate = operator_tint(id)

func operator_line(id: int) -> String:
	var stats = OPERATORS[id]
	return "HP %d  •  ATK %d  •  COST %d  •  Interval %.1f s  •  Block %d" % [stats[1], stats[2], stats[3], stats[6], stats[7]]

func show_menu():
	make_screen("menu")
	var title = Label.new()
	title.text = "ARK DEFENDER"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.position = Vector2(0, 150)
	title.size = Vector2(1280, 90)
	title.add_theme_font_size_override("font_size", 72)
	title.add_theme_color_override("font_color", Color("#f5c842"))
	title.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.95))
	title.add_theme_constant_override("shadow_offset_x", 4)
	title.add_theme_constant_override("shadow_offset_y", 4)
	ui.add_child(title)

	var sub = Label.new()
	sub.text = "TOWER DEFENSE TAKTIS"
	sub.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sub.position = Vector2(0, 250)
	sub.size = Vector2(1280, 36)
	sub.add_theme_font_size_override("font_size", 22)
	sub.add_theme_color_override("font_color", Color("#d5e2f5"))
	sub.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.9))
	sub.add_theme_constant_override("shadow_offset_x", 2)
	sub.add_theme_constant_override("shadow_offset_y", 2)
	ui.add_child(sub)

	var audio_btn = button("Audio: " + ("Mute" if muted else "Aktif"), Vector2(1080, 24), func():
		toggle_audio()
		show_menu()
	, Vector2(160, 40))
	audio_btn.add_theme_font_size_override("font_size", 13)
	audio_btn.modulate = Color("#8a9bb5")

	var start_btn = button("MULAI", Vector2(520, 420), show_stages, Vector2(240, 62))
	start_btn.add_theme_font_size_override("font_size", 26)
	start_btn.modulate = Color("#4ade80")

func show_stages():
	make_screen("stages")
	compute_preview_layout()
	var vp = get_viewport_rect().size

	# ── Header ──────────────────────────────────────────────────────────────
	var header = ui_panel(Vector2(0, 0), Vector2(vp.x, 64), COL_PANEL_BORDER)
	var title_lbl = panel_label(header, "PILIH STAGE", Vector2(52, 10), 30)
	title_lbl.add_theme_color_override("font_color", COL_ACCENT)
	var sub_lbl = panel_label(header, "Klik stage untuk melihat detail peta", Vector2(52, 44), 13)
	sub_lbl.add_theme_color_override("font_color", COL_TEXT_DIM)

	# ── Kolom kiri: daftar stage ────────────────────────────────────────────
	var list_w   = 340.0
	var list_x   = 24.0
	var list_y   = 76.0
	var btn_h    = 46.0
	var btn_gap  = 8.0
	var list_panel = ui_panel(
		Vector2(list_x, list_y),
		Vector2(list_w, STAGES.size() * (btn_h + btn_gap) + 16.0),
		COL_PANEL_BORDER
	)
	list_panel.add_theme_stylebox_override("panel", card_box(Color("#0d1520"), COL_PANEL_BORDER))

	for index in STAGES.size():
		var data_s: Dictionary = STAGES[index]
		var is_selected = (index == stage_index)
		var at = Vector2(list_x + 8.0, list_y + 8.0 + index * (btn_h + btn_gap))
		var item = button(
			"%d.  %s" % [index + 1, data_s.name],
			at,
			preview_stage.bind(index),
			Vector2(list_w - 16.0, btn_h)
		)
		item.toggle_mode = true
		item.set_pressed_no_signal(is_selected)
		if is_selected:
			var sel_box = card_box(Color("#1a2c14"), COL_SUCCESS)
			sel_box.content_margin_left = 10
			item.add_theme_stylebox_override("normal", sel_box)
			item.add_theme_color_override("font_color", COL_SUCCESS)
		else:
			item.add_theme_color_override("font_color", COL_TEXT)

	# ── Kolom kanan: detail stage ───────────────────────────────────────────
	var right_x  = list_x + list_w + 16.0
	var right_w  = vp.x - right_x - 24.0
	var right_y  = list_y

	var data: Dictionary = STAGES[stage_index]
	var detail_panel = ui_panel(
		Vector2(right_x, right_y),
		Vector2(right_w, 100.0),
		COL_PANEL_BORDER
	)
	detail_panel.add_theme_stylebox_override("panel", card_box(Color("#0d1520"), COL_PANEL_BORDER))

	var detail_title = panel_label(detail_panel, "Stage %d  •  %s" % [stage_index + 1, data.name], Vector2(14, 10), 20)
	detail_title.add_theme_color_override("font_color", COL_ACCENT)

	var has_boss = stage_index in [2, 6]
	var detail_info = "3 Wave  •  3 Nyawa  •  Merah: Spawn  •  Biru: Base"
	if has_boss:
		detail_info += "  •  ⚠ Boss hadir"
	var detail_sub = panel_label(detail_panel, detail_info, Vector2(14, 40), 13)
	detail_sub.add_theme_color_override("font_color", COL_TEXT_DIM)

	var route_count = STAGES[stage_index].routes.size()
	var route_lbl = panel_label(detail_panel, "%d jalur musuh" % route_count, Vector2(14, 66), 13)
	route_lbl.add_theme_color_override("font_color", COL_TEXT_DIM)

	# ── Tombol bawah ────────────────────────────────────────────────────────
	var footer_y = vp.y - 64.0
	var footer = ui_panel(Vector2(0, footer_y), Vector2(vp.x, 64.0), COL_PANEL_BORDER)
	footer.add_theme_stylebox_override("panel", card_box(Color("#0a0f1a"), COL_PANEL_BORDER))
	var btn_back = button("← Kembali", Vector2(24, footer_y + 10), show_menu, Vector2(160, 44))
	btn_back.add_theme_color_override("font_color", COL_TEXT_DIM)
	var btn_squad = button("Pilih Squad →", Vector2(vp.x - 184.0, footer_y + 10), show_squad, Vector2(160, 44))
	btn_squad.add_theme_color_override("font_color", COL_SUCCESS)

func preview_stage(index: int):
	stage_index = index
	show_stages()


func compare_operators(a: int, b: int) -> bool:
	var role_a: int = ROLES[a]
	var role_b: int = ROLES[b]
	if role_a != role_b:
		return role_a < role_b
	return OPERATORS[a][0] < OPERATORS[b][0]

func select_squad_filter(role_idx: int):
	squad_filter_role = role_idx
	show_squad()

func get_squad_card_text(id: int, member: bool, slot_idx: int) -> String:
	var stats = OPERATORS[id]
	var role_name = ROLE_NAMES[ROLES[id]]
	var status = "[ ✓ DALAM SQUAD #%d ]" % (slot_idx + 1) if member else "[ + PILIH ]"
	return "%s  •  %s\n%s" % [stats[0], role_name, status]

func show_squad():
	make_screen("squad")
	squad_cards.clear()
	squad_tab_buttons.clear()
	squad.sort_custom(compare_operators)

	var vp = get_viewport_rect().size
	# Layout constants
	var HEADER_H  = 64.0
	var SLOT_H    = 72.0
	var DETAIL_H  = 120.0
	var FILTER_H  = 40.0
	var FOOTER_H  = 64.0
	var CARD_W    = 200.0
	var CARD_H    = 80.0
	var CARD_GAP  = 8.0
	var COLS      = 5
	var PAD       = 16.0

	# ── Header ──────────────────────────────────────────────────────────────
	var hdr = ui_panel(Vector2(0, 0), Vector2(vp.x, HEADER_H), COL_PANEL_BORDER)
	hdr.add_theme_stylebox_override("panel", card_box(Color("#0a0f1a"), COL_PANEL_BORDER))
	var hdr_title = panel_label(hdr, "PILIH SQUAD", Vector2(PAD, 8), 28)
	hdr_title.add_theme_color_override("font_color", COL_ACCENT)
	squad_count = panel_label(hdr, "", Vector2(PAD, 40), 13)
	squad_count.add_theme_color_override("font_color", COL_TEXT_DIM)

	# ── Squad slot bar (dibangun ulang tiap refresh) ────────────────────────
	var slot_y = HEADER_H + 4.0
	squad_slot_panel = ui_panel(Vector2(0, slot_y), Vector2(vp.x, SLOT_H), COL_PANEL_BORDER)
	squad_slot_panel.add_theme_stylebox_override("panel", card_box(Color("#0d1520"), COL_PANEL_BORDER))

	# ── Detail panel karakter yang sedang di-inspect ──────────────────────────
	if inspected < 0:
		inspected = squad[0] if not squad.is_empty() else 0
	var detail_y = slot_y + SLOT_H + 4.0
	var DETAIL_H_REAL = 110.0
	squad_detail_panel = ui_panel(Vector2(0, detail_y), Vector2(vp.x, DETAIL_H_REAL), COLORS[ROLES[inspected]])
	squad_detail_panel.add_theme_stylebox_override("panel", card_box(Color("#0f1826"), COLORS[ROLES[inspected]]))
	squad_detail_avatar = ui_avatar(squad_detail_panel, Vector2(PAD, 8), 90)
	var det_x = PAD + 100.0
	squad_detail_title = panel_label(squad_detail_panel, "", Vector2(det_x, 6), 20)
	squad_detail_role  = panel_label(squad_detail_panel, "", Vector2(det_x, 32), 13)
	squad_detail_stats = panel_label(squad_detail_panel, "", Vector2(det_x, 54), 12)
	squad_detail_stats.add_theme_color_override("font_color", COL_TEXT_DIM)
	squad_detail_skill = panel_label(squad_detail_panel, "", Vector2(det_x, 76), 12)
	squad_detail_skill.add_theme_color_override("font_color", COL_ACCENT)
	var badge_lbl = panel_label(squad_detail_panel, "", Vector2(vp.x - 230.0, 42), 14)
	badge_lbl.name = "SquadBadge"

	var filter_y = detail_y + DETAIL_H_REAL + 4.0
	var role_counts = [0, 0, 0, 0]
	for r in ROLES:
		role_counts[r] += 1
	var tabs_data = [
		{"role": -1, "title": "Semua", "color": COL_TEXT},
		{"role": 0,  "title": "Striker",   "color": COLORS[0]},
		{"role": 1,  "title": "Guardian",  "color": COLORS[1]},
		{"role": 2,  "title": "Caster",    "color": COLORS[2]},
		{"role": 3,  "title": "Supporter", "color": COLORS[3]},
	]
	var tab_w = 140.0
	var tab_gap = 6.0
	var tab_total = tabs_data.size() * tab_w + (tabs_data.size() - 1) * tab_gap
	var tab_x0 = floorf((vp.x - tab_total) * 0.5)
	for t in tabs_data.size():
		var td = tabs_data[t]
		var is_active = (squad_filter_role == td.role)
		var at = Vector2(tab_x0 + t * (tab_w + tab_gap), filter_y)
		var btn = button(td.title, at, select_squad_filter.bind(td.role), Vector2(tab_w, FILTER_H - 4))
		btn.add_theme_font_size_override("font_size", 13)
		btn.toggle_mode = true
		btn.set_pressed_no_signal(is_active)
		var tab_fill = Color(td.color, 0.22) if is_active else Color("#0d1520")
		var tab_border = td.color if is_active else COL_PANEL_BORDER
		var tab_box = card_box(tab_fill, tab_border)
		tab_box.set_border_width_all(2 if is_active else 1)
		btn.add_theme_stylebox_override("normal", tab_box)
		btn.add_theme_stylebox_override("hover", card_box(Color(td.color, 0.15), td.color.lightened(0.2)))
		btn.add_theme_color_override("font_color", td.color if is_active else COL_TEXT_DIM)
		squad_tab_buttons.append(btn)

	# ── Operator cards grid (scrollable) ─────────────────────────────────────
	var grid_y    = filter_y + FILTER_H + 6.0
	var grid_h    = vp.y - grid_y - FOOTER_H
	var scroll    = ScrollContainer.new()
	scroll.position = Vector2(0, grid_y)
	scroll.size     = Vector2(vp.x, grid_h)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.vertical_scroll_mode   = ScrollContainer.SCROLL_MODE_AUTO
	ui.add_child(scroll)
	var grid_content = Control.new()
	grid_content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(grid_content)

	var roles_to_show: Array[int] = []
	if squad_filter_role == -1:
		roles_to_show = [0, 1, 2, 3]
	else:
		roles_to_show = [squad_filter_role]

	var total_w = COLS * CARD_W + (COLS - 1) * CARD_GAP
	var grid_x0 = floorf((vp.x - total_w) * 0.5)
	var curr_y  = 6.0   # relative inside scroll content

	for r in roles_to_show:
		var role_ops: Array[int] = []
		for id in OPERATORS.size():
			if ROLES[id] == r:
				role_ops.append(id)
		role_ops.sort_custom(func(a: int, b: int) -> bool:
			return OPERATORS[a][0] < OPERATORS[b][0]
		)
		# Role header — added to scroll content
		var r_hdr       = Label.new()
		r_hdr.text      = "▸  %s  (%d)" % [ROLE_NAMES[r].to_upper(), role_ops.size()]
		r_hdr.position  = Vector2(grid_x0, curr_y)
		r_hdr.add_theme_font_size_override("font_size", 13)
		r_hdr.add_theme_color_override("font_color", COLORS[r])
		r_hdr.mouse_filter = Control.MOUSE_FILTER_IGNORE
		grid_content.add_child(r_hdr)
		curr_y += 22.0

		for i in role_ops.size():
			var op_id = role_ops[i]
			var col   = i % COLS
			var row   = floori(float(i) / COLS)
			var at    = Vector2(grid_x0 + col * (CARD_W + CARD_GAP), curr_y + row * (CARD_H + CARD_GAP))
			# build card inside scroll content instead of ui
			var card  = Button.new()
			card.position           = at
			card.custom_minimum_size = Vector2(CARD_W, CARD_H)
			card.size               = Vector2(CARD_W, CARD_H)
			card.toggle_mode        = true
			card.icon               = operator_portrait(op_id)
			card.expand_icon        = true
			card.alignment          = HORIZONTAL_ALIGNMENT_LEFT
			card.add_theme_font_size_override("font_size", 11)
			card.pressed.connect(inspect_operator.bind(op_id))
			grid_content.add_child(card)
			squad_cards[op_id] = card

		var num_rows = ceili(float(role_ops.size()) / COLS)
		curr_y += num_rows * (CARD_H + CARD_GAP) + 10.0

	# Update scroll content height so it scrolls correctly
	grid_content.custom_minimum_size = Vector2(vp.x, curr_y + 8.0)

	# ── Footer ────────────────────────────────────────────────────────────────
	var footer_y = vp.y - FOOTER_H
	var ftr = ui_panel(Vector2(0, footer_y), Vector2(vp.x, FOOTER_H), COL_PANEL_BORDER)
	ftr.add_theme_stylebox_override("panel", card_box(Color("#0a0f1a"), COL_PANEL_BORDER))
	var btn_back = button("← Kembali", Vector2(PAD, footer_y + 10), show_stages, Vector2(160, 44))
	btn_back.add_theme_color_override("font_color", COL_TEXT_DIM)
	squad_start = button(
		"▶  Masuk Stage %d" % (stage_index + 1),
		Vector2(vp.x - 200.0, footer_y + 10),
		start_battle, Vector2(184, 44)
	)
	squad_start.add_theme_color_override("font_color", COL_SUCCESS)
	refresh_squad()

func inspect_operator(id: int):
	inspected = id
	toggle_squad_member(id)
	refresh_squad()

func toggle_squad_member(id: int):
	if squad.has(id):
		squad.erase(id)
	elif squad.size() < MAX_SQUAD:
		squad.append(id)
		squad.sort_custom(compare_operators)
	refresh_squad()

func refresh_squad():
	var full = squad.size() == MAX_SQUAD
	# Header counter
	if is_instance_valid(squad_count):
		var status_txt = "Squad penuh!" if full else "Klik kartu operator untuk memilih / lepas"
		squad_count.text = "%d / %d operator dipilih  •  %s" % [squad.size(), MAX_SQUAD, status_txt]

	for id in squad_cards:
		var card: Button = squad_cards[id]
		if not is_instance_valid(card):
			continue
		var member = squad.has(id)
		var slot_idx = squad.find(id)
		# Card text: name + role on line 1, status on line 2
		var name_line = "%s  [%s]" % [OPERATORS[id][0], ROLE_NAMES[ROLES[id]]]
		var status_line: String
		if member:
			status_line = "✓  Slot %d  •  %d PT" % [slot_idx + 1, OPERATORS[id][3]]
		else:
			status_line = "+ Pilih  •  %d PT" % OPERATORS[id][3]
		card.text = name_line + "\n" + status_line
		card.set_pressed_no_signal(member)
		card.disabled = not member and full

		# Style: green tint if in squad, dimmed if full and not member, gold border if inspected
		var fill: Color
		var border: Color
		if id == inspected and member:
			fill   = Color("#1e3020")
			border = COL_ACCENT
		elif id == inspected:
			fill   = Color("#1e2a10")
			border = COL_ACCENT
		elif member:
			fill   = Color("#132210")
			border = COLORS[ROLES[id]]
		elif full:
			fill   = Color("#0f121a")
			border = Color("#1e2530")
		else:
			fill   = Color("#0d1520")
			border = COLORS[ROLES[id]].darkened(0.3)

		var normal_box = card_box(fill, border)
		card.add_theme_stylebox_override("normal", normal_box)
		card.add_theme_stylebox_override("hover", card_box(fill.lightened(0.08), border.lightened(0.2)))
		card.add_theme_color_override("font_color", COL_SUCCESS if member else (COL_TEXT_DIM if (full and not member) else COL_TEXT))
		card.add_theme_color_override("font_disabled_color", Color("#2a3040"))

	squad_start.disabled = squad.is_empty()
	rebuild_slot_bar()
	refresh_squad_detail()

func rebuild_slot_bar():
	if not is_instance_valid(squad_slot_panel):
		return
	# Hapus semua child lama
	for child in squad_slot_panel.get_children():
		child.queue_free()
	var vp    = get_viewport_rect().size
	var PAD   = 16.0
	var slot_btn_w   = 100.0
	var slot_btn_h   = 50.0
	var slot_gap     = 6.0
	var slot_total_w = MAX_SQUAD * slot_btn_w + (MAX_SQUAD - 1) * slot_gap
	var slot_x0      = floorf((vp.x - slot_total_w) * 0.5)

	var lbl = panel_label(squad_slot_panel,
		"SQUAD  %d/%d  •  Klik slot untuk hapus" % [squad.size(), MAX_SQUAD],
		Vector2(PAD, 5), 11)
	lbl.add_theme_color_override("font_color", COL_TEXT_DIM)

	for s in MAX_SQUAD:
		var sx        = slot_x0 + s * (slot_btn_w + slot_gap)
		var is_filled = s < squad.size()
		var sid       = squad[s] if is_filled else -1

		var slot_btn = Button.new()
		slot_btn.position          = Vector2(sx, 18)
		slot_btn.size              = Vector2(slot_btn_w, slot_btn_h)
		slot_btn.custom_minimum_size = Vector2(slot_btn_w, slot_btn_h)
		slot_btn.flat              = true

		if is_filled:
			# Karakter terpilih: border kuning emas
			var fill   = Color(COL_ACCENT, 0.12)
			var border = COL_ACCENT
			slot_btn.add_theme_stylebox_override("normal",  card_box(fill, border))
			slot_btn.add_theme_stylebox_override("hover",   card_box(Color(COL_ACCENT, 0.25), Color("#ffffff")))
			slot_btn.pressed.connect(func():
				squad.erase(sid)
				inspected = sid
				refresh_squad()
			)
		else:
			slot_btn.add_theme_stylebox_override("normal", card_box(Color("#0a1020"), COL_PANEL_BORDER))
			slot_btn.add_theme_stylebox_override("hover",  card_box(Color("#141c2b"), COL_ACCENT))

		squad_slot_panel.add_child(slot_btn)

		if is_filled:
			var av = ui_avatar(slot_btn, Vector2(2, 3), 44)
			av.texture = operator_portrait(sid)
			var sname = panel_label(slot_btn, OPERATORS[sid][0], Vector2(48, 6), 10)
			sname.add_theme_color_override("font_color", COL_ACCENT)
			var srole = panel_label(slot_btn, ROLE_NAMES[ROLES[sid]], Vector2(48, 24), 9)
			srole.add_theme_color_override("font_color", COL_TEXT_DIM)
		else:
			var empty_lbl = panel_label(slot_btn, "slot %d" % (s + 1), Vector2(10, 17), 10)
			empty_lbl.add_theme_color_override("font_color", Color("#3a4558"))

func refresh_squad_detail():
	if not is_instance_valid(squad_detail_panel):
		return
	var accent = COLORS[ROLES[inspected]]
	squad_detail_panel.add_theme_stylebox_override("panel", card_box(Color("#0f1826"), accent))
	set_avatar(squad_detail_avatar, inspected)
	squad_detail_title.text = OPERATORS[inspected][0]
	squad_detail_role.text = "%s  •  COST %d PT" % [ROLE_NAMES[ROLES[inspected]].to_upper(), OPERATORS[inspected][3]]
	squad_detail_role.add_theme_color_override("font_color", accent)
	squad_detail_stats.text = operator_line(inspected)
	squad_detail_skill.text = "⚡  Skill: %s" % SKILL_NAMES[inspected]
	var badge = squad_detail_panel.get_node_or_null("SquadBadge")
	if badge:
		if squad.has(inspected):
			badge.text = "✓  Dalam Squad  (Slot %d)" % (squad.find(inspected) + 1)
			badge.add_theme_color_override("font_color", COL_SUCCESS)
		else:
			var full = squad.size() == MAX_SQUAD
			badge.text = "Squad penuh" if full else "—  Belum Dipilih"
			badge.add_theme_color_override("font_color", COL_DANGER if full else COL_TEXT_DIM)

func start_battle():
	make_screen("battle")
	compute_battle_layout()
	units.clear()
	enemies.clear()
	boss = {}
	effects.clear()
	cards.clear()
	card_plain.clear()
	cooldowns.resize(OPERATORS.size())
	cooldowns.fill(0.0)
	clock = 0.0
	points = 10.0
	lives = 3
	wave = 0
	spawn_index = 0
	speed = 1.0
	paused = false
	chosen = -1
	selected = -1
	pending = Vector2i(-1, -1)
	hud = label("", Vector2(18, 20), 20)
	hint = label("", Vector2(18, 52), 13)
	boss_label = label("", Vector2(18, 72), 12)
	card_gold = card_box(Color("#2a2413"), COL_ACCENT)
	unit_panel = ui_panel(Vector2(18, 92), Vector2(260, 96), COL_PANEL_BORDER)
	unit_avatar = ui_avatar(unit_panel, Vector2(10, 10), 76)
	unit_title = panel_label(unit_panel, "", Vector2(94, 8), 17)
	unit_role = panel_label(unit_panel, "", Vector2(94, 32), 12)
	unit_stats = panel_label(unit_panel, "", Vector2(94, 52), 11)
	unit_skill = panel_label(unit_panel, "", Vector2(94, 70), 11)
	unit_stats.modulate = COL_TEXT_DIM
	unit_skill.modulate = COL_ACCENT
	var audio_button = button("Audio", Vector2(440, 20), toggle_audio, Vector2(80, 36))
	audio_button.toggle_mode = true
	audio_button.set_pressed_no_signal(not muted)
	var pause_button = button("Jeda", Vector2(440, 60), toggle_pause, Vector2(80, 36))
	pause_button.pressed.connect(func(): pause_button.text = "Lanjut" if paused else "Jeda")
	var speed_button = button("1×", Vector2(440, 100), toggle_speed, Vector2(80, 36))
	speed_button.pressed.connect(func(): speed_button.text = "2×" if speed == 2.0 else "1×")
	for i in squad.size():
		var card = button("", Vector2(18, 640), choose.bind(squad[i]), Vector2(200, 92))
		card_plain.append(skin_card(card, COLORS[ROLES[squad[i]]]))
		avatar_card(card, squad[i], 11)
		card.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
		cards.append(card)
	skill_button = button("Skill", Vector2(18, 600), activate_skill, Vector2(124, 40))
	retreat_button = button("Retreat", Vector2(152, 600), retreat, Vector2(124, 40))
	unit_info = label("", Vector2(292, 608), 14)
	layout_battle_ui()
	refresh_hud()

func layout_battle_ui():
	if screen != "battle":
		return
	var vp = get_viewport_rect().size
	var band = ORIGIN.y + float(CELL) * 7.0
	var row_h = clampf(vp.y - band - 16.0, 64.0, 96.0)
	var card_top = maxf(band + 44.0, vp.y - row_h - 8.0)
	var gap = 9.0
	var count = maxi(squad.size(), 1)
	var card_w = minf(210.0, (vp.x - 36.0 - gap * float(count - 1)) / float(count))
	var strip_w = card_w * float(count) + gap * float(count - 1)
	var x0 = floorf((vp.x - strip_w) * 0.5)
	for slot in cards.size():
		if not is_instance_valid(cards[slot]):
			continue
		cards[slot].custom_minimum_size = Vector2(card_w, row_h)
		cards[slot].size = Vector2(card_w, row_h)
		cards[slot].position = Vector2(x0 + float(slot) * (card_w + gap), card_top)
	if is_instance_valid(skill_button):
		skill_button.position = Vector2(x0, band + 6.0)
	if is_instance_valid(retreat_button):
		retreat_button.position = Vector2(x0 + 134.0, band + 6.0)
	if is_instance_valid(unit_info):
		unit_info.position = Vector2(x0 + 274.0, band + 14.0)

func on_viewport_resized():
	if screen == "battle":
		compute_battle_layout()
		layout_battle_ui()
	elif screen == "stages":
		compute_preview_layout()
	queue_redraw()

func toggle_pause():
	paused = not paused

func toggle_speed():
	speed = 2.0 if speed == 1.0 else 1.0

func can_deploy(id: int) -> bool:
	return squad.has(id) and not units.has(id) and cooldowns[id] <= 0.0 and points >= OPERATORS[id][3]

func choose(id: int):
	if can_deploy(id):
		chosen = id
		selected = -1
		pending = Vector2i(-1, -1)

func grid_position(world: Vector2) -> Vector2i:
	return Vector2i(((world - ORIGIN) / CELL).floor())

func center(tile: Vector2i) -> Vector2:
	return ORIGIN + (Vector2(tile) + Vector2(0.5, 0.5)) * CELL

func valid_tile(tile: Vector2i, id: int) -> bool:
	var map: Array = STAGES[stage_index].map
	if tile.y < 0 or tile.y >= map.size() or tile.x < 0 or tile.x >= map[tile.y].length():
		return false
	if map[tile.y][tile.x] != ("." if ROLES[id] < 2 else "H"):
		return false
	for unit in units.values():
		if unit.tile == tile:
			return false
	return true

func direction(world: Vector2) -> Vector2i:
	var offset = world - center(pending)
	if absf(offset.x) >= absf(offset.y):
		return Vector2i.LEFT if offset.x < 0 else Vector2i.RIGHT
	return Vector2i.UP if offset.y < 0 else Vector2i.DOWN

func _input(event: InputEvent):
	if screen != "battle":
		return
	if event.is_action_pressed("ui_cancel") or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed):
		chosen = -1
		pending = Vector2i(-1, -1)
		selected = -1
		return
	if pending.x >= 0 and event is InputEventMouseMotion:
		if event.position.distance_to(center(pending)) > 12.0:
			facing = direction(event.position)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and chosen >= 0 and pending.x < 0:
		var tile = grid_position(event.position)
		if valid_tile(tile, chosen):
			pending = tile
			facing = Vector2i.RIGHT

func _unhandled_input(event: InputEvent):
	if screen != "battle" or not event is InputEventMouseButton or event.button_index != MOUSE_BUTTON_LEFT or not event.pressed:
		return
	if pending.x >= 0 and chosen >= 0:
		if event.position.distance_to(center(pending)) > 12.0:
			facing = direction(event.position)
		deploy()
	elif chosen < 0:
		selected = -1
		for id in units:
			if units[id].tile == grid_position(event.position):
				selected = id
				break

func deploy():
	if not can_deploy(chosen) or not valid_tile(pending, chosen):
		return
	var stats = OPERATORS[chosen]
	points -= stats[3]
	units[chosen] = {"tile": pending, "dir": facing, "hp": float(stats[1]), "sp": 0.0, "skill": 0.0, "attack": 0.0, "tick": 0.0, "shield": 0.0, "shield_time": 0.0, "stun": 0.0, "guard_target": -1}
	play_sound("deploy")
	selected = chosen
	chosen = -1
	pending = Vector2i(-1, -1)

func remove_unit(id: int):
	if units.has(BASTIRA) and units[BASTIRA].guard_target == id:
		units[BASTIRA].guard_target = -1
	units.erase(id)
	cooldowns[id] = 40.0
	for enemy in enemies:
		if enemy.blocker == id:
			enemy.blocker = -1
	if selected == id:
		selected = -1

func retreat():
	if units.has(selected):
		remove_unit(selected)

func in_range(id: int, tile: Vector2i, origin: Vector2i, dir: Vector2i, skill_active := false) -> bool:
	var offset = tile - origin
	if ROLES[id] == 3:
		return absi(offset.x) + absi(offset.y) <= 2
	var forward = offset.x * dir.x + offset.y * dir.y
	var side = absi(offset.y * dir.x - offset.x * dir.y)
	if ROLES[id] < 2:
		return side == 0 and (forward == 1 or (id == RAVIKA and skill_active and forward == -1))
	if id == ASTERIN and skill_active:
		return forward >= 1 and forward <= 5 and side == 0
	return forward >= 1 and forward <= 3 and side <= 1

func enemy_in_range(id: int, unit: Dictionary, enemy: Dictionary) -> bool:
	return enemy.blocker == id or in_range(id, grid_position(enemy.pos), unit.tile, unit.dir, unit.skill > 0.0)

func activate_skill():
	if not units.has(selected):
		return
	var unit: Dictionary = units[selected]
	if unit.sp < OPERATORS[selected][4] or unit.skill > 0.0 or unit.stun > 0.0:
		return
	if selected == BASTIRA:
		var target = -1
		var lowest = INF
		for id in units:
			var offset = Vector2i(units[id].tile) - Vector2i(unit.tile)
			var ratio = units[id].hp / float(OPERATORS[id][1])
			if id != BASTIRA and absi(offset.x) + absi(offset.y) <= 2 and ratio < lowest:
				target = id
				lowest = ratio
		if target < 0:
			return
		unit.guard_target = target
		flash(center(unit.tile), center(units[target].tile), operator_effect_color(BASTIRA))
	elif selected == TAVIRA:
		var target = -1
		var longest = 0.0
		for id in squad:
			if cooldowns[id] > longest:
				target = id
				longest = cooldowns[id]
		if target < 0:
			return
		cooldowns[target] = maxf(0.0, longest - 12.0)
	unit.sp = float(OPERATORS[selected][4])
	unit.skill = OPERATORS[selected][5]
	play_sound("skill")
	if selected == 1:
		for enemy in enemies:
			if enemy_in_range(selected, unit, enemy):
				enemy.stun = 5.0
	elif selected == 4:
		unit.tick = 1.0
	elif selected == 9:
		for id in units:
			var ally: Dictionary = units[id]
			if in_range(9, ally.tile, unit.tile, unit.dir):
				ally.shield = float(OPERATORS[id][1]) * 0.30
				ally.shield_time = unit.skill

func route(lane: int) -> Array[Vector2i]:
	var waypoints: Array = STAGES[stage_index].routes[lane]
	var tile: Vector2i = waypoints[0]
	var path: Array[Vector2i] = [tile]
	for i in range(1, waypoints.size()):
		var next: Vector2i = waypoints[i]
		var step: Vector2i = (next - tile).sign()
		while tile != next:
			tile += step
			path.append(tile)
	return path

func spawn_enemy(entry: Array):
	var path = route(entry[0])
	var ranged: bool = entry[1]
	var boss_kind = int(entry[2]) if entry.size() > 2 else 0
	var is_boss = boss_kind > 0
	var hp = 460.0 if ranged else 570.0
	if is_boss:
		hp = 7600.0 if boss_kind == 2 else 5400.0
	var enemy = {"path": path, "next": 1, "pos": center(path[0]), "hp": hp, "max_hp": hp, "ranged": ranged, "blocker": -1, "attack": 0.0, "windup": 0.0, "target": -1, "stun": 0.0, "boss": is_boss, "boss_kind": boss_kind, "pulse": (12.0 if boss_kind == 2 else 15.0), "fracture": 0.0}
	enemies.append(enemy)
	if is_boss:
		boss = enemy
		play_sound("impact")


func process_waves():
	var waves: Array = STAGES[stage_index].waves
	while wave < waves.size():
		var data: Array = waves[wave]
		if clock < float(data[0]) + spawn_index * 1.5:
			return
		spawn_enemy(data[1][spawn_index])
		spawn_index += 1
		if spawn_index == data[1].size():
			spawn_index = 0
			wave += 1

func damage_unit(id: int, damage: float):
	if not units.has(id):
		return
	var unit: Dictionary = units[id]
	if id == TARIAN and unit.skill > 0.0:
		damage *= 0.75
	var absorbed = minf(damage, unit.shield)
	unit.shield -= absorbed
	unit.hp -= damage - absorbed
	if units[id].hp <= 0.0:
		remove_unit(id)

func hit_unit(enemy: Dictionary, id: int, damage: float):
	if id == 5 and units.has(id) and units[id].skill > 0.0:
		enemy.hp -= damage * 0.5
	if id != BASTIRA and units.has(BASTIRA) and units[BASTIRA].skill > 0.0 and units[BASTIRA].guard_target == id:
		damage_unit(BASTIRA, damage * 0.5)
		damage *= 0.5
	damage_unit(id, damage)

func find_ranged_target(pos: Vector2) -> int:
	var best = -1
	var nearest = CELL * 2.25
	for id in units:
		var distance = pos.distance_to(center(units[id].tile))
		if distance <= nearest:
			best = id
			nearest = distance
	return best

func boss_pulse(enemy: Dictionary, dt: float):
	enemy.pulse = maxf(0.0, enemy.pulse - dt)
	if enemy.pulse > 0.0:
		return
	if enemy.boss_kind == 2:
		enemy.pulse = 12.0
		for id in units.keys():
			if enemy.pos.distance_to(center(units[id].tile)) <= CELL * 2.0:
				flash(enemy.pos, center(units[id].tile), Color("#ff856a"))
				hit_unit(enemy, id, 240.0)
		play_sound("impact")
		return
	enemy.pulse = 15.0
	var nearest = INF
	var target = -1
	for id in units:
		var distance = enemy.pos.distance_squared_to(center(units[id].tile))
		if distance < nearest:
			nearest = distance
			target = id
	if target >= 0:
		units[target].stun = 3.0
		flash(enemy.pos, center(units[target].tile), Color("#f7d170"))
		play_sound("impact")

func move_enemy(enemy: Dictionary, dt: float):
	if enemy.stun > 0.0:
		enemy.stun = maxf(0.0, enemy.stun - dt)
		return
	if enemy.boss:
		boss_pulse(enemy, dt)
	enemy.attack = maxf(0.0, enemy.attack - dt)
	if enemy.windup > 0.0:
		enemy.windup = maxf(0.0, enemy.windup - dt)
		if enemy.windup == 0.0:
			hit_unit(enemy, enemy.target, 115.0)
			enemy.attack = 2.4
		return
	if enemy.blocker >= 0:
		if enemy.attack == 0.0:
			enemy.attack = 1.2
			var dmg = (260.0 if enemy.boss_kind == 2 else 210.0) if enemy.boss else (115.0 if enemy.ranged else 100.0)
			hit_unit(enemy, enemy.blocker, dmg)
		return
	if enemy.ranged and enemy.attack == 0.0:
		enemy.target = find_ranged_target(enemy.pos)
		if enemy.target >= 0:
			enemy.windup = 0.9
			return
	var destination = center(enemy.path[enemy.next])
	enemy.pos = enemy.pos.move_toward(destination, dt * (30.0 if enemy.boss else (53.0 if enemy.ranged else 55.0)))
	for id in units:
		if ROLES[id] >= 2 or enemy.pos.distance_to(center(units[id].tile)) > CELL * 0.37:
			continue
		var blocked = 0
		for other in enemies:
			if other.blocker == id and other.hp > 0.0:
				blocked += 1
		var extra = 2 if id == TARIAN and units[id].skill > 0.0 else 0
		if blocked < OPERATORS[id][7] + extra:
			enemy.blocker = id
			return
	if enemy.pos == destination:
		enemy.next += 1
		if enemy.next == enemy.path.size():
			lives = maxi(0, lives - (3 if enemy.boss else 1))
			play_sound("impact")
			if enemy.boss:
				boss = {}
			enemies.erase(enemy)

func distance_to_base(enemy: Dictionary) -> float:
	return float(enemy.path.size() - enemy.next - 1) * CELL + enemy.pos.distance_to(center(enemy.path[enemy.next]))

func tick_ionia(unit: Dictionary, dt: float):
	unit.tick -= dt
	while unit.tick <= 0.0:
		unit.tick += 1.0
		for enemy in enemies:
			var offset = grid_position(enemy.pos) - Vector2i(unit.tile)
			var dir: Vector2i = unit.dir
			var forward = offset.x * dir.x + offset.y * dir.y
			var side = offset.y * dir.x - offset.x * dir.y
			if enemy.hp > 0.0 and side == 0 and forward >= 1 and forward <= 3:
				enemy.hp -= float(OPERATORS[4][2]) * 0.4 * team_attack_multiplier()
				flash(center(unit.tile), enemy.pos, COLORS[ROLES[4]])

func team_attack_multiplier() -> float:
	return 1.25 if units.has(7) and units[7].skill > 0.0 else 1.0

func attack_or_heal(id: int, unit: Dictionary):
	var amount = float(OPERATORS[id][2]) * team_attack_multiplier()
	if ROLES[id] == 3:
		var target = -1
		var lowest = 1.0
		for ally in units:
			var ratio = units[ally].hp / float(OPERATORS[ally][1])
			if ratio < lowest and in_range(id, units[ally].tile, unit.tile, unit.dir):
				target = ally
				lowest = ratio
		if target < 0:
			return
		units[target].hp = minf(float(OPERATORS[target][1]), units[target].hp + amount * (2.0 if id == 3 and unit.skill > 0.0 else 1.0))
		flash(center(unit.tile), center(units[target].tile), COLORS[ROLES[id]])
		play_sound("heal_%d" % (3 if id == TAVIRA else id))
	else:
		var targets: Array[Dictionary] = []

		for enemy in enemies:
			if enemy.hp <= 0.0 or not enemy_in_range(id, unit, enemy):
				continue
			targets.append(enemy)
		if targets.is_empty():
			return
		play_sound("atk_%d" % ([1, 5, 0][id - BASTIRA] if id >= BASTIRA else id))
		targets.sort_custom(func(a, b): return distance_to_base(a) < distance_to_base(b))
		var count = mini(targets.size(), 3) if id == 6 and unit.skill > 0.0 else 1
		if id == RAVIKA and unit.skill > 0.0:
			count = mini(targets.size(), 2)
		if id == 0 and unit.skill > 0.0:
			amount *= 1.5
		if id == 8 and unit.skill > 0.0:
			amount *= 1.3
		for index in count:
			var target: Dictionary = targets[index]
			var damage = amount * (0.75 if id == RAVIKA and index == 1 else 1.0)
			if id == ASTERIN and unit.skill > 0.0:
				var offset = grid_position(target.pos) - Vector2i(unit.tile)
				if absi(offset.x) + absi(offset.y) >= 4:
					damage *= 1.4
			damage = basic_hit(id, target, damage)
			var actual_damage = minf(target.hp, damage)
			target.hp -= damage
			if id == VIRELDA and unit.skill > 0.0 and target.hp > 0.0:
				target.fracture = 5.0
			if id == KAELITH and unit.skill > 0.0:
				chain_lightning(target, amount)
			flash(center(unit.tile), target.pos, COLORS[ROLES[id]])
			if id == 8 and unit.skill > 0.0:
				unit.hp = minf(float(OPERATORS[id][1]), unit.hp + actual_damage * 0.30)
			if id == 2 and unit.skill > 0.0:
				for enemy in enemies:
					if enemy.hp > 0.0 and not is_same(enemy, target) and grid_position(enemy.pos).distance_to(grid_position(target.pos)) <= 1.42:
						enemy.hp -= basic_hit(id, enemy, amount)
						flash(target.pos, enemy.pos, COLORS[ROLES[id]])
	unit.attack = float(OPERATORS[id][6]) / (1.5 if id == 0 and unit.skill > 0.0 else 1.0)

func basic_hit(id: int, enemy: Dictionary, damage: float) -> float:
	return damage * 1.2 if id != VIRELDA and enemy.fracture > 0.0 else damage

func chain_lightning(first: Dictionary, amount: float):
	var struck: Array[Dictionary] = [first]
	var previous = first
	for factor in [0.65, 0.40]:
		var next: Dictionary = {}
		var nearest = 3
		for enemy in enemies:
			if enemy.hp <= 0.0 or struck.any(func(hit): return is_same(hit, enemy)):
				continue
			var offset = grid_position(enemy.pos) - grid_position(previous.pos)
			var distance = absi(offset.x) + absi(offset.y)
			if distance < nearest:
				nearest = distance
				next = enemy
		if next.is_empty():
			return
		next.hp -= basic_hit(KAELITH, next, amount * factor)
		flash(previous.pos, next.pos, Color("#c8a4ff"))
		struck.append(next)
		previous = next

func flash(from: Vector2, to: Vector2, color: Color):
	effects.append({"from": from, "to": to, "color": color, "time": 0.18})

func _process(delta: float):
	if screen != "battle":
		return
	if not paused:
		simulate(minf(delta, 0.1) * speed * (0.25 if chosen >= 0 else 1.0))
	if screen == "battle":
		refresh_hud()
		queue_redraw()

func simulate(dt: float):
	var waves: Array = STAGES[stage_index].waves
	clock += dt
	points = minf(99.0, points + dt * 2.0)
	for i in cooldowns.size():
		cooldowns[i] = maxf(0.0, cooldowns[i] - dt)
	for effect in effects.duplicate():
		effect.time -= dt
		if effect.time <= 0.0:
			effects.erase(effect)
	process_waves()
	for enemy in enemies:
		enemy.fracture = maxf(0.0, enemy.fracture - dt)
	for id in units:
		var unit: Dictionary = units[id]
		if unit.shield_time > 0.0:
			unit.shield_time = maxf(0.0, unit.shield_time - dt)
			if unit.shield_time == 0.0:
				unit.shield = 0.0
		if unit.skill > 0.0:
			if id == 4:
				tick_ionia(unit, minf(dt, unit.skill))
			unit.skill = maxf(0.0, unit.skill - dt)
			if id == TARIAN and unit.skill == 0.0:
				var kept = 0
				for enemy in enemies:
					if enemy.blocker == id and enemy.hp > 0.0:
						kept += 1
						if kept > OPERATORS[id][7]:
							enemy.blocker = -1
			unit.sp = float(OPERATORS[id][4]) * (unit.skill / OPERATORS[id][5])
		else:
			unit.sp = minf(float(OPERATORS[id][4]), unit.sp + dt)
		if unit.stun > 0.0:
			unit.stun = maxf(0.0, unit.stun - dt)
			continue
		unit.attack = maxf(0.0, unit.attack - dt)
		if unit.attack == 0.0:
			attack_or_heal(id, unit)
	for enemy in enemies.duplicate():
		if enemy.hp <= 0.0:
			if enemy.boss:
				boss = {}
			enemies.erase(enemy)
			points = minf(99.0, points + 1.0)
		else:
			move_enemy(enemy, dt)
	if lives == 0 or (wave == waves.size() and enemies.is_empty()):
		show_results(lives > 0)

func refresh_unit_panel():
	var focus = -1
	var anchor = Vector2(192, 640)
	if chosen >= 0:
		focus = chosen
		if pending.x >= 0:
			anchor = center(pending)
		else:
			var slot = squad.find(chosen)
			if slot >= 0 and slot < cards.size():
				anchor = cards[slot].position + Vector2(cards[slot].size.x * 0.5, -4.0)
	elif selected >= 0 and units.has(selected):
		focus = selected
		anchor = center(units[selected].tile)
	if focus < 0:
		unit_panel.visible = false
		return
	unit_panel.visible = true
	var accent = COLORS[ROLES[focus]]
	set_avatar(unit_avatar, focus)
	unit_panel.add_theme_stylebox_override("panel", card_box(Color(0.07, 0.1, 0.16, 0.95), accent))
	unit_title.text = OPERATORS[focus][0]
	unit_role.text = ROLE_NAMES[ROLES[focus]].to_upper()
	unit_role.add_theme_color_override("font_color", accent)
	unit_stats.text = "HP %d / %d  •  ATK %d  •  COST %d" % [ceili(units[focus].hp), OPERATORS[focus][1], OPERATORS[focus][2], OPERATORS[focus][3]] if units.has(focus) else operator_line(focus)
	unit_skill.text = "Skill: %s" % SKILL_NAMES[focus]
	var vp = get_viewport_rect().size
	unit_panel.position = Vector2(clampf(anchor.x - 130.0, 6.0, vp.x - 266.0), clampf(anchor.y - 108.0, 96.0, ORIGIN.y + float(CELL) * 7.0 - 100.0))

func refresh_hud():
	var waves: Array = STAGES[stage_index].waves
	boss_label.text = "" if boss.is_empty() else "%s  •  %d / %d HP" % ["Raja Reruntuhan" if boss.boss_kind == 2 else "Komandan Benteng", ceili(boss.hp), boss.max_hp]
	var remaining = enemies.size() - spawn_index
	for i in range(wave, waves.size()):
		remaining += waves[i][1].size()
	hud.text = "POINT  %02d  •  Nyawa  %d  •  Wave  %d/%d  •  Musuh  %d" % [floori(points), lives, mini(wave + int(spawn_index > 0), waves.size()), waves.size(), remaining]
	hint.text = "Pilih atau seret kartu ke tile. Klik unit untuk Skill atau Retreat."
	if chosen >= 0:
		hint.text = "Pilih tile hijau. Klik kanan atau Esc untuk batal." if pending.x < 0 else "Arahkan kursor lalu klik untuk deploy. Klik kanan atau Esc untuk batal."
	if paused:
		hint.text = "Dijeda  •  " + hint.text
	for slot in cards.size():
		var i: int = squad[slot]
		var status = "%d PT" % OPERATORS[i][3]
		if units.has(i):
			status = "DI MEDAN"
		elif cooldowns[i] > 0.0:
			status = "TUNGGU %ds" % ceili(cooldowns[i])
		cards[slot].text = OPERATORS[i][0] + "\n" + status
		cards[slot].disabled = not can_deploy(i)
		cards[slot].add_theme_stylebox_override("normal", card_gold if chosen == i or selected == i else card_plain[slot])
	skill_button.disabled = not units.has(selected) or units[selected].sp < OPERATORS[selected][4] or units[selected].stun > 0.0
	retreat_button.disabled = not units.has(selected)
	refresh_unit_panel()
	skill_button.text = "Skill  %d/%d" % [floori(units[selected].sp), OPERATORS[selected][4]] if units.has(selected) else "Skill"
	if units.has(selected):
		var su: Dictionary = units[selected]
		unit_info.text = "%s  •  HP %d/%d  •  ATK %d  •  %s" % [OPERATORS[selected][0], ceili(su.hp), OPERATORS[selected][1], OPERATORS[selected][2], ROLE_NAMES[ROLES[selected]]]
	else:
		unit_info.text = ""

func show_results(won: bool):
	make_screen("results")
	play_sound("win" if won else "lose")
	var stars = 3 if lives == 3 else (2 if lives >= 2 else 1)
	if won:
		# Grand victory panel
		label("VICTORY", Vector2(72, 120), 78)
		label(STAGES[stage_index].name, Vector2(78, 210), 26)
		label("%s" % ("★".repeat(stars) + "☆".repeat(3 - stars)), Vector2(78, 260), 46)
		label("%d / 3 nyawa tersisa" % lives, Vector2(78, 320), 22)
		label("Pertahanan bertahan. Ark aman.", Vector2(78, 355), 18)
		button("Ulangi", Vector2(78, 420), start_battle, Vector2(200, 56))
		button("Pilih Stage", Vector2(300, 420), show_stages, Vector2(200, 56))
	else:
		# Dramatic defeat panel
		label("DEFEAT", Vector2(72, 120), 78)
		label(STAGES[stage_index].name, Vector2(78, 210), 26)
		label("Base jatuh  •  Nyawa habis", Vector2(78, 260), 26)
		label("Garis pertahanan ditembus musuh.", Vector2(78, 300), 18)
		button("Ulangi", Vector2(78, 360), start_battle, Vector2(200, 56))
		button("Pilih Stage", Vector2(300, 360), show_stages, Vector2(200, 56))

func bar(at: Vector2, width: float, fraction: float, color: Color):
	draw_rect(Rect2(at, Vector2(width, 4)), Color("#1b2130"))
	draw_rect(Rect2(at, Vector2(width * clampf(fraction, 0.0, 1.0), 4)), color)

func _draw():
	draw_rect(Rect2(Vector2.ZERO, get_viewport_rect().size), COL_BG)
	if screen == "menu" and menu_bg_texture:
		var vp_size = get_viewport_rect().size
		var tex_size = menu_bg_texture.get_size()
		var scale_factor = maxf(vp_size.x / tex_size.x, vp_size.y / tex_size.y)
		var draw_size = tex_size * scale_factor
		var draw_pos = (vp_size - draw_size) * 0.5
		draw_texture_rect(menu_bg_texture, Rect2(draw_pos, draw_size), false)
	if screen != "battle" and screen != "stages" and screen != "menu":
		return
	if screen == "menu":
		return
	var map: Array = STAGES[stage_index].map
	for y in map.size():
		for x in map[y].length():
			var tile = Vector2i(x, y)
			var at = ORIGIN + Vector2(tile) * CELL
			var kind: String = map[y][x]
			var tex: Texture2D = tile_textures.get(kind)
			if tex:
				draw_texture_rect(tex, Rect2(at, Vector2(CELL - 2, CELL - 2)), false)
			else:
				var color = COL_PANEL
				match kind:
					".": color = COL_TILE_PATH
					"H": color = COL_TILE_HIGH
					"R": color = COL_TILE_SPAWN
					"B": color = COL_TILE_BASE
					"#": color = COL_PANEL
				draw_rect(Rect2(at, Vector2.ONE * (CELL - 2)), color)
			if kind == "H":
				draw_rect(Rect2(at + Vector2(0, CELL - 10), Vector2(CELL - 2, 8)), Color("#465769"))
			# Deployment highlight overlay
			if chosen >= 0 and screen == "battle" and (kind == "." or kind == "H"):
				var marker = Color(0.25, 0.96, 0.57, 0.27) if valid_tile(tile, chosen) else Color(1.0, 0.25, 0.34, 0.19)
				draw_rect(Rect2(at, Vector2.ONE * (CELL - 2)), marker)
			if screen == "battle" and pending.x >= 0 and in_range(chosen, tile, pending, facing):
				draw_rect(Rect2(at + Vector2.ONE * 4, Vector2.ONE * (CELL - 10)), Color("#f7d170"), false, 3)
			if screen == "battle" and selected >= 0 and units.has(selected) and in_range(selected, tile, units[selected].tile, units[selected].dir):
				draw_rect(Rect2(at + Vector2.ONE * 4, Vector2.ONE * (CELL - 10)), Color("#74c0fc"), false, 2)
	if screen != "battle":
		return
	bar(Vector2(18, 46), 120, fposmod(points, 1.0) if points < 99.0 else 1.0, Color("#f7d170"))
	if not boss.is_empty():
		bar(Vector2(18, 92), 260, boss.hp / boss.max_hp, Color("#ff735f"))
	if pending.x >= 0:
		var preview: Texture2D = operator_portrait(chosen)
		draw_chibi(preview, center(pending), CELL * 0.90, facing == Vector2i.LEFT, Color(operator_tint(chosen), 0.7))
		draw_line(center(pending), center(pending) + Vector2(facing) * 28, Color.WHITE, 4)
	for id in units:
		var unit: Dictionary = units[id]
		var at = center(unit.tile)
		# Ground shadow and role disc under the feet
		draw_circle(at + Vector2(0, CELL * 0.30), CELL * 0.24, Color(0, 0, 0, 0.35))
		draw_circle(at + Vector2(0, CELL * 0.30), CELL * 0.21, Color(COLORS[ROLES[id]], 0.5))
		# Body
		var portrait: Texture2D = operator_portrait(id)
		draw_chibi(portrait, at, CELL * 0.90, unit.dir == Vector2i.LEFT, operator_tint(id))
		# Facing arrow
		draw_line(at, at + Vector2(unit.dir) * 26, Color.WHITE, 3)
		draw_circle(at + Vector2(unit.dir) * 26, 4, Color.WHITE)
		# Status rings
		if unit.shield > 0.0:
			draw_arc(at, 34, 0, TAU, 32, Color("#85dfff"), 3.0, true)
		if unit.stun > 0.0:
			draw_arc(at, 37, 0, TAU, 32, COL_ACCENT, 4.0, true)
		if selected == id:
			draw_arc(at, 32, 0, TAU, 32, Color("#ffffff", 0.6), 2.0, true)
		if unit.skill > 0.0:
			var pulse = 0.5 + 0.5 * sin(Time.get_ticks_msec() * 0.01)
			draw_arc(at, 34, 0, TAU, 32, Color("#f5c842", 0.9), 3.0 + pulse, true)
			draw_arc(at, 38, 0, TAU, 32, Color("#f5c842", 0.35), 1.5, true)
			draw_string(ThemeDB.fallback_font, at + Vector2(-6, -44), "★", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color("#f5c842"))
		# Bars
		bar(at + Vector2(-24, -40), 48, unit.hp / OPERATORS[id][1], COL_SUCCESS)
		bar(at + Vector2(-24, -33), 48, unit.sp / OPERATORS[id][4], COL_ACCENT)
	for enemy in enemies:
		var sprite_kind = 2 if enemy.boss else (1 if enemy.ranged else 0)
		var size = CELL * (0.95 if enemy.boss else 0.62)
		var sprite: Texture2D = enemy_textures[sprite_kind]
		draw_circle(enemy.pos + Vector2(0, size * 0.34), size * 0.30, Color(0, 0, 0, 0.35))
		draw_chibi(sprite, enemy.pos, size, false, Color("#f7d170") if enemy.stun > 0.0 else (Color("#ff856a") if enemy.boss_kind == 2 else Color.WHITE))
		if enemy.fracture > 0.0:
			draw_arc(enemy.pos, size * 0.38, 0, TAU, 22, Color("#ffa7ca"), 2.0, true)
		bar(enemy.pos + Vector2(-size * 0.4, -size * 0.58), size * 0.8, enemy.hp / enemy.max_hp, Color("#ff5a6b"))
	for effect in effects:
		draw_line(effect.from, effect.to, effect.color, 3, true)
