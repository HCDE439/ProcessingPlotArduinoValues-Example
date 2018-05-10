//// HCDE 439 Plotting valus received from the serial port
//// use with Arduino code _439_analog _serial


import processing.serial.*;

Serial myPort;  // The serial port
int xpos;     // we use this to plot the data trace line

void setup() {
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[7], 9600);
  size(400,255); // set the size of the window
  background (120); // set the background to medium gray
  textSize(40); // set the text to be large and readable
}

void draw() {
  char[] buffer = new char[0];
  
  if (myPort.available() > 0) { // make sure the serial port is available
    int value = myPort.read(); // read a character from the input buffer
    if (Character.isLetterOrDigit(value) || ' ' == (char)value) {
      buffer = (char[])append(buffer, (char)value);
    } else if (buffer.length > 0) {
      int inByte = Integer.parseInt(new String(buffer));
      fill(100);
      stroke(100);
      line (xpos, 0,xpos, inByte-2);
      line (xpos, inByte+2,xpos, height);
      noStroke();
      rect(20,20,80,32);
      fill(0,255,0);
      text(inByte,20,50);
      ellipse(xpos,inByte,2,2);
      xpos++;
      if (xpos>width){
        xpos=0;
        buffer = new char[0];
      }
    }
  }
}
