with Ada.Text_IO; use Ada.Text_IO;

package Picasso is

  --type CanvasType is new Ada.Text_IO.File_type;

  subtype RGB_Dimension is Natural range 0 .. 255;


  -- Constants:
  ---- Colors
  RED   : constant string := "red";
  GREEN : constant string := "green";
  YELLOW: constant string := "yellow";
  BLUE  : constant string := "blue";
  PINK  : constant string := "pink";
  BLACK : constant string := "black";
  GOLD  : constant string := "gold";
  LIME  : constant string := "lime";
  NAVY  : constant string := "navy";
  aliceblue  : constant string := "aliceblue";
  antiquewhite  : constant string := "antiquewhite";
  aqua  : constant string := "aqua";
  aquamarine  : constant string := "aquamarine";
  azure  : constant string := "azure";
  beige  : constant string := "beige";



  ---- Shapes
  Circle_Shape:     constant string :=  "circle";
  Rectangle_Shape:  constant string :=  "rect";
  Ellipse_Shape:    constant String :=  "ellipse";
  Line_Shape:       constant String :=  "line";
  Polyline_Shape:    constant String :=  "polyline";
  Polygon_Shape:     constant String :=  "polygon";
  Path_Shape:        constant String :=  "path";

  procedure NewCanvas(
    Name   : in     String := "NewCanvas";
    Canvas : in out File_type;
    width  : in     Natural := 100;
    length : in     Natural := 100);

  procedure CloseCanvas(
    Canvas : in out File_type
    );


  procedure Rectangle(
    Canvas : in out File_type;
    width  : in     Natural := 100;
    height : in     Natural := 100;
    color  : in     String  := RED;
    x      : in     Natural := 0;
    y      : in     Natural := 0;
    style_String :  in  String  := ""
    -- rounded corners rx="20" ry="20"
    );

  procedure Circle(
    Canvas: in out File_type;
    coordenate_x :  in  Natural := 50;
    coordenate_y :  in  Natural := 50;
    radius :        in  Natural := 30;
    Color  :        in  String  := "yellow";
    Stroke_Color :  in  String  :=  "red";
    Stroke_Width :  in  Natural :=  0;
    style_String :  in  String  := "fill-opacity:0.5"

    );

  procedure Shape(
    Canvas: in out  File_type;
    Shape:  in      String  := Circle_Shape;
    Characteristics: in String := "";
    style_String:  in      String  := ""
    );

  function RGB(
      Red:    in RGB_Dimension := 0;
      Green:  in RGB_Dimension := 0;
      Blue:   in RGB_Dimension := 0
    ) return String;


private

end Picasso;
