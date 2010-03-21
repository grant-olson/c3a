models/players/arachna/hair
{
	cull disable
	{
		map models/players/arachna/hair.tga
		rgbGen lightingDiffuse
		alphaFunc GE128
	}
}

models/players/arachna/jewelry
{
	cull disable
	{
		map models/players/arachna/jewelry.tga
		rgbGen lightingDiffuse
		alphaFunc GE128
	}
}

models/players/arachna/torso
{
	{
		map models/players/arachna/torso.tga
		rgbGen lightingDiffuse
	}
        {
		map textures/effects/skinspecmult.tga
		blendfunc gl_dst_color gl_src_color
		rgbGen identity
		tcGen environment 
	}
}

models/players/arachna/spider
{
	{
		map models/players/arachna/spider.tga
		rgbGen lightingDiffuse
	}
	{
		map textures/oafx/flare.tga
		blendfunc add
		rgbGen lightingDiffuse
		tcMod rotate 4
		tcGen environment 
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 4 2
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 8 4
	}
}

models/players/arachna/hair_widowe
{
	cull disable
	{
		map models/players/arachna/hair_widowe.tga
		rgbGen lightingDiffuse
		alphaFunc GE128
	}
}

models/players/arachna/jewelry_widowe
{
	cull disable
	{
		map models/players/arachna/jewelry_widowe.tga
		rgbGen lightingDiffuse
		alphaFunc GE128
	}
        {
		map textures/oafx/flare.tga
		blendfunc add
		rgbGen lightingDiffuse
		tcMod rotate 4
		tcGen environment 
	}
}

models/players/arachna/torso_widowe
{
	{
		map models/players/arachna/torso_widowe.tga
		rgbGen lightingDiffuse
	}
	
}

models/players/arachna/spider_widowe
{
	{
		map models/players/arachna/spider_widowe.tga
		rgbGen lightingDiffuse
	}
	{
		map textures/oafx/flare.tga
		blendfunc add
		rgbGen lightingDiffuse
		tcMod rotate 4
		tcGen environment 
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 4 2
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 8 4
	}
}

models/players/arachna/hair_widowe_red
{
	cull disable
	{
		map models/players/arachna/hair_widowe_red.tga
		rgbGen lightingDiffuse
		alphaFunc GE128
	}
}

models/players/arachna/torso_widowe_red
{
	{
		map models/players/arachna/torso_widowe_red.tga
		rgbGen lightingDiffuse
	}
	
}

models/players/arachna/spider_widowe_red
{
	{
		map models/players/arachna/spider_widowe_red.tga
		rgbGen lightingDiffuse
	}
	{
		map textures/oafx/flare.tga
		blendfunc add
		rgbGen lightingDiffuse
		tcMod rotate 4
		tcGen environment 
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 4 2
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 8 4
	}
}

models/players/arachna/hair_widowe_blue
{
	cull disable
	{
		map models/players/arachna/hair_widowe_red.tga
		rgbGen lightingDiffuse
		alphaFunc GE128
	}
}

models/players/arachna/torso_widowe_blue
{
	{
		map models/players/arachna/torso_widowe_red.tga
		rgbGen lightingDiffuse
	}
	
}

models/players/arachna/spider_widowe_blue
{
	{
		map models/players/arachna/spider_widowe_red.tga
		rgbGen lightingDiffuse
	}
	{
		map textures/oafx/flare.tga
		blendfunc add
		rgbGen lightingDiffuse
		tcMod rotate 4
		tcGen environment 
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 4 2
	}
	{
		map textures/detail/d_rock.tga
		blendfunc gl_dst_color gl_src_color
		tcMod scale 8 4
	}
}