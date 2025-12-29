with Ada.Text_IO;    --Input Output Standard Library
with Picasso;

procedure Picasso_Exec is
  use Ada.Text_IO;
  use Picasso;
  Canvas: Ada.Text_IO.File_type;

  begin
    NewCanvas("Canvas",Canvas, 500, 500);
    --Rectangle(Canvas,50,50, RED);

    for i in 0..50 loop
      for j in 0..50 loop
        if i*i + j*j < 2500-5 then
          Circle(Canvas,i*10, 500-j*10, 5, RED);
        else
          if i*i + j*j < 2500 + 50 then
              Circle(Canvas,i*10, 500-j*10, 3, GREEN);
          else
              Circle(Canvas,i*10, 500-j*10, 2, BLUE);
          end if;
        end if;
      end loop;
    end loop;
    --Circle(Canvas);
  --  Shape(Canvas, Rectangle_Shape
    --  , "x=" & '"' & "50" & '"' & " y=" & '"' & "20" & '"' & " width=" & '"' & "150" & '"' & " height=" & '"' & "150" & '"'
    --  , "fill:blue;stroke:pink;stroke-width:5;fill-opacity:0.1;stroke-opacity:0.9");

    CloseCanvas(  Canvas);
    end Picasso_Exec;
