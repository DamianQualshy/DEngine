/////////////////////////////////////////
///	Network statistics class
/////////////////////////////////////////

NetStats <- {
	_title = Draw(anx(5), any(5), "Network debug"),
	_ping = null,
	_fps = null,
	_receivedPackets = null,
	_lostPackets = null,
	_lostLastSec = null,
	_messageResend = null,
	_byteToResend = null,
	_messageSend = null,
	_byteToSend = null,

	visible = false
}

function NetStats::init()
{
	local height = _title.heightPx

	_ping = Draw(anx(5), any(7 + height), "")
	_fps = Draw(anx(5), any(7 + height * 2), "")
	_receivedPackets = Draw(anx(5), any(7 + height * 3), "")
	_lostPackets = Draw(anx(5), any(7 + height * 4), "")
	_lostLastSec = Draw(anx(5), any(7 + height * 5), "")
	_messageResend = Draw(anx(5), any(7 + height * 6), "")
	_byteToResend = Draw(anx(5), any(7 + height * 7), "")
	_messageSend = Draw(anx(5), any(7 + height * 8), "")
	_byteToSend = Draw(anx(5), any(7 + height * 9), "")

	setTimer(function()
	{
		NetStats.update()
	}, 500, 0)
}

function NetStats::setVisible(visible)
{
	this.visible = visible

	_title.visible = visible
	_ping.visible = visible
	_fps.visible = visible
	_receivedPackets.visible = visible
	_lostPackets.visible = visible
	_lostLastSec.visible = visible
	_messageResend.visible = visible
	_byteToResend.visible = visible
	_messageSend.visible = visible
	_byteToSend.visible = visible
}

function NetStats::update()
{
	local stats = getNetworkStats()

	_ping.text = format("Ping: %i ms", getPlayerPing(heroId))
	_fps.text = format("FPS: %i", getFpsRate())
	_receivedPackets.text = format("Received packets: %i", stats.packetReceived)
	_lostPackets.text = format("Lost packets: %i", stats.packetlossTotal)
	_lostLastSec.text = format("Lost packet last second: %i", stats.packetlossLastSecond)
	_messageResend.text = format("Message to resend: %i", stats.messagesInResendBuffer)
	_byteToResend.text = format("Message to send: %i", stats.messageInSendBuffer)
	_messageSend.text = format("Bytes to resend: %i", stats.bytesInResendBuffer)
	_byteToSend.text = format("Bytes to send: %i", stats.bytesInSendBuffer)
}

/////////////////////////////////////////
///	Events
/////////////////////////////////////////

addEventHandler("onInit", function()
{
	NetStats.init()
})

addEventHandler("onKey", function(key)
{
	switch (key)
	{
		case KEY_F6:
			if (!chatInputIsOpen())
				NetStats.setVisible(!NetStats.visible)
			break
	}
})
