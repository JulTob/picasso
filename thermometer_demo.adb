with Picasso.Plots;

procedure Thermometer_Demo is
   --  Three invented readings from the Data Wiki teaching example.
   --  No values between the samples have been measured.
   use Picasso.Plots;

   Readings : constant Point_Array :=
     (1 => (X => 0.0, Y => 20.0),
      2 => (X => 1.0, Y => 20.3),
      3 => (X => 2.0, Y => 20.6));
begin
   SVG_Samples
     (Name    => "thermometer_samples",
      Data    => Readings,
      Title   => "Measured room temperature (illustrative)",
      X_Label => "Time (min)",
      Y_Label => "Temperature (C)");

   Mermaid_Samples
     (File_Name => "thermometer_samples.mmd",
      Data      => Readings,
      Title     => "Measured room temperature (illustrative)",
      Y_Label   => "Temperature (C)");
end Thermometer_Demo;
