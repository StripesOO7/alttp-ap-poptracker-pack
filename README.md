# A Link to the Past AP Tracker

Archipelago A Link to the Past tracker pack for [PopTracker](https://github.com/black-sliver/PopTracker/) with Autotracking.

PopTracker v0.23.0 or higher is recommended.


First version of an Archipelago compatible alttp-Tracker pack

current working settings:
    - changing starting options between "open", "inverted" and "standard"
    - tracking of Dungonbosses and if they are beatable
    - every check should get tracked
    - basic, glitchless logic for "open" and "inverted",
    - shop-sanity


not working: 
    - any glitch settings
    - goal tracking not implemented yet
    - big-/smallkey, map and compass shuffle option not implemented (current assumption is full-shuffle for everyone of those)

If you want to use Auto-Tracking ofor your Setttings add this to your alttp/\_\_init\_\_.py File within the "ALTTPWORLD"-class

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

Some of these settings are curretnly purely cosmetic or just for keeping track of minor settings
