local descriptionDraw = GUI.Draw({
	positionPx = {x = 10, y = 125}
	text = "Choose your gender:"
})

local maleRadioButton = GUI.RadioButton({
	positionPx = {x = 10, y = 147}
	sizePx = {width = 20, height = 15}
	file = "INV_SLOT_EQUIPPED_FOCUS.TGA"
	draw = {text = "O"}
	group = "Gender"
})

local maleDescriptionDraw = GUI.Draw({
	positionPx = {x = 35, y = 147}
	text = "Male"
}) 

local femaleRadioButton = GUI.RadioButton({
	positionPx = {x = 10, y = 169}
	sizePx = {width = 20, height = 15}
	file = "INV_SLOT_EQUIPPED_FOCUS.TGA"
	draw = {text = "O"}
	group = "Gender"
})

local femaleDescriptionDraw = GUI.Draw({
	positionPx = {x = 35, y = 169}
	text = "Female"
}) 

local soirefRadioButton = GUI.RadioButton({
	positionPx = {x = 10, y = 191}
	sizePx = {width = 20, height = 15}
	file = "INV_SLOT_EQUIPPED_FOCUS.TGA"
	draw = {text = "O"}
	group = "Gender"
})

local soirefDescriptionDraw = GUI.Draw({
	positionPx = {x = 35, y = 191}
	text = "Soiref"
}) 

addEventHandler("onInit",function()
{
	descriptionDraw.setVisible(true)

	maleRadioButton.setVisible(true)
	maleDescriptionDraw.setVisible(true)
	
	femaleRadioButton.setVisible(true)
	femaleDescriptionDraw.setVisible(true)
	
	soirefRadioButton.setVisible(true)
	soirefDescriptionDraw.setVisible(true)
	
	setCursorVisible(true)
})
