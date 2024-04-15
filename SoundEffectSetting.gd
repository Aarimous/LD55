extends Resource
class_name SoundEffectSettings
enum SOUND_EFFECT_TYPE{
	DEVIL_HUZZAH,
	DEVIL_AYO,
	DEVIL_HUH,
	DEVIL_IM_READY,
	DEVIL_LETS_GO_GET_EM,
	DEVIL_GRUNT_1,
	DEVIL_GRUNT_2,
	DEVIL_GRUNT_3,
	DEVIL_DIE_1,
	DEVIL_DIE_2,
	DEVIL_DIE_3,
	DEVIL_DIE_4,
	DEVIL_FOR_LUCIFER,
	DEVIL_ATK_1,
	DEVIL_ATK_2,
	DEVIL_ATK_3,
	DEVIL_ATK_4,
	DEVIL_ATK_5,
	DEVIL_ATK_6,
	ANGEL_SUMMON_1,
	ANGEL_SUMMON_2,
	ANGEL_SUMMON_3,
	ANGEL_SUMMON_4,
	ANGEL_SUMMON_5,
	ANGEL_SUMMON_6,
	ANGEL_TAKE_DAMAGE_1,
	ANGEL_TAKE_DAMAGE_2,
	ANGEL_TAKE_DAMAGE_3,
	ANGEL_TAKE_DAMAGE_4,
	ANGEL_TAKE_DAMAGE_5,
	ANGEL_ATK_1,
	ANGEL_ATK_2,
	ANGEL_ATK_3,
	ANGEL_ATK_4,
	ANGEL_ATK_5,
	ANGEL_ATK_6,
	ANGEL_ATK_7,
	SHOP_OPEN_1,
	SHOP_OPEN_2,
	SHOP_OPEN_3,
	SHOP_OPEN_4,
	PURCHASE_1,
	SHOP_CLOSE_1,
	SHOP_CLOSE_2,
	SHOP_CLOSE_3,
	SHOP_CLOSE_4,
	SHOP_CLOSE_5,
	SHOP_CLOSE_6,
	SHOP_OPEN_5,
	SHOP_OPEN_6,
	SHOP_OPEN_7,
	SOULS_SUCK_1
	
}

var limit : int = 1
@export var type : SOUND_EFFECT_TYPE
@export var sound_effect : AudioStreamMP3
@export_range(-20, 20) var volume  = -10
@export_range(0.0, 1.0,.1) var pitch_randomness = .2

var audio_count = 0

func change_audio_count(amount : int):
	audio_count = max(0, audio_count + amount)
	
func has_open_limit() -> bool:
	return audio_count < limit
	
	
func on_audio_finished():
	change_audio_count(-1)
	
