class GUI.Offset
{
#private:
    _offsetPx = null

#public:
    constructor()
    {
        _offsetPx =
        {
            x = 0
            y = 0
        }
    }

    function getOffsetPx()
    {
        return _offsetPx
    }

    function setOffsetPx(x, y)
    {
        _offsetPx.x = x
        _offsetPx.y = y
    }

    function getOffset()
    {
        return {x = anx(_offsetPx.x), y = any(_offsetPx.y)}
    }

    function setOffset(x, y)
    {
        setOffsetPx(nax(x), nay(y))
    }
}
