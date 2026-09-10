{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 133.0, 271.0, 609.0, 528.0 ],
		"bglocked" : 0,
		"defrect" : [ 133.0, 271.0, 609.0, 528.0 ],
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
					"text" : "scrubber~",
					"numinlets" : 1,
					"frgb" : [ 0.317647, 0.043137, 0.223529, 1.0 ],
					"fontname" : "Cambria",
					"numoutlets" : 0,
					"patching_rect" : [ 330.0, 375.0, 120.0, 35.0 ],
					"fontsize" : 24.0,
					"id" : "obj-2",
					"textcolor" : [ 0.317647, 0.043137, 0.223529, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "published by A-R Editions, Inc.\nhttp://www.areditions.com/",
					"linecount" : 2,
					"numinlets" : 1,
					"frgb" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"fontname" : "Cambria",
					"numoutlets" : 0,
					"patching_rect" : [ 330.0, 450.0, 196.0, 39.0 ],
					"fontsize" : 14.0,
					"id" : "obj-9",
					"textcolor" : [ 0.082353, 0.25098, 0.431373, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "from Designing Audio Objects\nby Eric Lyon",
					"linecount" : 2,
					"numinlets" : 1,
					"frgb" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"fontname" : "Cambria",
					"numoutlets" : 0,
					"patching_rect" : [ 330.0, 405.0, 241.0, 49.0 ],
					"fontsize" : 18.0,
					"id" : "obj-30",
					"textcolor" : [ 0.082353, 0.25098, 0.431373, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "panel",
					"numinlets" : 1,
					"numoutlets" : 0,
					"border" : 3,
					"patching_rect" : [ 315.0, 375.0, 273.0, 118.0 ],
					"rounded" : 1,
					"id" : "obj-32",
					"bgcolor" : [ 1.0, 0.905882, 0.733333, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "scrubber~ scrubs at arbitrary speed through the a sound stored as a series of spectral frames",
					"linecount" : 2,
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 465.0, 278.0, 34.0 ],
					"fontsize" : 12.0,
					"id" : "obj-11"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Master gain",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 210.0, 315.0, 73.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-3"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "auto-resize",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 285.0, 150.0, 70.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-39"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Play soundfile and sample it",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 75.0, 15.0, 160.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-37"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "phase",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 360.0, 315.0, 43.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-27"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 150.0, 315.0, 50.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-31"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sel 1",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 30.0, 120.0, 36.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-29"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "resize $1",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 360.0, 165.0, 59.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-28"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 360.0, 135.0, 98.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-24"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b l",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 315.0, 75.0, 32.5, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-22"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sfinfo~",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 6,
					"outlettype" : [ "int", "int", "float", "float", "", "" ],
					"patching_rect" : [ 315.0, 105.0, 86.5, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-21"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 270.0, 195.0, 20.0, 20.0 ],
					"id" : "obj-14"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "dropfile",
					"numinlets" : 1,
					"numoutlets" : 2,
					"types" : [  ],
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 255.0, 15.0, 132.0, 52.0 ],
					"id" : "obj-26"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 300.0, 315.0, 50.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-25"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.5",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 114.0, 358.0, 42.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-10"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "meter~",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 180.0, 405.0, 80.0, 13.0 ],
					"id" : "obj-1"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "sample",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 60.0, 195.0, 49.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-8"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "drag soundfile here",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 270.0, 30.0, 113.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-7"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 75.0, 45.0, 20.0, 20.0 ],
					"id" : "obj-18"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sfplay~ 1",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 165.0, 150.0, 59.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-19",
					"save" : [ "#N", "sfplay~", "", 1, 120960, 0, "", ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "open $1",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 165.0, 105.0, 54.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-20"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 114.0, 403.0, 50.0, 50.0 ],
					"id" : "obj-4"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"fontname" : "Arial",
					"triscale" : 0.9,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 270.0, 255.0, 63.0, 20.0 ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"fontsize" : 12.0,
					"minimum" : 0.0,
					"id" : "obj-5",
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"maximum" : 1.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"fontname" : "Arial",
					"triscale" : 0.9,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 270.0, 225.0, 63.0, 20.0 ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-6",
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pfft~ pfft.scrubber 2048 8",
					"numinlets" : 3,
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"patching_rect" : [ 114.0, 283.0, 144.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-13"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "speed",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 330.0, 225.0, 43.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-15"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "position",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 330.0, 255.0, 52.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-16"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 123.5, 384.0, 189.5, 384.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-4", 1 ],
					"hidden" : 0,
					"midpoints" : [ 123.5, 390.0, 154.5, 390.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 1 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 0,
					"midpoints" : [ 248.5, 308.0, 309.5, 308.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [ 84.5, 142.0, 174.5, 142.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-29", 0 ],
					"hidden" : 0,
					"midpoints" : [ 84.5, 99.5, 39.5, 99.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [ 174.5, 192.0, 123.5, 192.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 174.5, 134.0, 301.5, 134.0, 301.5, 69.0, 324.5, 69.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 3 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [ 365.0, 129.5, 369.5, 129.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 1 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [ 338.0, 99.5, 324.5, 99.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-26", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [ 264.5, 91.5, 174.5, 91.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [ 369.5, 187.0, 257.0, 187.0, 257.0, 219.0, 123.5, 219.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-29", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 184.0, 69.5, 184.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-31", 0 ],
					"destination" : [ "obj-10", 1 ],
					"hidden" : 0,
					"midpoints" : [ 159.5, 346.0, 146.5, 346.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-13", 2 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 280.0, 248.5, 280.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-13", 1 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 250.0, 186.0, 250.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [ 69.5, 226.0, 123.5, 226.0 ]
				}

			}
 ]
	}

}
