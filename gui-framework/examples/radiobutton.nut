local description = GUI.Draw(anx(0), any(125), "Choose your gender:")

local maleRadio = GUI.RadioButton(anx(0), any(147), anx(20), any(15), "INV_SLOT_EQUIPPED_FOCUS.TGA", "O", "Gender")
local maleDescriptipn = GUI.Draw(anx(25), any(147), "Male") 

local femaleRadio = GUI.RadioButton(anx(0), any(169), anx(20), any(15), "INV_SLOT_EQUIPPED_FOCUS.TGA", "O", "Gender")
local femaleDescriptipn = GUI.Draw(anx(25), any(169), "Female") 

local soirefRadio = GUI.RadioButton(anx(0), any(191), anx(20), any(15), "INV_SLOT_EQUIPPED_FOCUS.TGA", "O", "Gender")
local soirefDescriptipn = GUI.Draw(anx(25), any(191), "Soiref")

addEventHandler("onInit",function()
{
	description.setVisible(true)

	maleRadio.setVisible(true)
	maleDescriptipn.setVisible(true)
	
	femaleRadio.setVisible(true)
	femaleDescriptipn.setVisible(true)
	
	soirefRadio.setVisible(true)
	soirefDescriptipn.setVisible(true)
	
	setCursorVisible(true)
})
