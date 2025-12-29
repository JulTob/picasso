With Ada.Directories;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
package body Picasso is


    procedure NewCanvas (
      Name : in String := "NewCanvas";
      Canvas : in out File_type;
      width : in Natural := 100;
      length : in Natural := 100)
      is
        use Ada.text_IO;   --Input Output Standard Library
        use Ada.Directories;
        begin
           if Exists( Name & ".svg" ) then
              Put_Line("File already exists");
              return;
              End if;
           Create( Canvas, OUT_file, Name & ".svg" );
           Put_line( Canvas,
                    "<svg  version=" & '"' & "1.1" & '"');
           Put_line( Canvas,
                    "    baseProfile=" & '"' & "full" & '"' );
           Put( Canvas,
                    "    width=" & '"' );
                    Put(Canvas, width, 0);
                    Put(Canvas, '"' );
           Put( Canvas,
                   "    length=" & '"' );
                   Put(Canvas, length, 0);
                   Put(Canvas, '"' );
           New_Line(Canvas);
           Put_line( Canvas,
                    "    xmlns=" & '"' & "http://www.w3.org/2000/svg"  & '"'
                  & ">");
          End NewCanvas;


    procedure CloseCanvas(
    Canvas : in out File_type
    ) is
    begin
      Put_Line(Canvas,"</svg>");
      Close(Canvas);
    end CloseCanvas;

    function style(
        style:    in String
        ) return String
      is
      begin -- RGB
        return
          " style=" & '"' & style & '"' ;
      end style;


    procedure Rectangle(
     Canvas : in out File_type;
     width  : in     Natural := 100;
     height : in     Natural := 100;
     color  : in     String := RED;
     x      : in     Natural := 0;
     y      : in     Natural := 0;
     style_String :  in  String  := "") is
     begin
       Put( Canvas,
                "<rect ");
       Put( Canvas,
            "    width=" & '"' ); --"  --this is only here for atom overenphasizyng brackets
             Put(Canvas, width, 0);
             Put(Canvas, '"' );  --"
       Put( Canvas,
            "    height=" & '"' );
            Put(Canvas, height, 0);
            Put(Canvas, '"' );
        Put( Canvas,
             "    x=" & '"' );
             Put(Canvas, x, 0);
             Put(Canvas, '"' );
       Put( Canvas,
            "    y=" & '"' );
            Put(Canvas, y, 0);
            Put(Canvas, '"' );
       Put( Canvas,
            "    fill=" & '"' & color & '"');
       if style_String'length>0 then
          Put(Canvas, style(style_String) );
          end if;
       Put( Canvas,
            " />");
       New_Line(Canvas);

      End Rectangle;


    procedure Circle(
      Canvas: in out File_type;
      coordenate_x :  in  Natural := 50;
      coordenate_y :  in  Natural := 50;
      radius :        in  Natural := 30;
      Color  :        in  String  := "yellow";
      Stroke_Color :  in  String  :=  "red";
      Stroke_Width :  in  Natural :=  0;
      style_String :  in  String  := "fill-opacity:0.5"
      ) is
      begin
        Put( Canvas, " <circle " );
        Put( Canvas,
             "    cx=" & '"' ); --"  --this is only here for atom overenphasizyng brackets
              Put(Canvas, coordenate_x, 0);
              Put(Canvas, '"' );  --"
        Put( Canvas,
             "    cy=" & '"' ); --"  --this is only here for atom overenphasizyng brackets
              Put(Canvas, coordenate_y, 0);
              Put(Canvas, '"' );  --"
        Put( Canvas,
             "    r=" & '"' ); --"  --this is only here for atom overenphasizyng brackets
              Put(Canvas, radius, 0);
              Put(Canvas, '"' );  --"
        Put( Canvas,
             "    fill=" & '"' & color & '"');
        Put( Canvas,
             "    stroke=" & '"' & Stroke_Color & '"');
        Put( Canvas,
             "    stroke-width=" & '"' ); --"  --this is only here for atom overenphasizyng brackets
              Put(Canvas, Stroke_Width, 0);
              Put(Canvas, '"' );  --"

        if style_String'length>0 then
          Put(Canvas, style(style_String) );
        end if;

        Put( Canvas,
             " />");
        New_Line(Canvas);
        end Circle;



    procedure Shape(
        Canvas: in out  File_type;
        Shape:  in      String  := Circle_Shape;
        Characteristics: in String := "";
        style_String:  in      String  := ""
        ) is
          begin
            Put(Canvas, "  <" & Shape & "  ");
              if Characteristics'length>0 then
                Put(Canvas,Characteristics );
              end if;
              if style_String'length>0 then
                Put(Canvas, style(style_String) );
              end if;
            Put(Canvas," />");
            New_Line(Canvas);
          end Shape;


    function RGB(
        Red:    in RGB_Dimension := 0;
        Green:  in RGB_Dimension := 0;
        Blue:   in RGB_Dimension := 0
      ) return String
      is
      begin -- RGB
        return
          "rgb(" &
          Integer'Image (Red) &
          "," &
          Integer'Image (Green) &
          "," &
          Integer'Image (Blue) &
          ") " ;

      end RGB;


end Picasso;
