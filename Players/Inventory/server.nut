

ItemUseMessage.bind(function(pid, message){
	itemDatabase[message.itemId].onUse(pid);
});

addEventHandler("onItemUse", function(playerid, instance){
	print("onPlayerUseItem " + playerid + " " + instance);
});

addEventHandler("onItemCreate", function(instance){
	print("onItemCreate " + instance);
})