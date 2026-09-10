{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 545.0, 224.0, 330.0, 174.0 ],
		"bglocked" : 0,
		"defrect" : [ 545.0, 224.0, 330.0, 174.0 ],
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
					"maxclass" : "flonum",
					"numinlets" : 1,
					"patching_rect" : [ 120.0, 60.0, 50.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"id" : "obj-9",
					"outlettype" : [ "float", "bang" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "mirror~ copies its input to its output",
					"numinlets" : 1,
					"patching_rect" : [ 105.0, 120.0, 197.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"id" : "obj-6",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"numinlets" : 1,
					"patching_rect" : [ 15.0, 90.0, 20.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-7",
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "dac~",
					"numinlets" : 2,
					"patching_rect" : [ 45.0, 120.0, 37.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"id" : "obj-5",
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.1",
					"numinlets" : 2,
					"patching_rect" : [ 45.0, 90.0, 42.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"id" : "obj-3",
					"outlettype" : [ "signal" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "mirror~",
					"numinlets" : 1,
					"patching_rect" : [ 45.0, 60.0, 49.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"id" : "obj-2",
					"outlettype" : [ "signal" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 474",
					"numinlets" : 2,
					"patching_rect" : [ 45.0, 30.0, 68.0, 20.0 ],
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"id" : "obj-1",
					"outlettype" : [ "signal" ],
					"fontname" : "Arial"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-3", 1 ],
					"hidden" : 0,
					"midpoints" : [ 129.5, 84.5, 77.5, 84.5 ]
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
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [ 24.5, 114.5, 54.5, 114.5 ]
				}

			}
 ]
	}

}
