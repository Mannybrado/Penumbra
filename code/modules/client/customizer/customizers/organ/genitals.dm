/datum/customizer/organ/penis
	abstract_type = /datum/customizer/organ/penis
	name = "Penis"
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer/organ/penis/is_allowed(datum/preferences/prefs)
	for(var/datum/customizer_entry/entry as anything in prefs.customizer_entries)
		if(istype(entry,/datum/customizer_entry/organ/vagina))
			return entry.disabled
	return TRUE

/datum/customizer_choice/organ/penis
	abstract_type = /datum/customizer_choice/organ/penis
	name = "Penis"
	organ_type = /obj/item/organ/penis
	organ_slot = ORGAN_SLOT_PENIS
	organ_dna_type = /datum/organ_dna/penis
	customizer_entry_type = /datum/customizer_entry/organ/penis

	proc/is_allowed(datum/preferences/prefs)
		return TRUE

/datum/customizer_choice/organ/penis/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	var/max_size = (prefs.pref_species.id == "tiefling") ? MAX_PENIS_INCHES_TIEFLING : MAX_PENIS_INCHES
	penis_entry.penis_size = clamp(penis_entry.penis_size, MIN_PENIS_INCHES, max_size)

/datum/customizer_choice/organ/penis/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/penis/penis_dna = organ_dna
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	penis_dna.penis_size = penis_entry.penis_size

/datum/customizer_choice/organ/penis/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	dat += "<br>Penis size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=penis_size''>[penis_entry.penis_size] inches</a>"

/datum/customizer_choice/organ/penis/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	switch(href_list["customizer_task"])
		if("penis_size")
			var/max_size = (prefs.pref_species.id == "tiefling") ? MAX_PENIS_INCHES_TIEFLING : MAX_PENIS_INCHES
			var/new_size = input(user, "Choose your penis size (1.0-[max_size] inches):", "Character Preference", "[penis_entry.penis_size]") as num|null
			if(isnull(new_size))
				return
			penis_entry.penis_size = clamp(new_size, MIN_PENIS_INCHES, max_size)

/datum/customizer_entry/organ/penis
	var/penis_size = DEFAULT_PENIS_INCHES

/datum/customizer/organ/penis/human
	customizer_choices = list(/datum/customizer_choice/organ/penis/human)

/datum/customizer/organ/penis/anthro
	customizer_choices = list(/datum/customizer_choice/organ/penis/human)

/datum/customizer/organ/penis/demihuman
	customizer_choices = list(
		/datum/customizer_choice/organ/penis/human,
		/datum/customizer_choice/organ/penis/knotted
	)

/datum/customizer_choice/organ/penis/human
	name = "Plain Penis"
	organ_type = /obj/item/organ/penis
	sprite_accessories = list(/datum/sprite_accessory/penis/human)
	allows_accessory_color_customization = FALSE

/datum/customizer_choice/organ/penis/human_anthro
	name = "Plain Penis"
	organ_type = /obj/item/organ/penis
	sprite_accessories = list(/datum/sprite_accessory/penis/human)
	allows_accessory_color_customization = TRUE

/datum/customizer_choice/organ/penis/knotted
    name = "Knotted Penis"
    organ_type = /obj/item/organ/penis/knotted
    sprite_accessories = list(/datum/sprite_accessory/penis/knotted)

/datum/customizer_choice/organ/penis/knotted/is_allowed(datum/preferences/prefs)
    return istype(prefs.pref_species, /datum/species/demihuman)

/datum/customizer/organ/testicles
	abstract_type = /datum/customizer/organ/testicles
	name = "Testicles"
	allows_disabling = TRUE
	default_disabled = TRUE
	gender_enabled = MALE

/datum/customizer/organ/testicles/is_allowed(datum/preferences/prefs)
	for(var/datum/customizer_entry/entry as anything in prefs.customizer_entries)
		if(istype(entry,/datum/customizer_entry/organ/penis))
			return !entry.disabled

/datum/customizer_choice/organ/testicles
	abstract_type = /datum/customizer_choice/organ/testicles
	name = "Testicles"
	organ_type = /obj/item/organ/testicles
	organ_dna_type = /datum/organ_dna/testicles
	customizer_entry_type = /datum/customizer_entry/organ/testicles
	organ_slot = ORGAN_SLOT_TESTICLES
	var/can_customize_size = TRUE

