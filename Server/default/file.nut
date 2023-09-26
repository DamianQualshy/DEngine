io <- {}

enum io_type
{
	LINE,
	ALL
}

class io.file extends file
{
	constructor(fileName, mode)
	{
		errorMsg = null

		try
		{
			base.constructor(fileName, mode)
			isOpen = true
		}
		catch (msg)
		{
			errorMsg = msg
			isOpen = false
		}
	}

	function write(text)
	{
		foreach (char in text)
		{
			writen(char, 'b')
		}
	}

	function read(type = io_type.ALL)
	{
		if (type == io_type.LINE)
		{
			local line = ""
			local char

			while (!eos() && (char = readn('b')))
			{
				if (char != '\n')
					line += char.tochar()
				else
					return line
			}

			return line.len() == 0 ? null : line
		}
		else if (type == io_type.ALL)
		{
			local content = ""
			local char

			while (!eos() && (char = readn('b')))
			{
				content += char.tochar()
			}

			return content.len() == 0 ? null : content
		}

		return null
	}

	function close()
	{
		base.close()
		isOpen = false
	}

	errorMsg = null
	isOpen = false
}