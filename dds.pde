import processing.opengl.*;

/*---->>>

 This program maps joystick values X and Y to a differential drive system where two motors are used to drive a robot.  
 There is also a vizualization of a robot and path according to the motors differential rotation.
 
 Author: Guilherme Martins 
 
 http://artica.cc
 
 Credits:
 
 The joystick program was based on a program entitled 'JoystickSimulation' by: Vince Thompson
 http://diyroboticslab.wordpress.com/2009/06/17/joystick-simulation-with-processing/
 
 The robot program was based on a program entitled 'Kephera Simulator' by Adam Matic of Croatia
 http://gritsgroup.org/robotsimulator.htm
 
<<<----*/

/**************
VARIABLES
**************/

int displayWidth = 1200;
int displayHeight = 850;

/**************
JOYSTICK
**************/

int joyOutputRange = 90;  //Maximum value for full horiz or vert position where centered is 0.
float curJoyDisplayWidth;
float curJoyDisplayHeight;
float maxJoyRange=200;     //Maximum joystick range
float curJoyAngle;     //Current joystick angle
float curJoyRange;     //Current joystick range
float joyDisplayCenterX;  //Joystick displayed Center X
float joyDisplayCenterY;  //Joystick displayed Center Y
float dx, dy;
float joyHorizontalText, joyVerticalText;

/**************
RECTS
**************/

boolean activeXLeft, activeYLeft, activeInterpLeft;
boolean activeXRight, activeYRight, activeInterpRight;

float gXLeft, gYLeft, gXRight, gYRight;

/**************
COLORS
**************/

color color1;
color color2;
color color3;
color colorActive;

/**************
CONDITION
**************/

String condition;
float oneValLeft, oneValRight;

/**************
BOOLEAN VARIABLES
**************/

boolean drawRectsActive = false;
boolean displayConditionsRectsActive = false;
boolean drawRobot = true;
boolean drawMotorsValues = true;

boolean drawHelpStuff = true;
boolean robotMove = true;
boolean joystickActive = true;
boolean cameraActive = true;
boolean drawCameraDebug = true;
boolean gridActive = true;

boolean addPath = true;
boolean drawPath = true;
boolean activePath = true;

boolean hidef = true;

/**************
BROWNIAN
**************/

int brownianCounter = 0;
float maxBrownianCounter = random(300)+100;

/**************
CAMERA VARS
**************/

float inc = 5.0;

float eyeX = 375;     //displayWidth/2.0;
float eyeY = 1200;    //displayHeight/2.0;
float eyeZ = 622;     //(displayHeight/2.0) / tan(PI*30.0 / 180.0);
float centerX = 405;  //displayWidth/2.0;
float centerY = 320;  //displayHeight/2.0;
float centerZ = 115;  //0.0;
float upX = 0;
float upY = 1;
float upZ = 0;

float xpos = -240;
float ypos = 295;
float zpos = 350;

float rX = -0.276;
float rY = 0.0;
float rZ = 62.87;

/**************
   DRAW ELEMENTS POSITIONS COORDS
**************/

int checkXpos = 25; 
int checkYpos = 450;
color checkColor = color(76, 152, 227);

/********************************************************

    SETUP

********************************************************/
void setup() 
{
  size(1200, 850, OPENGL);
  
  // JOYSTICK
  joyDisplayCenterX = 150;
  joyDisplayCenterY = 50 + maxJoyRange/2;
  curJoyDisplayWidth = maxJoyRange * .85;
  curJoyDisplayHeight = curJoyDisplayWidth;
  maxJoyRange = curJoyDisplayWidth / 2;
  
  // COLORS
  color1=color(0);  //Color = Black
  color2=color(150);  
  color3 = color(50, 200, 255);
  colorActive = color(255, 0, 0);
  
  smooth();
  
  RobotSetup();
  
}

/********************************************************

    DRAW

********************************************************/

void draw()
{
  background(0);
  
  joystickDraw();

  joystickDetectInteraction();
  
  robotDrawStage();
  
  mainConditions();
  
}

/********************************************************

    MAIN CONDITIONS

********************************************************/

void mainConditions()
{
  if (joystickActive)
  {
    joystickConditions3();
    joyStickDrawEllipse();
    robotUpdater();
  }
  
  if (drawMotorsValues)
    oneRect(oneValLeft, oneValRight);

  if (drawRectsActive)
  {
    drawRectLeft();
    drawRectRight();
  }

  if (drawCameraDebug)
    drawCameraData();
  
  if (keyPressed == true)
    getKey();

  if (drawHelpStuff)
  {
    drawHelpText();
    drawRobotStatus();
  }
}

