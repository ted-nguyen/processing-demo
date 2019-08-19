  /*************************************
 * For Arduino UNO OLED Displays: SDA -> A5, SCL -> A4
 */
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <DS3231.h>

// Init the DS3231 using the hardware interface
DS3231  rtc(SDA, SCL);

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 32 // OLED display height, in pixels

// Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
#define OLED_RESET     4 // Reset pin # (or -1 if sharing Arduino reset pin)
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

void setup() {
  // Set Up Serial Communication
  Serial.begin(9600);

  // Initialize the rtc object
  rtc.begin();
  
  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) { // Address 0x3D for 128x64
    Serial.println(F("SSD1306 allocation failed"));
    for(;;); // Don't proceed, loop forever
  }

  // Show the display
  display.display();
  delay(2000); // Wait 2 seconds
  
  // Clear the display
  display.clearDisplay();

  display.setTextSize(1);
  display.setTextColor(WHITE);
}

void loop() {
  float x = 0.0;

  // Clear the display and reset the cursor
  display.clearDisplay();
  display.setCursor(0, 0);
  
  // Prints the numbers 0 through 10
  while(x <= 9.0) {
    Serial.println(x*0.2);
    
    display.print(x);
    display.print(", ");
    display.display(); // update display
    
    delay(1000);
    x++; 
  }

  Serial.println(x);
  
  display.print(x);
  display.display();
  
  delay(2000); // Wait 2 seconds
  // Wait indefintely
  while(1);
}
