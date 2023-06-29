local window = GUI.Window(0, 0, anx(400), any(200), "MENU_INGAME.TGA", null, true)

local infoDraw = GUI.Draw(anx(50), any(20), "0", window)

local horizontalRange = GUI.Range(anx(50), 0, anx(200), any(20), "MENU_SLIDER_BACK.TGA" "MENU_SLIDER_POS.TGA", Orientation.Horizontal, window)
horizontalRange.setMaximum(100)
horizontalRange.setMinimum(0)
horizontalRange.setStep(1)

horizontalRange.indicator.setSizePx(RANGE_INDICATOR_SIZE / 2, horizontalRange.indicator.getSizePx().height)
horizontalRange.setMarginPx(5, 0, 10, 0)

local verticalRange = GUI.Range(anx(30), 0, anx(20), any(200), "MENU_INGAME.TGA", "MENU_SLIDER_POS.TGA", Orientation.Vertical, window)
verticalRange.setMaximum(50.0)
verticalRange.setMinimum(0.0)
verticalRange.setStep(0.5)

addEventHandler("onInit",function()
{
	setCursorVisible(true)
	window.setVisible(true)
})

addEventHandler("GUI.onChange", function(self)
{
	infoDraw.setText(self.getValue())
})