/datum/customizer_choice/organ/testicles/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	testicles_entry.ball_size = sanitize_integer(testicles_entry.ball_size, MIN_TESTICLES_SIZE, MAX_TESTICLES_SIZE, DEFAULT_TESTICLES_SIZE)

/datum/customizer_choice/organ/testicles/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/testicles/testicles_dna = organ_dna
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	if(can_customize_size)
		testicles_dna.ball_size = testicles_entry.ball_size
	testicles_dna.virility = testicles_entry.virility

/datum/customizer_choice/organ/testicles/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	if(can_customize_size)
		dat += "<br>Ball size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=ball_size''>[find_key_by_value(GLOB.named_ball_sizes, testicles_entry.ball_size)]</a>"
	dat += "<br>Virile: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=virile''>[testicles_entry.virility ? "Virile" : "Sterile"]</a>"

/datum/customizer_choice/organ/testicles/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	switch(href_list["customizer_task"])
		if("ball_size")
			var/named_size = input(user, "Choose your ball size:", "Character Preference", find_key_by_value(GLOB.named_ball_sizes, testicles_entry.ball_size)) as anything in GLOB.named_ball_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_ball_sizes[named_size]
			testicles_entry.ball_size = sanitize_integer(new_size, MIN_TESTICLES_SIZE, MAX_TESTICLES_SIZE, DEFAULT_TESTICLES_SIZE)
		if("virile")
			testicles_entry.virility = !testicles_entry.virility

/datum/customizer/organ/testicles/external
	customizer_choices = list(/datum/customizer_choice/organ/testicles/external)

/datum/customizer/organ/testicles/human
	customizer_choices = list(/datum/customizer_choice/organ/testicles/human)

/datum/customizer/organ/testicles/internal
	customizer_choices = list(/datum/customizer_choice/organ/testicles/internal)

/datum/customizer/organ/testicles/anthro
	customizer_choices = list(
		/datum/customizer_choice/organ/testicles/external,
		/datum/customizer_choice/organ/testicles/internal,
	)

/datum/customizer_choice/organ/testicles/external
	name = "Testicles"
	sprite_accessories = list(/datum/sprite_accessory/testicles/pair)

/datum/customizer_choice/organ/testicles/human
	name = "Testicles"
	sprite_accessories = list(/datum/sprite_accessory/testicles/pair)
	allows_accessory_color_customization = FALSE

/datum/customizer_choice/organ/testicles/internal
	name = "Internal testicles"
	organ_type = /obj/item/organ/testicles/internal
	sprite_accessories = null
	can_customize_size = FALSE

/datum/customizer_entry/organ/testicles
	var/ball_size = DEFAULT_TESTICLES_SIZE
	var/virility = TRUE

/datum/customizer/organ/breasts
	abstract_type = /datum/customizer/organ/breasts
	name = "Breasts"
	allows_disabling = TRUE
	default_disabled = TRUE
	gender_enabled = FEMALE

/datum/customizer/organ/breasts/is_allowed(datum/preferences/prefs)
	return (prefs.gender == FEMALE)

/datum/customizer_choice/organ/breasts
	abstract_type = /datum/customizer_choice/organ/breasts
	name = "Breasts"
	customizer_entry_type = /datum/customizer_entry/organ/breasts
	organ_type = /obj/item/organ/breasts
	organ_slot = ORGAN_SLOT_BREASTS
	organ_dna_type = /datum/organ_dna/breasts

/datum/customizer_choice/organ/breasts/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	breasts_entry.breast_size = sanitize_integer(breasts_entry.breast_size, MIN_BREASTS_SIZE, MAX_BREASTS_SIZE, DEFAULT_BREASTS_SIZE)

/datum/customizer_choice/organ/breasts/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/breasts/breasts_dna = organ_dna
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	breasts_dna.breast_size = breasts_entry.breast_size
	breasts_dna.lactating = breasts_entry.lactating

/datum/customizer_choice/organ/breasts/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	dat += "<br>Breast size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=breast_size''>[find_key_by_value(GLOB.named_breast_sizes, breasts_entry.breast_size)]</a>"
	dat += "<br>Lactation: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=lactating''>[breasts_entry.lactating ? "Enabled" : "Disabled"]</a>"

