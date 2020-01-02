/datum/species/squid
	// Cephalopod humanoids with squid-like features
	name = "Skrell"
	id = "skrell"
	roundstart = 0
	default_color = "#189"
	species_traits = list(SPECIES_ORGANIC, MUTCOLORS, EYECOLOR, NOSLIP_1)
	mutant_bodyparts = list("squid_face")
	default_features = list("mcolor" = "189", "squid_face" = "Squidward")
	coldmod = 0.6
	heatmod = 1.4
	burnmod = 1.6
	speedmod = 0.4
	punchdamagehigh = 6 //Tentacles make for weak noodle arms
	punchstunthreshold = 5 //Good for smacking down though
	attack_verb = "slap"
	attack_sound = 'sound/weapons/slap.ogg'
	miss_sound = 'sound/weapons/punchmiss.ogg'
	disliked_food = JUNKFOOD
	liked_food = VEGETABLES | MEAT
	toxic_food = FRIED
	examine_text = "a Skrell"
	exotic_bloodtype = "S"
	no_equip = list(SLOT_FEET, slot_shoes)
	species_text_color = "#B30"
	loreblurb = "A race of squid-like amphibians with an odd appearance. \
	They posses the ability to change their pigmentation at will, often leading to confusion. \
	Nanotrasen ensures that the Skrell do not eat human grey matter, and such reports will be discarded."

/datum/species/squid/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_skrell_name()

	var/randname = skrell_name()

	return randname

/datum/species/squid/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	var/datum/action/innate/change_color/S = new
	S.Grant(H)

/datum/species/squid/on_species_loss(mob/living/carbon/human/H)
	. = ..()
	fixed_mut_color = rgb(128,128,128)
	H.update_body()
	var/datum/action/innate/change_color/S = locate(/datum/action/innate/change_color) in H.actions
	S?.Remove(H)

/datum/action/innate/change_color
	name = "Change Color"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "mutate"

/datum/action/innate/change_color/Activate()
	var/mob/living/carbon/human/H = owner
	var/color_choice = input(usr, "What color will you change to?", "Color Change") as null | color
	if (color_choice)
		var/temp_hsv = RGBtoHSV(color_choice)
		if (ReadHSV(temp_hsv)[3] >= ReadHSV("#7f7f7f")[3])
			H.dna.species.fixed_mut_color = sanitize_hexcolor(color_choice)
			H.update_body()
		else
			to_chat(usr, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")

// Zero gravity movement

/datum/species/squid/negates_gravity(mob/living/carbon/human/H)
	if(H.mob_has_gravity())
		speedmod = 0.4
	else
		speedmod = 0.8
	if(H.movement_type)
		return 1
