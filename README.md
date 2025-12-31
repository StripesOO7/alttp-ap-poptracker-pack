# A Link to the Past AP Tracker

Archipelago A Link to the Past tracker pack for [PopTracker](https://github.com/black-sliver/PopTracker/) with Autotracking.

PopTracker v0.23.0 or higher is recommended.


First version of an Archipelago compatible alttp-Tracker pack

## current working settings:
    - "open", "Inverted" and "standard" starting-optoins are supported
    - tracking of Dungonbosses and if they are beatable
    - estimation of whats accessible depending on you rkeycount AND already collected checks (!collect or savescumming
    will mess with that)
    - every check should get tracked
    - shop-sanity, shop shuffle including inventory and price-shuffle tracking (manual)
    - basic logic and minor glitches work ,overworld glitches and higher logic can have problems
    - pot-shuffle works, enemy_keydrop_shuffle sworks
    - full ER tracking possible (manual or automatic via SNI connection)
    - stun prize, pull trees, hoarder crab drops trackable
    - when ER is enabled you can use the "Route Mode" and select a start and end point to get a proposed route between
    these 2 points. (save&quit not considered at the moment)

## not working:
    - nothing. included that the AP version has to offer for trackable randomization

## in planning for future features:
    - Doors may work in the future


## only for AP below version 0.4.2:
If you want to use Auto-Tracking for your Setttings add this to your alttp/\_\_init\_\_.py File within the "ALTTPWORLD"-class

```
def fill_slot_data(self):
    slot_data = {}
    for option_name in alttp_options:
        option = getattr(self.multiworld, option_name)[self.player]
        # if slot_data.get(option_name, None) is None and type(option.value) in {int}:
        slot_data[option_name] = option.value

    slot_data['mode'] = self.multiworld.mode[self.player]
    slot_data['goal'] = self.multiworld.goal[self.player]
    slot_data['dark_room_logic'] = self.multiworld.dark_room_logic[self.player]
    slot_data['mm_medalion'] = self.multiworld.required_medallions[self.player][0]
    slot_data['tr_medalion'] = self.multiworld.required_medallions[self.player][1]
    slot_data['shop_shuffle'] = self.multiworld.shop_shuffle[self.player]

    return slot_data
```

## Entrance Rando Explanation/Tutorial:

ER tracking is basically at the absolute edge of the bounds of PopTracker. So its a bit finnicky to use or rather
unintuitive compared to the other interactions within PopTracker.
This section servers as atutorioal how to use it.

### Prerequisite
Have Entrance Rando (ER) enabled to the setting you want. (Dungeons/Full/Insanity)
- Dungeon -> Only the dorp-downs and all Dungeonentrances are not connected/unknown and need to be connected. 
This includes also Dungeons Simple, Dungeons Full and Dungeons Crossed
else has its original connection intakt.
- Full -> inculdes every possible other ER setting besides Insanty. 
This inculdes Simple ER, Restricted ER, Full ER and Crossed ER
- Insanity -> gives each door 2 connections. one for entering and one for exiting through a given door. Since these do
  not lead to the same locations in this setting. 

### How to use it
- ALL intercations use the images inside the location-popups. not the diamonds or the title texts of he popups!!!
#### Connecting entrances
If you want to connect 2 Doors/Entrances with each other you go to the Entrances Tab on the Tracker. 
Then you hover over the Entrance you started/went into and **LEFTCLICK** the Door-icon. This will highlight that entrance in a normally **BLUE** (or whatever you set the blue color to) hue/highlight. This now indicates that this Entrances has been selected as the first of the connection pair. 
Now do the same For the ssection Door/Entrance you came out of.

This will connect these 2 Doors/Entrances and you will see the Door-image change to the corresponging image for the "other side" AND have it show the name of the other side in a text-overlay over the image.

#### Removing a connection
This can be done by **RIGHTCLICK**ing on any of the sides you want to disconnect this will change the icon back to the close Door.
Another way is if you just do the steps for connectin entrances over an already existing one. This will unlink the previous connection and set the new one.

#### Finding the corresponging entrance
You can **MIDDLECLICK** on side of a connected Pais and both sides will get a **RED** (or whatever you changes the red to) hue/highlight and it changes the ER tabs so that both sides should be visible. The Highlight will automatically vanish after 5-10 seconds.

### Finding a way between to entrances
As of Pack version 0.4.2 it is possible to have the tracker tell you what if thinks is a valid route between 2 points if there is any. 

In the bottom middle of the tracker is an item/a setting called "Route Mode". 

Set this to **ON** and the connection feature for entrances get disabled. 
Instead you now **LEFTCLICK** the 2 Entrances you want a route to be calculated for. After the second click you will get send to the "Route" Tab of the tracker where there will be a list of locations to walk along to get to the desired endpoint. These are only name of location or regions. Stuff like taking lake hylia warps, using the mirror wont be shown there for now flying between points or entering doors will be visible as the locations have "states" written besides them `OW/Inside/Cave`. these might not be the most intuitive routes or even the "fastest" but they should be valid routes nontheless.
If there is no route to be found by the tracker it will display `No route found` as the only text. 

The "Route Mode" will turn itself of after each calculation.