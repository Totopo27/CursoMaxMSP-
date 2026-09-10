{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 614.0, 402.0, 640.0, 480.0 ],
		"bglocked" : 0,
		"defrect" : [ 614.0, 402.0, 640.0, 480.0 ],
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
					"text" : "click to send list to be reordered",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"id" : "obj-31",
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 15.0, 180.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "new order",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"id" : "obj-29",
					"fontname" : "Arial",
					"patching_rect" : [ 105.0, 225.0, 64.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "randomized list",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"id" : "obj-27",
					"fontname" : "Arial",
					"patching_rect" : [ 285.0, 255.0, 91.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "400. 500. 700. 800. 200. 100. 600. 300.",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"id" : "obj-25",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 285.0, 221.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"id" : "obj-23",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 255.0, 74.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thresh",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"id" : "obj-22",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 225.0, 44.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "coll",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 4,
					"id" : "obj-21",
					"outlettype" : [ "", "", "", "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 195.0, 59.5, 20.0 ],
					"saved_object_attributes" : 					{
						"embed" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pack i f",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"id" : "obj-20",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 165.0, 49.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "counter 0 7",
					"fontsize" : 12.0,
					"numinlets" : 5,
					"numoutlets" : 4,
					"id" : "obj-19",
					"outlettype" : [ "int", "", "", "int" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 135.0, 73.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"id" : "obj-18",
					"outlettype" : [ "bang", "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 105.0, 32.5, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "iter",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"id" : "obj-17",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 75.0, 27.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "100 200 300 400 500 600 700 800",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"id" : "obj-16",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 195.0, 45.0, 194.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "iter",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"id" : "obj-14",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 285.0, 27.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "3 4 6 7 1 0 5 2",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"id" : "obj-13",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 255.0, 87.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"id" : "obj-11",
					"outlettype" : [ "bang", "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 225.0, 32.5, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"id" : "obj-10",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 195.0, 74.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "thresh",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"id" : "obj-9",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 165.0, 44.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "urn 8",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 2,
					"id" : "obj-8",
					"outlettype" : [ "int", "bang" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 135.0, 38.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "clear",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"id" : "obj-7",
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 120.0, 105.0, 37.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "uzi 8",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 3,
					"id" : "obj-5",
					"outlettype" : [ "bang", "bang", "int" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 105.0, 46.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b b",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"id" : "obj-4",
					"outlettype" : [ "bang", "bang" ],
					"fontname" : "Arial",
					"patching_rect" : [ 60.0, 75.0, 34.0, 20.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [ 69.5, 315.0, 169.0, 315.0, 169.0, 190.0, 204.5, 190.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-23", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-23", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 1 ],
					"destination" : [ "obj-20", 1 ],
					"hidden" : 0,
					"midpoints" : [ 218.0, 128.0, 274.0, 128.0, 274.0, 160.0, 234.5, 160.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [ 204.5, 68.5, 69.5, 68.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 1 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [ 83.0, 249.5, 69.5, 249.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [ 129.5, 128.5, 69.5, 128.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 1 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [ 84.5, 99.5, 129.5, 99.5 ]
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
 ]
	}

}
