class GUI.Margin
{
#protected:
    _marginPx = null

#public:
    constructor()
    {
        _marginPx =
        {
            top = 0,
            right = 0
            bottom = 0,
            left = 0,
        }
    }

    function getMarginPx()
    {
        return _marginPx
    }

    function setMarginPx(top, right, bottom, left)
    {
        _marginPx.top = top
        _marginPx.right = right
        _marginPx.bottom = bottom
        _marginPx.left = left
    }

    function getMargin()
    {
        return {
            top = any(_marginPx.top)
            right = anx(_marginPx.right)
            bottom = any(_marginPx.bottom)
            left = anx(_marginPx.left)
        }
    }

    function setMargin(top, right, bottom, left)
    {
        setMarginPx(nay(top), nax(right), nay(bottom), nax(left))
    }
}
