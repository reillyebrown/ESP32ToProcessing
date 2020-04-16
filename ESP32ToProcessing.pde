
    //Will change the background to red when the button gets pressed
    //Will change speed of ball based on the potentiometer
    
 
//*****************************************sound file
import processing.sound.*;
SoundFile sound;

// Importing the serial library to communicate with the Arduino 
import processing.serial.*;    

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;      

// Data coming in from the data fields
String [] data;
int switchValue = 0;    // index from data fields
int potValue = 1;

//data[0] = "1" or "0"
//data[1] =

// Change to appropriate index in the serial list — YOURS MIGHT BE DIFFERENT
int serialIndex = 2;

// animated ball
int minPotValue = 0;
int maxPotValue = 4095;    // will be 1023 on other systems
int volumeMax = 1;
int volumeMin = 0;


String[] words = {"Strawberry Fields" , "Forever"};


void setup ( ) {
  size (800,  600);
  
 // Load a soundfile from the /data folder of the sketch and play it back
  sound = new SoundFile(this, "strawberryfieldsforever.mp3");
  //sound.amp(1);
  // s = new Sound(this);
  sound.play();
 //sound.amp(amp);  
   
   
  // List all the available serial ports
  printArray(Serial.list());
  
  // Set the com port and the baud rate according to the Arduino IDE
  myPort  =  new Serial (this, "/dev/tty.SLAB_USBtoUART",  115200); 
  
  
  // settings for drawing the ball

  
} 


// We call this to get the data 
void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    print(inBuffer);
    
    // This removes the end-of-line from the string AND casts it to an integer
    inBuffer = (trim(inBuffer));
    
    //build in data parsing element 
    data = split(inBuffer, ',');
 
    // do an error check here?
    switchValue = int(data[0]); //first index = switch value
    potValue = int(data[1]); //second index = pot value
  }
} 

//-- change background to red if we have a button
void draw ( ) {  
 
  // every loop, look for serial information
  checkSerial();
  
  drawBackground();
  drawSong();

} 

// if input value is 1 (from ESP32, indicating a button has been pressed), change the background
void drawBackground() {
  textSize(80);
  textAlign(CENTER);
  if( switchValue == 1 )
   
    
    text(words[1], width/2, height/2+60);
    
  else
  noStroke();
   textSize(40);
  textAlign(CENTER);
  text(words[0], width/2, height/2);
 float X = random(0, width);
  float Y = random(0, height);
  float sizeX = random (0, 200);
  float sizeY = random (0, 200);
  float colR = random(0, 255);
  float colG = random(0, 255);
  float colB = random(0, 255);
  float colO = random(0, 255);

  fill(colR, colG, colB, colO);
  ellipse(X, Y, sizeX, sizeY);


}


void drawSong() {

 float amp  = map(potValue, minPotValue, maxPotValue, volumeMin, volumeMax);
 sound.amp(amp);
 
  
}
