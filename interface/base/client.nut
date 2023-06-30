BaseInterface <- {
    IsInterfaceOpen = false
    
    function ChangeControlsState(){
        setFreeze(!isFrozen())
        disableControls(!isControlsDisabled())
        setCursorVisible(!isCursorVisible())
        this.IsInterfaceOpen = !this.IsInterfaceOpen
    }
}

addEventHandler("onInit", function(){
    disableLogicalKey(GAME_END, true)
    disableLogicalKey(GAME_SCREEN_LOG, true)
    disableLogicalKey(GAME_SCREEN_MAP, true)
    disableLogicalKey(GAME_LAME_POTION, true)
    disableLogicalKey(GAME_LAME_HEAL, true)
})