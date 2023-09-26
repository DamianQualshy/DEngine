class BPacketBool {
    name = "bool"

    static function write(packet, value) {
        packet.writeBool(value)
    }

    static function read(packet) {
        return packet.readBool()
    }
}

class BPacketInt8 {
    name = "int8"

    static function write(packet, value) {
        packet.writeInt8(value)
    }

    static function read(packet) {
        return packet.readInt8()
    }
}

class BPacketUInt8 {
    name = "uint8"

    static function write(packet, value) {
        packet.writeUInt8(value)
    }

    static function read(packet) {
        return packet.readUInt8()
    }
}

class BPacketInt16 {
    name = "int16"

    static function write(packet, value) {
        packet.writeInt16(value)
    }

    static function read(packet) {
        return packet.readInt16()
    }
}

class BPacketUInt16 {
    name = "uint16"

    static function write(packet, value) {
        packet.writeUInt16(value)
    }

    static function read(packet) {
        return packet.readUInt16()
    }
}

class BPacketInt32 {
    name = "int32"

    static function write(packet, value) {
        packet.writeInt32(value)
    }

    static function read(packet) {
        return packet.readInt32()
    }
}

class BPacketUInt32 {
    name = "uint32"

    static function write(packet, value) {
        packet.writeUInt32(value)
    }

    static function read(packet) {
        return packet.readUInt32()
    }
}

class BPacketString {
    name = "string"

    static function write(packet, value) {
        packet.writeString(value)
    }

    static function read(packet) {
        return packet.readString()
    }
}

class BPacketFloat {
    name = "float"

    static function write(packet, value) {
        packet.writeFloat(value)
    }

    static function read(packet) {
        return packet.readFloat()
    }
}

class BPacketArray {
    name = "array"
    _type = null

    constructor(type) {
        this._type = type
    }

    function write(packet, elements) {
        packet.writeUInt8(elements.len())
        foreach (element in elements) {
            this._type.write(packet, element)
        }
    }

    function read(packet) {
        local elements = []
        local count = packet.readUInt8()

        for (local i = 0; i < count; ++i) {
            elements.push(this._type.read(packet))
        }

        return elements
    }
}

class BPacketTable {
    name = "table"
    _scheme = null

    constructor(scheme) {
        this._scheme = scheme
    }

    function write(packet, elements) {
        foreach (index, type in this._scheme) {
            type.write(packet, elements[index])
        }
    }

    function read(packet) {
        local elements = {}

        foreach (index, type in this._scheme) {
            elements[index] <- type.read(packet)
        }

        return elements
    }
}