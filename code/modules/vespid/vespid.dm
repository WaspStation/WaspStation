//Vespid Industries gang
/obj/item/gun/energy/laser/vespid
	icon = 'code/modules/vespid/wasprite.dmi'
	name = "vespid template"
	icon_state = "lasercannon"
	item_state = "laser"
	desc = "A prototype weapon. You're not meant to see this."
	origin_tech = "combat=5;materials=4;powerstorage=4"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter)
	selfcharge = 1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/on = FALSE

/obj/item/gun/energy/laser/vespid/mandible
	name = "Mandible Combat Shotgun"
	icon_state = "mandible_shotgun"
	item_state = "shotgun"
	desc = "A fully automatic shotgun made by Vespid Incorporated."
	ammo_x_offset = 3

/obj/item/gun/energy/laser/vespid/mandible/attack_self(mob/user)
	if(!on)
		to_chat(user, "<span class ='warning'>Additional coils flip onto the barrel with an ominous hum.</span>")
		icon_state = "mandible_explosive"
		ammo_type = list(/obj/item/projectile/beam/laser/heavylaser)
		desc = "A  semi-automatic coilgun made by Vespid Incorporated."
	else
		to_chat(user, "<span class ='warning'>The coils retract off the barrel with a silent hum.</span>")
		icon_state = "mandible_shotgun"
		ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter)
		desc = "A fully automatic shotgun made by Vespid Incorporated."

/obj/item/vespidcoxa
	name = "Coxa Melee Multitool"
	desc = "An elegant weapon, from a more elegant time."
	icon = 'code/modules/vespid/wasprite.dmi'
	icon_state = "coxa_sword"
	item_state = "katana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 40
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	block_chance = 50
	sharpness = IS_SHARP
	max_integrity = 200
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 50)
	resistance_flags = FIRE_PROOF
	var/on = FALSE

/obj/item/vespidcoxa/attack_self(mob/user)
	if(!on)
		to_chat(user, "<span class ='warning'>Prongs expand from the blade as electricity crackles.</span>")
		icon_state = "coxa_stunprod"
		throwforce = 5
		force = 10
	else
		to_chat(user, "<span class ='warning'>The prongs retract, exposing the razor-sharp blade.</span>")
		icon_state = "coxa_sword"
		force = 40
		throwforce = 150

/obj/item/gun/energy/laser/vespid/tarsus
	name = "Tarsus Self-Defense Weapon"
	desc = "A heavy coilgun shoved into a pistol case, made by Vespid Incorporated."
	icon_state = "tarsus_pistol"
	item_state = "caplaser"
	burst_size = 2
	ammo_type = list(/obj/item/projectile/beam/laser/heavylaser)


/obj/item/gun/energy/laser/vespid/tarsus/attack_self(mob/user)
	if(!on)
		to_chat(user, "<span class ='warning'>Prongs emerge from the back of the gun with a sharp twang.</span>")
		icon_state = "tarsus_smg"
		ammo_type = list(/obj/item/projectile/beam/laser)
		desc = "A  full-auto coilgun that sacrifices damage and accuracy for dakka, made by Vespid Incorporated."
		burst_size = 6
	else
		to_chat(user, "<span class ='warning'>You push the prongs back into the gun with a satisfying click.</span>")
		desc = "A heavy coilgun shoved into a pistol case, made by Vespid Incorporated."
		icon_state = "tarsus_pistol"
		item_state = "caplaser"
		burst_size = 2
		ammo_type = list(/obj/item/projectile/beam/laser/heavylaser)

/obj/machinery/vending/vespidvend
	name = "Vespid Vend"
	desc = "How'd that get here?"
	icon = 'code/modules/vespid/wasprite.dmi'
	icon_state = "redvendor"
	icon_deny = "redvendor"
	products = list(/obj/item/gun/energy/laser/vespid/mandible = 4,
					/obj/item/vespidcoxa = 4,
					/obj/item/gun/energy/laser/vespid/tarsus = 4)
	armor = list(melee = 100, bullet = 100, laser = 100, energy = 100, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 50)
	resistance_flags = FIRE_PROOF
	product_ads = "Guaranteed Dimas Moment!; Buy or die!; Consume or be consumed!; Let none survive!; No refunds!"
