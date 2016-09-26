module derelict.util.buildhelper;

import std.traits;

template BuildLoadSymbols(alias T, bool doThrow = false)
{
	string _buildLoadSymbols(alias T, bool doThrow = false)()
	{
		static if(doThrow)
			enum dthrow = "true";
		else
			enum dthrow = "false";
		
		string bindlist = "\n{";
		foreach(mem; __traits(derivedMembers, T))
		{
			static if( isFunctionPointer!(__traits(getMember, T, mem)) /*&& !is(typeof(__traits(getMember, T, mem)) == immutable)*/)
			{
				bindlist ~= "\tbindFunc(" ~ mem ~ ", \"" ~ mem ~ "\", " ~ dthrow ~ ");\n";
			}
		}
		bindlist ~= "}";
		return bindlist;
	}

	enum BuildLoadSymbols = _buildLoadSymbols!(T, doThrow)();
}

