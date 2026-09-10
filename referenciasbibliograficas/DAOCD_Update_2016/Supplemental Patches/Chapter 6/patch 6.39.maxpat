{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 25.0, 69.0, 295.0, 127.0 ],
		"bglocked" : 0,
		"defrect" : [ 25.0, 69.0, 295.0, 127.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "line~",
					"numoutlets" : 2,
					"id" : "obj-2",
					"fontname" : "Arial",
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 30.0, 59.0, 35.0, 20.0 ],
					"fontsize" : 11.595187,
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "0, 1. 50 0.7 100 0.7 2000 0. 1000",
					"numoutlets" : 1,
					"id" : "obj-1",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patching_rect" : [ 30.0, 30.0, 194.0, 18.0 ],
					"fontsize" : 11.595187,
					"numinlets" : 2
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
