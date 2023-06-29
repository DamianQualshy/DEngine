/*

	Script: Multiple Inheritance
	Author: Calysto Canem

*/

function classes(...)
{
	local c = class extends vargv[0] {}

	for (local i = 1, end = vargv.len(); i < end; ++i)
	{
		foreach (name, value in vargv[i])
		{
			if (name != "constructor")
				c[name] <- value
		}
	}

	return c
}
