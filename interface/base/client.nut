BaseInterface <- {
    IsInterfaceOpen = false
    
    function ChangeControlsState(){
        if(IsInterfaceOpen){
            this.IsInterfaceOpen = false
            disableControls(false)
            setCursorVisible(false)
            return
        }
        this.IsInterfaceOpen = true
        disableControls(true)
        setCursorPosition(4096,4096)
        setCursorVisible(true)
        return
    }
}

addEventHandler("onInit", function(){
    disableLogicalKey(GAME_END, true)
    disableLogicalKey(GAME_SCREEN_LOG, true)
    disableLogicalKey(GAME_SCREEN_MAP, true)
    disableLogicalKey(GAME_LAME_POTION, true)
    disableLogicalKey(GAME_LAME_HEAL, true)
})