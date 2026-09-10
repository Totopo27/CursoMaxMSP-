{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 137.0, 57.0, 547.0, 393.0 ],
		"bglocked" : 0,
		"defrect" : [ 137.0, 57.0, 547.0, 393.0 ],
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
					"text" : "multy~ multiplies two signal inputs, and therefore should function identically to *~ when both of its inputs are signals. This patch compares the outputs of both externals.",
					"linecount" : 4,
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"id" : "obj-10",
					"fontname" : "Arial",
					"patching_rect" : [ 150.0, 255.0, 256.0, 62.0 ],
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "multy~",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"id" : "obj-9",
					"fontname" : "Arial",
					"patching_rect" : [ 255.0, 105.0, 46.0, 20.0 ],
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"id" : "obj-8",
					"fontname" : "Arial",
					"patching_rect" : [ 105.0, 105.0, 32.5, 20.0 ],
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 5",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"id" : "obj-7",
					"fontname" : "Arial",
					"patching_rect" : [ 180.0, 45.0, 55.0, 20.0 ],
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 374",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"id" : "obj-6",
					"fontname" : "Arial",
					"patching_rect" : [ 105.0, 45.0, 68.0, 20.0 ],
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"fontsize" : 12.0,
					"maximum" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "int", "bang" ],
					"id" : "obj-5",
					"fontname" : "Arial",
					"patching_rect" : [ 30.0, 45.0, 50.0, 20.0 ],
					"minimum" : 0,
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numoutlets" : 0,
					"id" : "obj-3",
					"patching_rect" : [ 90.0, 270.0, 45.0, 45.0 ],
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "gain~",
					"numoutlets" : 2,
					"outlettype" : [ "signal", "int" ],
					"id" : "obj-2",
					"patching_rect" : [ 90.0, 195.0, 26.0, 61.0 ],
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "selector~ 2",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"id" : "obj-1",
					"fontname" : "Arial",
					"patching_rect" : [ 90.0, 150.0, 70.0, 20.0 ],
					"numinlets" : 3
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
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-3", 1 ],
					"hidden" : 0,
					"midpoints" : [ 99.5, 262.5, 125.5, 262.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 129.5, 99.5, 129.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-8", 1 ],
					"hidden" : 0,
					"midpoints" : [ 189.5, 86.0, 128.0, 86.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-1", 1 ],
					"hidden" : 0,
					"midpoints" : [ 114.5, 137.0, 125.0, 137.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-9", 1 ],
					"hidden" : 0,
					"midpoints" : [ 189.5, 86.0, 291.5, 86.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 114.5, 97.0, 264.5, 97.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-1", 2 ],
					"hidden" : 0,
					"midpoints" : [ 264.5, 137.0, 150.5, 137.0 ]
				}

			}
 ]
	}

}
