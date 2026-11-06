with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Ada.Long_Float_Text_IO;
with Ada.Directories;
with Ada.IO_Exceptions;

package body Picasso.Plots is

   function Text (Value : Long_Float) return String is
      Buffer : String (1 .. 80);
   begin
      Ada.Long_Float_Text_IO.Put
        (To => Buffer, Item => Value, Aft => 3, Exp => 0);
      return Ada.Strings.Fixed.Trim (Buffer, Ada.Strings.Both);
   end Text;

   function Text (Value : Natural) return String is
   begin
      return Ada.Strings.Fixed.Trim
        (Natural'Image (Value), Ada.Strings.Both);
   end Text;

   function Escape_XML (Source : String) return String is
      use Ada.Strings.Unbounded;
      Escaped : Unbounded_String;
   begin
      for Symbol of Source loop
         case Symbol is
            when '&'  => Append (Escaped, "&amp;");
            when '<'  => Append (Escaped, "&lt;");
            when '>'  => Append (Escaped, "&gt;");
            when '"'  => Append (Escaped, "&quot;");
            when others => Append (Escaped, Symbol);
         end case;
      end loop;
      return To_String (Escaped);
   end Escape_XML;

   function Attr (Name, Value : String) return String is
   begin
      return Name & "=" & '"' & Escape_XML (Value) & '"' & " ";
   end Attr;

   procedure Validate (Data : Point_Array) is
   begin
      if Data'Length = 0 then
         raise Constraint_Error with "At least one observation is required";
      end if;
      for Index in Data'Range loop
         if Data (Index).X /= Data (Index).X
           or else Data (Index).Y /= Data (Index).Y
         then
            raise Constraint_Error with "NaN is not a valid observation";
         end if;
         if Index > Data'First
           and then Data (Index).X <= Data (Index - 1).X
         then
            raise Constraint_Error with
              "Sample coordinates must be strictly increasing";
         end if;
      end loop;
   end Validate;

   procedure SVG_Samples
     (Name    : String;
      Data    : Point_Array;
      Title   : String;
      X_Label : String;
      Y_Label : String;
      Width   : Positive := 800;
      Height  : Positive := 440)
   is
      use Ada.Text_IO;
      Canvas : File_Type;
      Left   : constant Natural := 72;
      Right  : constant Natural := Width - 32;
      Top    : constant Natural := 45;
      Bottom : constant Natural := Height - 68;
      Min_X  : Long_Float := Data (Data'First).X;
      Max_X  : Long_Float := Data (Data'Last).X;
      Min_Y  : Long_Float := Data (Data'First).Y;
      Max_Y  : Long_Float := Min_Y;

      function Pixel_X (Value : Long_Float) return Natural is
      begin
         return Left + Natural
           ((Value - Min_X) / (Max_X - Min_X) *
            Long_Float (Right - Left));
      end Pixel_X;

      function Pixel_Y (Value : Long_Float) return Natural is
      begin
         return Bottom - Natural
           ((Value - Min_Y) / (Max_Y - Min_Y) *
            Long_Float (Bottom - Top));
      end Pixel_Y;

      procedure Label
        (X, Y : Natural; Content : String; Anchor : String := "start")
      is
      begin
         Put_Line (Canvas,
           "<text " & Attr ("x", Text (X)) & Attr ("y", Text (Y)) &
           Attr ("text-anchor", Anchor) &
           Attr ("font-family", "sans-serif") &
           Attr ("font-size", "14") &
           Attr ("fill", "#303030") & ">" &
           Escape_XML (Content) & "</text>");
      end Label;

      procedure Segment
        (X1, Y1, X2, Y2 : Natural; Colour : String := "#505050")
      is
      begin
         Picasso.Shape
           (Canvas, Picasso.Line_Shape,
            Attr ("x1", Text (X1)) & Attr ("y1", Text (Y1)) &
            Attr ("x2", Text (X2)) & Attr ("y2", Text (Y2)) &
            Attr ("stroke", Colour) & Attr ("stroke-width", "1"));
      end Segment;

   begin
      Validate (Data);
      if Width < 240 or else Height < 180 then
         raise Constraint_Error with "SVG size is too small";
      end if;

      for Observation of Data loop
         Min_Y := Long_Float'Min (Min_Y, Observation.Y);
         Max_Y := Long_Float'Max (Max_Y, Observation.Y);
      end loop;
      if Max_X = Min_X then
         Max_X := Max_X + 0.5;
         Min_X := Min_X - 0.5;
      end if;
      if Max_Y = Min_Y then
         Max_Y := Max_Y + 0.5;
         Min_Y := Min_Y - 0.5;
      else
         declare
            Padding : constant Long_Float := (Max_Y - Min_Y) * 0.15;
         begin
            Max_Y := Max_Y + Padding;
            Min_Y := Min_Y - Padding;
         end;
      end if;

      --  Picasso's existing canvas handles SVG opening/closing.
      if Ada.Directories.Exists (Name & ".svg") then
         raise Ada.IO_Exceptions.Use_Error with "Output SVG already exists";
      end if;
      Picasso.NewCanvas (Name, Canvas, Width, Height);
      Label (Width / 2, 23, Title, "middle");
      Segment (Left, Top, Left, Bottom);
      Segment (Left, Bottom, Right, Bottom);
      Label (Left, Top - 8, Text (Max_Y), "middle");
      Label (Left, Bottom + 16, Text (Min_Y), "middle");
      Label (Width / 2, Height - 12, X_Label, "middle");
      Label (Left + 4, 37, Y_Label);

      for Observation of Data loop
         Picasso.Circle
           (Canvas, Pixel_X (Observation.X), Pixel_Y (Observation.Y),
            5, "tomato", "#303030", 1, "");
         if Data'Length <= 12 then
            Label
              (Pixel_X (Observation.X), Bottom + 20,
               Text (Observation.X), "middle");
         end if;
      end loop;
      Picasso.CloseCanvas (Canvas);
   end SVG_Samples;

   procedure Mermaid_Samples
     (File_Name : String;
      Data      : Point_Array;
      Title     : String;
      Y_Label   : String)
   is
      use Ada.Text_IO;
      Output : File_Type;

      procedure Check_Title (Value : String) is
      begin
         for Symbol of Value loop
            if Symbol = '"'
              or else Symbol = ASCII.LF
              or else Symbol = ASCII.CR
            then
               raise Constraint_Error with "Mermaid label contains a quote or newline";
            end if;
         end loop;
      end Check_Title;
   begin
      Validate (Data);
      Check_Title (Title);
      Check_Title (Y_Label);
      Create (Output, Out_File, File_Name);
      Put_Line (Output, "xychart-beta");
      Put_Line (Output, "    title " & '"' & Title & '"');
      Put (Output, "    x-axis [");
      for Index in Data'Range loop
         if Index /= Data'First then
            Put (Output, ", ");
         end if;
         Put (Output, '"' & Text (Data (Index).X) & '"');
      end loop;
      Put_Line (Output, "]");
      Put_Line (Output, "    y-axis " & '"' & Y_Label & '"');
      Put (Output, "    line [");
      for Index in Data'Range loop
         if Index /= Data'First then
            Put (Output, ", ");
         end if;
         Put (Output, Text (Data (Index).Y));
      end loop;
      Put_Line (Output, "]");
      Close (Output);
   end Mermaid_Samples;
end Picasso.Plots;
