#define CLOWN_STORE_PDA_MODE 55
/obj/item/cartridge/virus/clown
	var/bananapoints = 10 // honk
	var/canrefill = 1 // controls if you can get more banana points by inserting bananas into the cart
	var/list/buydatums = list()
	var/list/clown_buyables = list(
	/obj/item/reagent_containers/food/snacks/grown/banana = 1,
	/obj/item/reagent_containers/food/snacks/pie/cream = 2,
	/obj/item/reagent_containers/food/drinks/soda_cans/canned_laughter = 2,
	/obj/item/bikehorn = 2,
	/obj/item/storage/crayons = 3,
	/obj/item/storage/box/snappops = 3,
	/obj/item/device/flashlight/lamp/bananalamp = 4,
	/obj/item/banhammer = 5,
	/obj/item/device/megaphone/clown = 6,
	// /obj/item/stack/sheet/mineral/bananium/twentyfive = 35 // no
	)

/datum/data/clownstore_item
	var/item_name = "generic item"
	var/item_path = null
	var/cost = 0

/obj/item/cartridge/virus/clown/examine(mob/user)
	..()
	if (canrefill)
		to_chat(user, "<span class='notice'>There is a tiny, banana-shaped slot on its side.</span>")

/obj/item/cartridge/virus/clown/Initialize()
	..()
	for(var/path in clown_buyables) // this is just so it automatically generates the datum thing shits becouse I am lazy
		var/cost = clown_buyables[path] // I will change it if need be
		var/atom/temp = path
		if(isnull(cost))
			cost = 1
		var/datum/data/clownstore_item/C = new /datum/data/clownstore_item
		C.item_name = capitalize(initial(temp.name)) //
		C.item_path = path
		C.cost = cost
		buydatums += C

/obj/item/cartridge/virus/clown/generate_menu(mob/user)
	if(!host_pda)
		return
	if (host_pda.mode == CLOWN_STORE_PDA_MODE && (access & CART_CLOWN))
		menu = "<h3><font color='#66ff66'>Clowning Supply Store</font></h3>"
		menu += "<P><font color='#66ff66'><B>Banana Points: [bananapoints]</B></font></P>"
		for(var/typepath in buydatums)
			var/datum/data/clownstore_item/CS = typepath
			var/cost = CS.cost
			if (isnull(cost))
				cost = 1
			menu += "<font color='#66ff66'><A href='?src=\ref[src];buy=[REF(CS)]'>[CS.item_name]</A> Cost: [cost]</font><br>"
		if (buydatums == list())
			menu = "<B>huh the store is empty that shouldn't happen</B>"
		return menu
	..()
/obj/item/cartridge/virus/clown/Topic(href, href_list)
	if(host_pda)
		if(href_list["buy"] && (access & CART_CLOWN))
			var/datum/data/clownstore_item/CS = locate(href_list["buy"])
			if(bananapoints >= CS.cost)
				bananapoints -= CS.cost
				var/atom/A = new CS.item_path(get_turf(usr))
				if(ishuman(usr) && istype(A,/obj/item))
					if (usr.put_in_hands(A))
						to_chat(usr, "[A] materializes into your hands!")
					else
						to_chat(usr, "[A] materializes onto the floor.")
				else
					to_chat(usr, "[A] materializes onto the floor.")
			else
				to_chat(usr,"Not enough banana points.")
	..()
/obj/item/cartridge/virus/clown/attackby(obj/item/I,mob/user)
	if(insertbanana(I,user))
		return
	..()

/obj/item/cartridge/virus/clown/proc/insertbanana(obj/item/B, mob/user)
	if(istype(B,/obj/item/reagent_containers/food/snacks/grown/banana) && canrefill)
		to_chat(usr, "You fit [B] into the banana-shaped slot on the side of the cartridge.")
		bananapoints += 1
		qdel(B)
		return

/obj/item/device/pda/attackby(obj/item/C, mob/user)
	if (istype(cartridge,/obj/item/cartridge/virus/clown))
		var/obj/item/cartridge/virus/clown/cart = cartridge
		cart.insertbanana(C,user)
	..()

/obj/item/stack/sheet/mineral/bananium/fifty // QOL for admins, unused
	amount = 50
/obj/item/stack/sheet/mineral/bananium/twentyfive
	amount = 25
/obj/item/stack/sheet/mineral/bananium/ten
	amount = 10