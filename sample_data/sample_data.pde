import processing.serial.*;
Serial myPort; // Create object from Serial class
Table dataTable; // Table to store and read values
String val; // String variable to store each data value
int numReadings = 10; // Number of Readings before writing the file
int readingCounter = 0; // Counts each reading to compare to numReadings
String fileName;

void setup()
{
  size(700, 300);
  myPort = new Serial(this, "COM5", 9600);
  dataTable = new Table();
  background(#081640);
  
  
  dataTable.addColumn("ID");

  dataTable.addColumn("year");
  dataTable.addColumn("month");
  dataTable.addColumn("day");

  dataTable.addColumn("Value");
}

void draw()
{
  // empty
}

void serialEvent(Serial myPort)
{
  // Read the values from the Arduino Serial monitor and store them in the string val
  val = myPort.readString();
  print(val);
  
  TableRow newRow = dataTable.addRow(); // Add a row for the new reading
  newRow.setInt("ID", dataTable.lastRowIndex()); // Record a unique identifier (the row's index)
  
  // Record time stamp
  newRow.setInt("year", year());
  newRow.setInt("month", month());
  newRow.setInt("day", day());
  
  // Record the values
  //newRow.setFloat("Value", val);
  
  // Save the table as a .csv file 
  if (reading
}
