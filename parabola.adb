with Ada.Text_IO;    --Input Output Standard Library
with Picasso;

procedure Picasso_Exec is
  use Ada.Text_IO;
  use Picasso;
  Canvas: Ada.Text_IO.File_type;

  begin
    NewCanvas("Canvas",Canvas, 50, 10*10);
    --Rectangle(Canvas,50,50, RED);

    for i in 0..500 loop
      Circle(Canvas,i/5, 10*10-(i*i)/250, 1, RED);
    end loop;
    --Circle(Canvas);
  --  Shape(Canvas, Rectangle_Shape
    --  , "x=" & '"' & "50" & '"' & " y=" & '"' & "20" & '"' & " width=" & '"' & "150" & '"' & " height=" & '"' & "150" & '"'
    --  , "fill:blue;stroke:pink;stroke-width:5;fill-opacity:0.1;stroke-opacity:0.9");

    CloseCanvas(Canvas);
    end Picasso_Exec;
