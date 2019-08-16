import processing.serial.*;
Serial myPort; // Create object from Serial class
Table dataTable; // Table to store and read values
String stringVal;
int numReadings = 10; // Number of Readings before writing the file
int readingCounter = 0; // Counts each reading to compare to numReadings
String fileName;
String serialPortName = "COM4"; // Change this according to the correct COM!

void setup()
{
  size(700, 300);
  myPort = new Serial(this, serialPortName, 9600);
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
  // Read the values from the Arduino Serial monitor and store them
  stringVal = myPort.readString();
  print(stringVal);
  
  TableRow newRow = dataTable.addRow(); // Add a row for the new reading
  newRow.setInt("ID", dataTable.lastRowIndex()); // Record a unique identifier (the row's index)
  
  // Record time stamp
  newRow.setInt("year", year());
  newRow.setInt("month", month());
  newRow.setInt("day", day());
  
  // Record the values
  newRow.setString("Value", stringVal);
  
  // Save the table as a .csv file 
  if (readingCounter % numReadings == 0) // Check if readCounter is a multiple of numReadings
  {
    fileName = str(year()) + "-" + str(month()) + "-" + str(day()) + ".csv";
    saveTable(dataTable, fileName, "csv"); // Save as a .csv file
  }
}
