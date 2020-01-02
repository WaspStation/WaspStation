/datum/species/squid
	// Cephalopod humanoids with squid-like features
	name = "Krell"
	id = "krell"
	roundstart = 1
	default_color = "#189"
	species_traits = list(SPECIES_ORGANIC, MUTCOLORS, EYECOLOR, NOSLIP_1)
	mutant_bodyparts = list("squid_face")
	coldmod = 0.6
	heatmod = 1.4
	default_features = list("mcolor" = "189", "squid_face" = "squidward")
	attack_verb = "slap"
	attack_sound = 'sound/weapons/slap.ogg'
	miss_sound = 'sound/weapons/punchmiss.ogg'
	disliked_food = FRIED | JUNKFOOD
	liked_food = VEGETABLES | MEAT
	examine_text = "a Krell"
	species_text_color = "#B30"
	loreblurb = "A race of squid-like amphibians with an odd appearance. \
	They posses the ability to change their pigmentation at will, often leading to confusion. \
	Nanotrasen ensures that the Krell do not eat human grey matter, and such reports will be discarded."

/datum/action/innate/change_color
	name = "Change Color"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = 'mutate'

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