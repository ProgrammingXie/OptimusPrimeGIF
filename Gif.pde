import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer TheTouch, Transform;

ArrayList<PImage> gif;
int n = 0;

PImage Title;

int FrameRate = 60;
int ClickFill = 120;
int ClickText = 50;
boolean Transition = true;

int Fade = 0;
int FadeReverse = 0;

void setup(){

  size(500,500);
  background(0);

  gif = new ArrayList<PImage>();
  
  int i  = 0;
  while (i<16){
    String Zero= "";
    if (i<10){
      Zero= "0";
    }
    gif.add(loadImage("frame_"+Zero+i+"_delay-0.12s.gif"));
    
    i = i + 1;
  }
  
  minim = new Minim(this);
  TheTouch = minim.loadFile("TheT.mp3");
  Transform = minim.loadFile("transformer.mp3");
  
  Title = loadImage("MovieTitle.png");

}


void draw(){
  background(0);
  println(frameRate);  
  frameRate(FrameRate);
  
  if (FadeReverse==0){
    image(Title,0,50,500,140);
  }
  if (Transition){
    fill(ClickFill);
    noStroke();
    rect(150,300,200,70,5);
      
    fill(ClickText);
    textAlign(CENTER,CENTER);
    textSize(35);
    text("Click",width/2,335);
    
    if (mouseX>150 && mouseX<350 && mouseY>300 && mouseY<370){
      ClickFill = 80;
      ClickText = 140;
    }
    else {
      ClickFill = 120;
      ClickText = 50;
    }
  }
  else {
    if (FadeReverse==0){
      Fade = Fade + 1;
      if (Fade>=270){
        Fade = 270;
        Transform.play();
        FadeReverse = 1;
      }
    }
    else {
      Fade = Fade - 10;
      TheTouch.play();
      if (Fade<=0){
        Fade = 0;
      }
    }
  }
  
  if (FadeReverse==1){
    FrameRate = 10;
    PImage frame = gif.get(n);
    image(frame,0,0,height,width);
    n++;
    
    if (n>15){
      n = 0;
    }
    
    if (!TheTouch.isPlaying()){
      TheTouch.rewind();
      TheTouch.play();
    }
  }
  
  fill(0,0,0,Fade);
  rect(0,0,width,height);
  
  println(Transition);

}
//================================================================================================================

void mousePressed(){
  if (mouseX>150 && mouseX<350 && mouseY>300 && mouseY<370){
    Transition = false;
  }
  
}
