import processing.serial.*;
Serial myPort; // Create object from Serial class
Table dataTable; // Table to store and read values
String stringVal = null;
int newLine = 10; // new line character in ASCII
String fileName;
String serialPortName = "COM4"; // Change this according to the correct COM!
float num; // variable for storing values read from serial monitor

void setup()
{
  size(700, 300);
  myPort = new Serial(this, serialPortName, 9600);
  dataTable = new Table(); 
  
  dataTable.addColumn("ID");
  dataTable.addColumn("hour");
  dataTable.addColumn("minute");
  dataTable.addColumn("seconds");
  dataTable.addColumn("Value");
  myPort.bufferUntil(newLine);
}

void serialEvent(Serial myPort)
{ 
  // Read data from Arduino serial monitor and store them
  while (myPort.available() > 0) {
    stringVal = myPort.readStringUntil(newLine);
    if (stringVal != null) {
      stringVal = trim(stringVal); // Get rid of any whitespace or Unicode nonbreakable spaces
      num = float(stringVal); // Convert to float
      println(num);
    }
  }
  
  TableRow newRow = dataTable.addRow(); // Add a row for the new reading
  
  newRow.setInt("ID", dataTable.lastRowIndex()); // Record a unique identifier (the row's index)
  
  // Record time stamp
  newRow.setInt("hour", hour());
  newRow.setInt("minute", minute());
  newRow.setInt("seconds", second());
  
  // Record the value read from serial monitor
  newRow.setFloat("Value", num);
  
  fileName = str(year()) + "-" + str(month()) + "-" + str(day()) + ".csv"; // File name in the format year-month-day
  saveTable(dataTable, fileName, "csv"); // Save as a .csv file
}

void draw()
{
  // Use serialEvent() instead of draw()
}
