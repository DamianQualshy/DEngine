class CalendarMessage_SeasonChange extends BPacketMessage {
	</ type = BPacketString />
	season = ""
}

class CalendarMessage_TimeCheck extends BPacketMessage {
	</ type = BPacketInt32 />
	hour = -1

	</ type = BPacketInt32 />
	minute = -1

	</ type = BPacketInt32 />
	day = -1

	</ type = BPacketInt32 />
	month = -1

	</ type = BPacketInt32 />
	year = -1

	</ type = BPacketString />
	season = ""
}