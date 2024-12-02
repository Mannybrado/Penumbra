/obj/effect/proc_holder/spell/invoked/mockery
	name = "Vicious Mockery"
	releasedrain = 50
	associated_skill = /datum/skill/misc/music
	charge_max = 10 MINUTES
	range = 7

/obj/effect/proc_holder/spell/invoked/mockery/cast(list/targets, mob/living/user)
	playsound(get_turf(user), 'sound/magic/mockery.ogg', 40, FALSE)
	for(var/mob/living/listener in hearers(7))
		if(listener.can_hear()) // Vicious mockery requires people to be able to hear you.
			listener.apply_status_effect(/datum/status_effect/debuff/viciousmockery)
		else
			return // No debuff for good guys

/obj/effect/proc_holder/spell/invoked/mockery/invocation(mob/user = usr)
	if(ishuman(user))
		switch(pick(1,2,3,4,5,6,7,8,9,10,11))
			if(1)
				user.say("Your mother was a Rous, and your father smelled of jacksberries!", forced = "spell")
			if(2)
				user.say("Wandought thine blades stand, much like thine loving parts!", forced = "spell")
			if(3)
				user.say("That's a face not even my mother could love!", forced = "spell")
			if(4)
				user.say("Your breath smells like raw butter and cheap beer!.", forced = "spell")
			if(5)
				user.say("I bite mine thumb, ser!", forced = "spell")
			if(6)
				user.say("But enough talk- have at thee!", forced = "spell")
			if(7)
				user.say("My grandmother fights better than you!", forced = "spell")
			if(8)
				user.say("Need you borrow mine spectacles? Come get them!", forced = "spell")
			if(9)
				user.say("How much sparring did it take to become this awful?!", forced = "spell")
			if(10)
				user.say("You may need a smith- for you seem ill-equipped for a battle of wits!", forced = "spell")
			if(11)
				user.say("Thou haveth nay more brain than stone!", forced = "spell")

/datum/status_effect/debuff/viciousmockery
	id = "viciousmockery"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/viciousmockery
	duration = 600 // One minute
	effectedstats = list("strength" = -1, "speed" = -1,"endurance" = -1, "intelligence" = -3)

/atom/movable/screen/alert/status_effect/debuff/viciousmockery
	name = "Vicious Mockery"
	desc = "<span class='warning'>THAT ARROGANT BARD! ARGH!</span>\n"
	icon_state = "muscles"