/datum/customizer_choice/organ/breasts/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	switch(href_list["customizer_task"])
		if("breast_size")
			var/named_size = input(user, "Choose your breast size:", "Character Preference", find_key_by_value(GLOB.named_breast_sizes, breasts_entry.breast_size)) as anything in GLOB.named_breast_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_breast_sizes[named_size]
			breasts_entry.breast_size = sanitize_integer(new_size, MIN_BREASTS_SIZE, MAX_BREASTS_SIZE, DEFAULT_BREASTS_SIZE)
		if("lactating")
			breasts_entry.lactating = !breasts_entry.lactating

/datum/customizer_entry/organ/breasts
	var/breast_size = DEFAULT_BREASTS_SIZE
	var/lactating = FALSE

/datum/customizer/organ/breasts/human
	customizer_choices = list(/datum/customizer_choice/organ/breasts/human)

/datum/customizer_choice/organ/breasts/human
	sprite_accessories = list(/datum/sprite_accessory/breasts/pair)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/breasts/animal
	customizer_choices = list(/datum/customizer_choice/organ/breasts/animal)

/datum/customizer_choice/organ/breasts/animal
	sprite_accessories = list(
		/datum/sprite_accessory/breasts/pair,
		/datum/sprite_accessory/breasts/quad,
		/datum/sprite_accessory/breasts/sextuple,
		)

/datum/customizer/organ/vagina
	abstract_type = /datum/customizer/organ/vagina
	name = "Vagina"
	allows_disabling = TRUE
	default_disabled = TRUE
	gender_enabled = FEMALE

/datum/customizer/organ/vagina/is_allowed(datum/preferences/prefs)
	if(prefs.gender != FEMALE)
		return FALSE
	for(var/datum/customizer_entry/entry as anything in prefs.customizer_entries)
		if(istype(entry, /datum/customizer_entry/organ/penis))
			return entry.disabled
	return TRUE

/datum/customizer_choice/organ/vagina
	abstract_type = /datum/customizer_choice/organ/vagina
	name = "Vagina"
	customizer_entry_type = /datum/customizer_entry/organ/vagina
	organ_type = /obj/item/organ/vagina
	organ_slot = ORGAN_SLOT_VAGINA
	organ_dna_type = /datum/organ_dna/vagina

/datum/customizer_entry/organ/vagina
	var/fertility = TRUE

/datum/customizer_choice/organ/vagina/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/vagina/vagina_dna = organ_dna
	var/datum/customizer_entry/organ/vagina/vagina_entry = entry
	vagina_dna.fertility = vagina_entry.fertility

/datum/customizer_choice/organ/vagina/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/vagina/vagina_entry = entry
	dat += "<br>Fertile: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=fertile''>[vagina_entry.fertility ? "Fertile" : "Sterile"]</a>"

/datum/customizer_choice/organ/vagina/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/vagina/vagina_entry = entry
	switch(href_list["customizer_task"])
		if("fertile")
			vagina_entry.fertility = !vagina_entry.fertility


/datum/customizer/organ/vagina/human
	customizer_choices = list(/datum/customizer_choice/organ/vagina/human)

/datum/customizer_choice/organ/vagina/human
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/vagina/human_anthro
	customizer_choices = list(/datum/customizer_choice/organ/vagina/human_anthro)

/datum/customizer_choice/organ/vagina/human_anthro
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		)
	allows_accessory_color_customization = TRUE

/datum/customizer/organ/vagina/animal
	customizer_choices = list(/datum/customizer_choice/organ/vagina/animal)

/datum/customizer_choice/organ/vagina/animal
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		/datum/sprite_accessory/vagina/spade,
		/datum/sprite_accessory/vagina/furred,
		)

/datum/customizer/organ/vagina/anthro
	customizer_choices = list(/datum/customizer_choice/organ/vagina/anthro)

/datum/customizer_choice/organ/vagina/anthro
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		/datum/sprite_accessory/vagina/spade,
		/datum/sprite_accessory/vagina/furred,
		/datum/sprite_accessory/vagina/cloaca,
		)