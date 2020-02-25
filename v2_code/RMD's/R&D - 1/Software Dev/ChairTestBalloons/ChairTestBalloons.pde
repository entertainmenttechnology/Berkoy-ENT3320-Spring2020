/*
  Center of Mass
  "Making Things See", page 260
  
  ==============================
  
  Author: Greg Borenstein
*/

//Import the library
import SimpleOpenNI.*;
//Create an object called Kinect
SimpleOpenNI kinect;
//Runs once

int Xrect=280;  int Yrect=340;
boolean issitting=false;
boolean anotherboolean;
long T;
void setup()
{
  //Create a canvas size 640 by 480

  size(640, 480);
  //initialize the object
  kinect = new SimpleOpenNI(this);
  //enable the depth sensor on the Kinect
  kinect.enableDepth();
  kinect.enableRGB();
  //Turns on user tracking for the kinect
  kinect.enableUser();
PFont font;
font = createFont("LetterGothicStd.otf", 32);
textFont(font);

}


//Runs continuously

void draw() {
  //Constantly asks for new data from the Kinect based on what we decided in the Setup
  kinect.update();
  //Calls the depth image to the point 0,0
  image(kinect.rgbImage(), 0, 0);
  //Creates a variable called userList to store the user IDs. This
  //variable is declared as an IntVector. This is a special type of variable provided
  //by OpenNI specifically to store lists of integers representing user IDs.
  IntVector userList = new IntVector();
  //puts all of the user IDs that OpenNI knows about into the 
  //IntVector that’s passed into it
  kinect.getUsers(userList);
  noFill();
  stroke(5);
  rect(Xrect, Yrect, 100, 100);
// A for loop that runs for however many users there are in the scene
  for (int i=0; i<userList.size(); i++) { 
//Pulls the value of the user list that the loop is up to
    int userId = userList.get(i);
    //Sets a new vector to locate the position of each person detected in the scene
    PVector position = new PVector();
    //Call this to get the CoM, which stands for Center of Mass
    kinect.getCoM(userId, position); 
    //converts center of mass to coordinates on the processing screen
    kinect.convertRealWorldToProjective(position, position);
    // change the color to red
    fill(255, 0, 0);
    // draw an ellipse at the x and y position of each person's center of mass'


    ellipse(position.x, position.y, 20, 20);
    if (issitting==false){
      triangle(30, 75, 58, 20, Xrect, Yrect);
      stroke(5);
      line(30, 20, 85, 75);
    }
    else if (position.x > Xrect && position.y > Yrect && position.x < Xrect + 100 && position.y < Yrect + 100){
      textAlign(CENTER);
      text("Sitting", position.x, position.y-25);
      issitting=true;
    }
    else if (position.x < Xrect && position.y < Yrect && position.x > Xrect + 100 && position.y > Yrect + 100){
      textAlign(CENTER);
      text("Not sitting", position.x, position.y-25);
    }
    else if (issitting==false){
      triangle(30, 75, 58, 20, Xrect, Yrect);
      stroke(5);
      line(30, 20, 85, 75);
    }
    else{
      issitting=false;
    }
  /*        T=userList.size();
    if (position.x > Xrect && position.y > Yrect && position.x < Xrect + 100 && position.y < Yrect + 100){
      textAlign(CENTER);
      text("Sitting", position.x, position.y-25);
      T= userList.size() - 1;
    }
    else{
      text("Not sitting", position.x, position.y-25);

    }
    if (T==userList.size()){
      triangle(30, 75, 58, 20, Xrect, Yrect);
      stroke(5);
      line(30, 20, 85, 75);
    }
    else if(T==userList.size()-1){
      noStroke();
      noFill();
    }
    */
    
  }
}
