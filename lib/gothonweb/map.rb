module Map

	class Room

		def initialize(name, description)
			@name = name
			@description = description
			@paths = {}
			@tries = 0
			@limit = 3
		end

		attr_reader :name, :paths, :description

		def go(direction)
			if direction == "*" && (can_retry)
			  return @paths["restart"]
			end

			return @paths[direction]
		end


		def add_paths(paths)
			@paths.update(paths)
		end

		def can_retry()
		  return @tries < @limit
		end

		def update_tries(tries)
			@tries = tries
		end


		CENTRAL_CORRIDOR = Room.new("Central Corridor", """
			The Gothons of Planet Percal have invaded your ship and destroyed
			your entire crew. You are the last surviving member and your last
			mission is to get the neutron destruct bomb from the Weapons Armory,
			put it in the bridge and blow up the ship after getting into an 
			escape pod.

			You're running down the central corridor to the Weapons Armory when 
			a Gothon jumps out, red scaly skin, dark grimy teeth and evil clown 
			costume flowing around his hate-filled body. He's blocking the door 
			to the Armory and about to pull out a weapon and blast you.	

			Do you shoot, dodge or tell a joke?		
			""")

		LASER_WEAPON_ARMORY = Room.new("Laser Weapon Armory", """
			Lucky for you they made you learn Gothoon insults in the academy.
			You tell the one Gothon joke you know:
			Lbdhdf dsdsi jjvi.  Iiifas csdifjsd ii dju. Fvvri sdfsoduu, asoidu.
			The Gothon stops, tries not to laugh, then bursts out laughing and 
			can't move. While he's laughing you run up and shoot him square in 
			the head, putting him down, then jump through the Armory door.

			You do a dive roll into the Weapons Armory, crouch, and scan the room
			for more Gothons that might be hiding. It's dead quiet. Too quiet.
			You stand up and run to the far side of the room and find the neutron
			bomb in its container. There's a keypad lock on the box and you need
			the code to get the bomb out. If you get the code wrong 10 times then
			the lock closes forever and you can't get the bomb. The code is 4 digits.
			""")

		THE_BRIDGE = Room.new("The Bridge", """
			The container clicks open and the seal breaks, letting gas out. You grab
			the neutron bomb and run as fast as you can to the bridge, where you must
			place it in the right spot.
			You burst onto the Bridge with the neutron bomb under your arm, and surprise
			5 Gothons who are trying to take control of the ship. Each of them has an
			even uglier clown costume than the last. They haven't pulled their weapons 
			out yet as they've seen the bomb under your arm and don't want to set it off.

			Do you slowly place the bomb, or throw the bomb?
			""")

		ESCAPE_POD = Room.new("Escape Pod", """ 
			You point your blaster at the bomb under your arm and the Gothons put their hands 
			up and start to sweat. You inch backward to the door, open it, and carefully 
			place the bomb on the floor, pointing your blaster at it. You then jump 
			back through the door, punch the close button and blast the lock so the 
			Gothons can't get out. Now that the bomb is placed you run to the escape
			pod to get off this darn tin can.

			You rush through the ship desperately trying to make it to the escape pod
			before the whole ship explodes. It seems like hardly any Gothons are on
			the ship, so your run is clear of obstacles. You get to the chamber with
			the escape pods, and now need to choose which to take. Some of them 
			could be damaged but you don't have time to look. There are 5 pods.
			Which do you take?  Enter a number.
			""")

		THE_END_WINNER = Room.new("The End", """
			You jump into pod 2 and hit the eject button. The pod easily slides
			out into space heading to the planet below. As it flies to the planet,
			you look back and see your ship implode and then explode like a bright
			star, taking out the Gothon ship at the same time.

			YOU WON!
			 """)

		THE_END_LOSER = Room.new("The End", """
			You jump into a random pod and hit the eject button.
			The pod shoots out into the void of space, then implodes as its hull
			ruptures, crushing your body into strawberry jelly.
			 """)

		ESCAPE_POD.add_paths({
			'2' => THE_END_WINNER,
			'*' => THE_END_LOSER
			})

		GENERIC_DEATH = Room.new("death", "You died.")

		THE_BRIDGE.add_paths({
			"throw the bomb" => GENERIC_DEATH,
			"slowly place the bomb" => ESCAPE_POD
			})

		LASER_WEAPON_ARMORY.add_paths({
			'0312' => THE_BRIDGE,
			'*' => GENERIC_DEATH
			})

		CENTRAL_CORRIDOR.add_paths({
			'shoot' => GENERIC_DEATH,
			'dodge' => GENERIC_DEATH,
			'tell a joke' => LASER_WEAPON_ARMORY
			})

		START = CENTRAL_CORRIDOR

		ROOM_NAMES = {
			'CENTRAL CORRIDOR' => CENTRAL_CORRIDOR,
			'LASER WEAPON ARMORY' => LASER_WEAPON_ARMORY,
			'THE BRIDGE' => THE_BRIDGE,
			'ESCAPE POD' => ESCAPE_POD,
			'THE_END_WINNER' => THE_END_WINNER,
			'THE_END_LOSER' => THE_END_LOSER,
			'START' => START
		}

		def Map::load_room(session)
			return ROOM_NAMES[session[:room]]
		end

		def Map::save_room(session, room)
			session[:room] = ROOM_NAMES.key(room)
		end

		def Map::update_room_tries(session, room)
		  room.update_tries(session[:tries])
		end

		def Map::update_tries(session)
		  session[:tries] += 1
		end

		def Map::load_room(session)
		  return ROOM_NAMES[session[:room]]
		end

		def Map::save_room(session, room)
		  if (session[:room] != ROOM_NAMES.key(room))
		    session[:tries] = 0
		    session[:room] = ROOM_NAMES.key(room)
		  end
		end

	end
end













