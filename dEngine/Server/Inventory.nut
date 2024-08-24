local _giveItem = giveItem;
local _removeItem = removeItem;
local _equipItem = equipItem;
local _unequipItem = unequipItem;
local _useItem = useItem;

class Inventory {
	pid = -1;

	items = {};


		constructor(pid){
			this.pid = pid;
		}


	function giveItem(instance, amount){
		instance = convert(instance, "string").toupper();
		amount = convert(amount, "integer");

		if(this.items.rawin(instance)){
			this.items[instance].amount += amount;
		} else {
			this.items[instance] <- {amount = amount};
		}

		_giveItem(this.pid, instance, amount);
	}

	function removeItem(instance, amount){
		instance = convert(instance, "string").toupper();
		amount = convert(amount, "integer");

		if(this.items.rawin(instance)){
			if(this.items[instance].amount >= amount + 1){
				this.items[instance].amount -= amount;
			} else {
				this.items.rawdelete(instance);
			}
		}

		_removeItem(this.pid, instance, amount);
	}

	function equipItem(instance){
		instance = convert(instance, "string").toupper();

		if(this.items.rawin(instance)){
			_equipItem(this.pid, instance);
		}
	}

	function unequipItem(instance){
		instance = convert(instance, "string").toupper();

		if(this.items.rawin(instance)){
			_unequipItem(this.pid, instance);
		}
	}

	function useItem(instance){
		instance = convert(instance, "string").toupper();

		if(this.items.rawin(instance)){
			if(this.items[instance].amount >= 2){
				this.items[instance].amount - 1;
			} else {
				this.items.rawdelete(instance);
			}
			_useItem(this.pid, instance);
		}
	}
}