// Packet ids above this value will be used to enumerate messages
const BPACKET_MESSAGE_ID = 100

///////////////////////////////////////////
/// Registry
///////////////////////////////////////////
local registered = []

//-----------------------------------------

class BPacketMessage {
    __id = -1
    __meta = null
    __flags = 0
    __fields = null
    __handlers = null

    constructor(...) {
        local len = vargv.len()
        for (local i = 0; i < len; ++i) {
            local attrs = this.__fields[i]
            this[attrs.field] = vargv[i]
        }
    }

    function header() {
        return BPACKET_MESSAGE_ID + this.__id
    }

    function write(packet, message = null) {
        local message = message || this

        local flags = 0
        if (this.__flags != 0) {
            flags = this._calculateFlags(message)
            if (flags <= 255) {
                packet.writeUInt8(flags)
            } else if (flags <= 65535) {
                packet.writeUInt16(flags)
            } else {
                packet.writeInt32(flags)
            }
        }

        local bit = 1
        foreach (attrs in this.__fields) {
            local value = message[attrs.field]
            if (!attrs.optional || flags & bit) {
                attrs.type.write(packet, value)
            }

            if (attrs.optional) {
                bit = bit << 1
            }
        }
    }

    function read(packet) {
        local message = this()

        local flags = 0
        if (this.__flags != 0) {
            if (this.__flags <= 255) {
                flags = packet.readUInt8()
            } else if (this.__flags <= 65535) {
                flags = packet.readUInt16()
            } else {
                flags = packet.readInt32()
            }
        }

        local bit = 1
        foreach (attrs in this.__fields) {
            if (!attrs.optional || flags & bit) {
                message[attrs.field] = attrs.type.read(packet)
            }

            if (attrs.optional) {
                bit = bit << 1
            }
        }

        return message
    }

    function serialize() {
        local packet = Packet()
        packet.writeUInt8(this.header())

        this.write(packet)
        return packet
    }

    function format() {
        local result = "< Packet: " + this.__id + " >"
        foreach (index, attrs in this.__fields) {
            result += "\n+ " + attrs.field + ": " + attrs.type.name + " = " + this[attrs.field]
        }

        return result
    }

    static function deserialize(packet, skip_header = false) {
        if (!skip_header) {
            packet.readUInt8() // Just change offset
        }

        return this.read(packet)
    }

    static function bind(callback) {
        this.__handlers.push(callback)
        return callback
    }

    static function unbind(callback) {
        local len = this.__handlers.len()
        for (local i = 0; i < len; ++i) {
            if (callback == this.__handlers[i]) {
                this.__handlers[i] = null
            }
        }

        // Handlers need clean-up from nulls
        this.__meta.dirty = true
    }

    static function clear() {
        this.__handlers.clear()
    }

    static function _cleanHandlers() {
        local len = this.__handlers.len()
        for (local i = 0; i < len;) {
            if (this.__handlers[i] == null) {
                this.__handlers[i] = this.__handlers[--len]
                this.__handlers.pop()
            } else {
                ++i
            }
        }

        this.__meta.dirty = false
    }

    static function _calculateFlags(message) {
        local bit = 1, flags = 0
        foreach (attrs in this.__fields) {
            if (attrs.optional) {
                local value = message[attrs.field]
                if (value != null) {
                    flags = flags | bit
                }

                bit = bit << 1
            }
        }

        return flags
    }

    ///////////////////////////////////////////
    /// Meta-methods
    ///////////////////////////////////////////

    function _inherited(attrs) {
        this.__fields <- []

        local is_abstract = attrs != null && "abstract" in attrs && attrs.abstract
        if (!is_abstract) {
            this.__handlers <- []
            this.__id <- registered.len()
            this.__meta <- {dirty = false}

            registered.push(this)
        }
	}

    function _newmember(index, value, attributes, is_static) {
        if (!is_static && attributes) {
            attributes.field <- index

            if (!("type" in attributes)) {
                throw "Missing 'type' in attributes for field '" + index + "'!"
            }

            if (!("optional" in attributes)) {
                attributes.optional <- false
            }

            if (attributes.optional) {
                if (this.__flags == 0) {
                    this.__flags <- 1
                } else {
                    this.__flags <- this.__flags << 1
                }

                if (this.__flags < 0) {
                    throw "Optional fields limit exceeded, maximum 32!"
                }
            }

            this.__fields.push(attributes)
        }

        // Setup new members
        this[index] <- value
    }
}

///////////////////////////////////////////
/// Events
///////////////////////////////////////////

local function packet_handler(packet) {
    local header = packet.readUInt8()
    if (header >= BPACKET_MESSAGE_ID) {
        local index = header - BPACKET_MESSAGE_ID
        if (index < registered.len()) {
            return registered[index].deserialize(packet, true)
        }
    }

    return null
}

local function cli_packet_handler(packet) {
    local message = packet_handler(packet)
    if (message) {
        if (message.__meta.dirty) {
            message._cleanHandlers()
        }

        foreach (handler in message.__handlers) {
            handler(message)
        }
    }
}

local function srv_packet_handler(pid, packet) {
    local message = packet_handler(packet)
    if (message) {
        if (message.__meta.dirty) {
            message._cleanHandlers()
        }

        foreach (handler in message.__handlers) {
            handler(pid, message)
        }
    }
}

addEventHandler("onPacket", SERVER_SIDE ? srv_packet_handler : cli_packet_handler)
