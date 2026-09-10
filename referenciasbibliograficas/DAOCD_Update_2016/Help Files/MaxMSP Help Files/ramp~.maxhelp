{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 572.0, 337.0, 571.0, 375.0 ],
		"bglocked" : 0,
		"defrect" : [ 572.0, 337.0, 571.0, 375.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 14.0,
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
					"text" : "click trigger",
					"patching_rect" : [ 90.0, 105.0, 71.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-28",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "set the ramp duration \nto 1 second worth of samples",
					"linecount" : 2,
					"patching_rect" : [ 285.0, 105.0, 169.0, 34.0 ],
					"fontname" : "Arial",
					"id" : "obj-26",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "ramp~",
					"frgb" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"patching_rect" : [ 315.0, 240.0, 82.0, 35.0 ],
					"fontname" : "Cambria",
					"textcolor" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"id" : "obj-24",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 24.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "published by A-R Editions, Inc.\nhttp://www.areditions.com/",
					"linecount" : 2,
					"frgb" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"patching_rect" : [ 315.0, 315.0, 196.0, 39.0 ],
					"fontname" : "Cambria",
					"textcolor" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"id" : "obj-20",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 14.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "from Designing Audio Objects\nby Eric Lyon",
					"linecount" : 2,
					"frgb" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"patching_rect" : [ 315.0, 270.0, 241.0, 49.0 ],
					"fontname" : "Cambria",
					"textcolor" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"id" : "obj-7",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 18.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "ramp~ generates a click-triggered ramp",
					"patching_rect" : [ 45.0, 330.0, 258.0, 23.0 ],
					"fontname" : "Arial",
					"id" : "obj-21",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 14.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "play and record a ramp",
					"patching_rect" : [ 60.0, 15.0, 134.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-19",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"patching_rect" : [ 30.0, 15.0, 20.0, 20.0 ],
					"id" : "obj-17",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t 1 b",
					"patching_rect" : [ 30.0, 75.0, 34.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-15",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "int", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "record~ show_ramp",
					"patching_rect" : [ 105.0, 210.0, 117.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-14",
					"numinlets" : 3,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"buffername" : "show_ramp",
					"patching_rect" : [ 45.0, 240.0, 259.0, 76.0 ],
					"textcolor" : [  ],
					"id" : "obj-13",
					"numinlets" : 5,
					"numoutlets" : 6,
					"outlettype" : [ "float", "float", "float", "float", "list", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ show_ramp 1000",
					"patching_rect" : [ 345.0, 150.0, 143.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-12",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "click~",
					"patching_rect" : [ 60.0, 135.0, 41.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-11",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"patching_rect" : [ 60.0, 105.0, 20.0, 20.0 ],
					"id" : "obj-10",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"patching_rect" : [ 345.0, 180.0, 45.0, 45.0 ],
					"id" : "obj-8",
					"numinlets" : 2,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 210.0, 105.0, 67.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-5",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "adstatus sr",
					"patching_rect" : [ 210.0, 60.0, 69.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-3",
					"numinlets" : 2,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sig~ 44100",
					"patching_rect" : [ 210.0, 135.0, 70.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-2",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "ramp~",
					"patching_rect" : [ 105.0, 165.0, 45.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-1",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 201.0, 114.5, 201.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 1 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [ 54.5, 99.5, 69.5, 99.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 69.5, 159.5, 114.5, 159.5 ]
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
					"source" : [ "obj-3", 1 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [ 269.5, 92.0, 219.5, 92.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-1", 1 ],
					"hidden" : 0,
					"midpoints" : [ 219.5, 159.5, 140.5, 159.5 ]
				}

			}
 ]
	}

}
