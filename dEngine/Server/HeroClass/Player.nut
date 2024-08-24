Players <- {};

class Player extends PrototypeHero {
	serial = "";
	mac = "";
	ip = "";

	inventory = {};


		constructor(id, params){
			this.serial = getPlayerSerial(id);
			this.mac = getPlayerMacAddr(id);
			this.ip = getPlayerIP(id);

			this.Init(id, params);

			Players[this.id] <- this;
			this.inventory = Inventory(id);
		}


	function getSerial(){
		return this.serial;
	}

	function getMacAddress(){
		return this.mac;
	}

	function getIPAddress(){
		return this.ip;
	}
}