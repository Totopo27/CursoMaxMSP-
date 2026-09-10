{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 605.0, 246.0, 548.0, 418.0 ],
		"bglocked" : 0,
		"defrect" : [ 605.0, 246.0, 548.0, 418.0 ],
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
					"maxclass" : "comment",
					"text" : "input",
					"patching_rect" : [ 90.0, 75.0, 37.0, 20.0 ],
					"id" : "obj-21",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "speed",
					"patching_rect" : [ 195.0, 105.0, 43.0, 20.0 ],
					"id" : "obj-19",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "+~ 1.",
					"patching_rect" : [ 150.0, 240.0, 38.0, 20.0 ],
					"id" : "obj-11",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "* 2.",
					"patching_rect" : [ 270.0, 45.0, 32.5, 20.0 ],
					"id" : "obj-1",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "feedback",
					"patching_rect" : [ 405.0, 60.0, 59.0, 20.0 ],
					"id" : "obj-24",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 300.0, 180.0, 50.0, 20.0 ],
					"id" : "obj-22",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"patching_rect" : [ 375.0, 60.0, 25.0, 25.0 ],
					"id" : "obj-20",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "depth",
					"patching_rect" : [ 300.0, 15.0, 41.0, 20.0 ],
					"id" : "obj-18",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"patching_rect" : [ 270.0, 15.0, 25.0, 25.0 ],
					"id" : "obj-13",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 270.0, 75.0, 50.0, 20.0 ],
					"id" : "obj-12",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "line~",
					"patching_rect" : [ 270.0, 135.0, 36.0, 20.0 ],
					"id" : "obj-9",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "$1 50",
					"patching_rect" : [ 270.0, 105.0, 41.0, 18.0 ],
					"id" : "obj-10",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "line~",
					"patching_rect" : [ 300.0, 240.0, 36.0, 20.0 ],
					"id" : "obj-8",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "$1 50",
					"patching_rect" : [ 300.0, 210.0, 41.0, 18.0 ],
					"id" : "obj-7",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "* 0.001",
					"patching_rect" : [ 135.0, 75.0, 49.0, 20.0 ],
					"id" : "obj-6",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "random 2000",
					"patching_rect" : [ 135.0, 45.0, 81.0, 20.0 ],
					"id" : "obj-5",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"patching_rect" : [ 135.0, 15.0, 60.0, 20.0 ],
					"id" : "obj-4",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 135.0, 105.0, 50.0, 20.0 ],
					"id" : "obj-2",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "+~ 1",
					"patching_rect" : [ 135.0, 195.0, 35.0, 20.0 ],
					"id" : "obj-16",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 1",
					"patching_rect" : [ 135.0, 165.0, 33.0, 20.0 ],
					"id" : "obj-15",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "rand~ 0.73",
					"patching_rect" : [ 135.0, 135.0, 69.0, 20.0 ],
					"id" : "obj-14",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "vdelay~ 5 5 0.7",
					"patching_rect" : [ 135.0, 285.0, 92.0, 20.0 ],
					"id" : "obj-3",
					"numinlets" : 3,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"patching_rect" : [ 60.0, 75.0, 25.0, 25.0 ],
					"id" : "obj-30",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"patching_rect" : [ 150.0, 345.0, 25.0, 25.0 ],
					"id" : "obj-31",
					"numinlets" : 1,
					"numoutlets" : 0,
					"comment" : ""
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-16", 1 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 188.0, 160.5, 188.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-15", 1 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 160.0, 158.5, 160.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-3", 2 ],
					"hidden" : 0,
					"midpoints" : [ 309.5, 272.0, 217.5, 272.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [ 69.5, 227.5, 144.5, 227.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 0,
					"midpoints" : [ 144.5, 330.0, 159.5, 330.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 384.5, 171.0, 309.5, 171.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 144.5, 221.0, 159.5, 221.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-3", 1 ],
					"hidden" : 0,
					"midpoints" : [ 159.5, 272.0, 181.0, 272.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
