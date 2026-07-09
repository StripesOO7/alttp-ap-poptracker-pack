# A Link to the Past AP Tracker

Archipelago A Link to the Past tracker pack for [PopTracker](https://github.com/black-sliver/PopTracker/) with Autotracking.

PopTracker v0.33.1 or higher is required.


First version of an Archipelago compatible alttp-Tracker pack

## current working settings:
    - "open", "Inverted" and "standard" starting-options are supported
    - tracking of dungeon bosses and if they are beatable
    - estimation of what is currently accessible depending on your keycount AND already collected checks (!collect or savescumming
    will mess with that)
    - every check should get tracked
    - shop-sanity, shop shuffle (including inventory and price-shuffle tracking (manual))
    - basic logic and minor glitches work. Overworld glitches and higher logic can have problems
    - pot-shuffle works, enemy_keydrop_shuffle works
    - full ER tracking possible (manual or automatic via SNI connection)
    - stun prize, pull trees, hoarder crab drops trackable
    - when ER is enabled you can use the "Route Mode" and select a start and end point to get a proposed route between
    these 2 points. (save&quit not considered at the moment)

## not working:
    - nothing, if you use the latest version of Archipelago

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
This section serves as a tutorial on how to use it.

### Prerequisites
Have Entrance Rando (ER) set to the setting you want. (Dungeons/Full/Insanity)
- Dungeon -> Only the drop-downs and all dungeon entrances are not connected/unknown and need to be connected. 
This includes also Dungeons Simple, Dungeons Full and Dungeons Crossed,
else has its original connection intact.
- Full -> includes every possible other ER setting besides Insanity. 
This includes Simple ER, Restricted ER, Full ER, and Crossed ER
- Insanity -> gives each door 2 connections. One for entering and one for exiting through a given door. Since these do
  not lead to the same locations in this setting. 

### How to use it
- ALL interactions use the images inside the location-popups. Not the diamonds or the title texts of the popups!!!
#### Connecting entrances
If you want to connect 2 doors/entrances with each other, you go to the Entrances tab on the tracker. 
Then you hover over the entrance you started/went into and **LEFTCLICK** the door-icon. This will highlight that entrance in a normally **BLUE** (or whatever you set the blue color to) hue/highlight. This now indicates that this entrance has been selected as the first of the connection pair. 
Now do the same for the section door/entrance you came out of.

This will connect these 2 doors/entrances and you will see the door-image change to the corresponding image for the "other side" AND have it show the name of the other side in a text-overlay over the image.

#### Removing a connection
This can be done by **RIGHTCLICK**ing on any of the sides you want to disconnect. This will change the icon back to a "closed door"-image.
Another way to do this is by just doing the steps for connecting entrances over an already existing one. This will unlink the previous connection and set the new one.

#### Finding the corresponding entrance
You can **MIDDLECLICK** one side of a connected entrance-pair and both sides will get a **RED** (or whatever you changes the red to) hue/highlight and it changes the ER tabs so that both sides should be visible. The highlight will automatically vanish after 5-10 seconds.

### Finding a way between two entrances
As of pack version 0.4.2 it is possible to have the tracker tell you what it thinks is the quickest route (least region transitions) between two points if there is any. 

In the bottom middle of the tracker is an item/a setting called "Route Mode". 

Set this to **ON** and the connection feature for entrances get disabled. 
Instead, you now **LEFTCLICK** the two entrances you want a route to be calculated for. After the second click you will get sent to the "Route" tab of the tracker where a route will be displayed in the form of a list of locations to walk along to get to the desired endpoint. These are only the names of locations or regions. Methods like taking Lake Hylia warps, using the mirror won't be shown there for now. Flying between points or entering doors will be visible as the locations have "states" written besides them `OW/Inside/Cave`. These might not be the most intuitive routes or even the "fastest" (in terms of time) but they should be valid routes nontheless.
If there is no route to be found by the tracker, it will display `No Route Found` as the only text. 

The "Route Mode" will turn itself off after each calculation.
