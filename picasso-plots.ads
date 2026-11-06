package Picasso.Plots is
   --  A plot describes observations; it does not imply a continuous path.
   type Point is record
      X : Long_Float;
      Y : Long_Float;
   end record;

   type Point_Array is array (Positive range <>) of Point;

   --  Produce a standalone SVG, based on the existing Picasso canvas
   --  and circle/line primitives. Name is a stem; Picasso adds ".svg".
   procedure SVG_Samples
     (Name    : String;
      Data    : Point_Array;
      Title   : String;
      X_Label : String;
      Y_Label : String;
      Width   : Positive := 800;
      Height  : Positive := 440)
     with Pre => Data'Length > 0 and then Width >= 240 and then Height >= 180;

   --  Produce a Mermaid XY diagram from exactly the same observations.
   --  Mermaid joins samples with lines: this is a visual guide only.
   procedure Mermaid_Samples
     (File_Name : String;
      Data      : Point_Array;
      Title     : String;
      Y_Label   : String)
     with Pre => Data'Length > 0;
end Picasso.Plots;
