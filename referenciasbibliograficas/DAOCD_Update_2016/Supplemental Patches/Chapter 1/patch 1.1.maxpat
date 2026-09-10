{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 545.0, 224.0, 640.0, 506.0 ],
		"bglocked" : 0,
		"defrect" : [ 545.0, 224.0, 640.0, 506.0 ],
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
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "toggle",
					"outlettype" : [ "int" ],
					"id" : "obj-7",
					"patching_rect" : [ 30.0, 150.0, 20.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "dac~",
					"id" : "obj-5",
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 180.0, 37.0, 20.0 ],
					"numinlets" : 2,
					"fontsize" : 12.0,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.1",
					"outlettype" : [ "signal" ],
					"id" : "obj-3",
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 150.0, 42.0, 20.0 ],
					"numinlets" : 2,
					"fontsize" : 12.0,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "mirror~",
					"outlettype" : [ "signal" ],
					"id" : "obj-2",
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 120.0, 49.0, 20.0 ],
					"numinlets" : 1,
					"fontsize" : 12.0,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 474",
					"outlettype" : [ "signal" ],
					"id" : "obj-1",
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 90.0, 68.0, 20.0 ],
					"numinlets" : 2,
					"fontsize" : 12.0,
					"numoutlets" : 1
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 174.5, 69.5, 174.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
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
