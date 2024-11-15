# Drakania Engine
Drakania Engine is made with intention to help new scripters with making their own servers for Gothic 2 Online.

The package aims to contain functions from single-player and utilizing the G2O's possibilities to it's fullest, synchronizing the information between client and server in a vanilla-friendly way. That means, for example, if you don't want to create your own GUIs for stats or journal, you can just use the one that already exists client-side in the base game.

dEngine doesn't require any outside modules or frameworks, since it already contains:
- [Patrix's GUI Framework](https://gitlab.com/g2o/scripts/gui-framework)
- [Patrix's MySQL Module](https://gitlab.com/GothicMultiplayerTeam/modules/mysql)
- [Bimbol's Packet Serialization](https://gitlab.com/bcore1/bpackets)
- [LocalStorage Module](https://gitlab.com/GothicMultiplayerTeam/modules/LocalStorage)
- [BASS Module](https://gitlab.com/GothicMultiplayerTeam/modules/bass)
- [DocNITE's Tween Port](https://gitlab.com/g2o/scripts/tween.nut)
- [Patrix's AreaManager](https://gitlab.com/g2o/scripts/areamanager)
- [Patrix's Inventory](https://gitlab.com/g2o/scripts/inventory)
- [BASSWrapper](https://github.com/G2O-Script-Workshop/BASSWrapper)

## I want to make it VERY CLEAR that:
- It is still in development, but I'd rather push it as it is now rather than wait and wait.
Maybe I will make a wiki, maybe I won't, who knows. 
- This is NOT a gamemode. It's a framework that's supposed to HELP with making a gamemode.
- Every change that shouldn't be considered default/vanilla (eg. stamina, professions) or features that block the customization (eg. forced loot tables) will NEVER be in this repository. It can be in an eventual fork or a gamemode though.

# How to setup
Clone the code repo
```bash
git clone https://github.com/DamianQualshy/DEngine
cd DEngine
```
Initiate Submodules
```bash
git submodule update --init --recursive
git submodule update --remote --force
```
Download the 0.3.0 server files and place them in the cloned repo directory, then import the engine in **config.xml** file
```xml
	<!-- Submodules -->
		<import src="Submodules/import.xml" />

	<!-- dEngine -->
		<import src="dEngine/import.xml" />
	
	<!-- Server -->
		<!-- Import your scripts here -->
```
Add the required modules to the **config.xml** file of your server. You don't need to download them manually.
```xml
<module src="LocalStorage.dll" type="client" />
<module src="sq_bass.dll" type="client" />
```
Make sure you're using latest [MySQL](https://gitlab.com/GothicMultiplayerTeam/modules/mysql/-/releases) module, and for your operating system of choice
```xml
<module src="MySQL.x64.dll" type="server" /> <!-- Windows 64-bit -->
```
Before your first launch make sure everything is properly set up, following this setup and the **Server manual** articles on [Gothic 2 Online Docs](https://gothicmultiplayerteam.gitlab.io/docs/0.3.0/server-manual/configuration/). For any problems or possible ideas please leave an issue or create a fork to implement the patch yourself.

## Features
- Hero Class (Player, NPC)
- Server-side Inventory
- Chat (Default)
- NPC AI (Modified Bimbol example)
- Waynet
- NPC Roaming (WIP)
- Journal
- Dialogues (WIP)
- Calendar
- Seasons
- MySQL Wrapper
- Events for AreaManager
- Map split into Chunks

### To-Do
- NPC Routines
- Trading
- Quest System(?)

#### Optional Features (and Tools)
- GUI Creator in real time
- World Builder
- Admin Control Panel
- Player Settings
- Placing NPCs in-game
- God Mode
- Flying/K spam

## Structure
```
├── dEngine/
│   ├── Client/
│   │   ├── CChat.nut
│   │   ├── CLocalPlayer.nut
│   │   ├── CPlayerList.nut
│   │   ├── Calendar.nut
│   │   ├── Client.nut
│   │   ├── Functions/
│   │   │   ├── Dialoge.nut
│   │   │   ├── Journal.nut
│   ├── Server/
│   │   ├── AI/
│   │   │   ├── base.nut
│   │   │   ├── behaviour/
│   │   │   │   ├── agressive/
│   │   │   │   │   ├── humanoid.nut
│   │   │   │   │   ├── monster.nut
│   │   │   │   ├── agressive.nut
│   │   │   │   ├── neutral.nut
│   │   │   ├── helpers.nut
│   │   │   ├── routines/
│   │   │   │   ├── stand.nut
│   │   │   │   ├── task.nut
│   │   │   ├── state.nut
│   │   │   ├── update.nut
│   │   │   ├── waynet.nut
│   │   ├── Calendar.nut
│   │   ├── Functions/
│   │   │   ├── Dialoge.nut
│   │   │   ├── Journal.nut
│   │   │   ├── Utility/
│   │   │   │   ├── FileCheck.nut
│   │   │   │   ├── Log.nut
│   │   ├── HeroClass/
│   │   │   ├── NPC.nut
│   │   │   ├── Player.nut
│   │   │   ├── Prototype.nut
│   │   ├── Inventory.nut
│   │   ├── MySQL.nut
│   │   ├── Server.nut
│   ├── Shared/
│   │   ├── Class/
│   │   │   ├── Chunk.nut
│   │   │   ├── DialogeManager.nut
│   │   ├── Config.nut
│   │   ├── Constants.nut
│   │   ├── Functions/
│   │   ├── PacketMessages/
│   │   │   ├── Calendar.nut
│   │   │   ├── Dialogue.nut
│   │   │   ├── Journal.nut
│   │   ├── Tables/
│   │   │   ├── Seasons.nut
│   │   ├── Utility/
│   │   │   ├── Convert.nut
│   │   │   ├── Position.nut
├── Submodules/
│   ├── BASSWrapper/
│   ├── Overrides/
│   ├── areamanager/
│   ├── bpackets/
│   ├── gui-framework/
│   ├── inventory/
│   ├── tween.nut/
├── Server/
```