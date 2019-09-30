//Variables
int SCREEN_WIDTH;
int SCREEN_HEIGHT;

Vehicle[] vehicles = new Vehicle[45];
ExplosionGenerator explosionGenerator;
 
boolean debugDisplay = false;

//


void setup() 
{
  size(1280,720);
 
  int SCREEN_WIDTH = 1280;
  int SCREEN_HEIGHT = 720; //This does not actually change the screen dimensions, simply stores them for easy use.
  
  explosionGenerator = new ExplosionGenerator();
  for (int i = 0; i < vehicles.length; i++) 
  { 
    PVector position = new PVector(random(0, SCREEN_WIDTH), random(0, SCREEN_HEIGHT));
    PVector velocity = new PVector(0,0);
    PVector acceleration = new PVector(0,0);
    
    float mass = random(1,6);
    float massInverse = 7 - mass;
    
    PVector dimension = new PVector(10*mass, 10*mass);
    float maxSpeed = massInverse * 10.0f;
    float maxSteerForce = massInverse * 2f;
    
    float slowDownDistance = massInverse * 12;
    
    float wanderCircleCenterDistance = mass * 4f;
    float wanderCircleRadius = (massInverse * 1.0f) + (mass * 3.0f);
    vehicles[i] = new Vehicle(position, velocity, acceleration, dimension, maxSpeed, maxSteerForce, mass, slowDownDistance, wanderCircleCenterDistance, wanderCircleRadius); 
    
    vehicles[i].SCREEN_WIDTH = SCREEN_WIDTH;
    vehicles[i].SCREEN_HEIGHT = SCREEN_HEIGHT;
  }
}

void draw()
{
   background(0);
   
   PVector mousePos = new PVector(mouseX, mouseY);
   float explosionMagnitude = explosionGenerator.TryExplode();
   explosionMagnitude = explosionMagnitude*10;
   for (int i = 0; i < vehicles.length; i++) 
  { 
    if (explosionMagnitude > 0)
    {
        PVector explosionDirection = PVector.sub(vehicles[i].m_Position, mousePos);
        PVector explosionForce = new PVector(0.0f,0.0f);
        
        if (explosionDirection.mag() == 0.0f) //For vehicles that are already at the target position, produce a greater, random explosion //<>//
        {
           int signSelector = (int)random(0, 2);
           
           float xComponent = random(0,2);
           
           switch (signSelector)
           {
              case 0: //Positive
              xComponent *= 1;
              break;
              
              case 1: //Negative
              xComponent *= -1;
              break;
           }
           
           signSelector = (int)random(0, 2);
           
           float yComponent = random(0,2);
           
           switch (signSelector)
           {
              case 0: //Positive
              yComponent *= 1;
              break;
              
              case 1: //Negative
              yComponent *= -1;
              break;
           }
           
           explosionDirection.x = xComponent;
           explosionDirection.y = yComponent;
        } //<>//
        
        explosionDirection.normalize(); //<>//
        
        explosionForce = explosionDirection.get();
        explosionForce.mult(explosionMagnitude);
        vehicles[i].ApplyForce(explosionForce); //<>//
    }
    vehicles[i].Seek(mousePos); 
    vehicles[i].Update();
    vehicles[i].Display();
  }
  
  if (debugDisplay)
  {
     textAlign(CENTER);
     text("These vehicles will follow your mouse around. Click anywhere and hold to create an explosion throwing them all outwards. The longer you hold, the stronger the explosion", width/2, 20); 
  }
}

void mousePressed()
{
  explosionGenerator.StartGeneration();
}

void mouseReleased()
{
  explosionGenerator.StopGeneration(); 
}

void keyPressed()
{
   if (key == ' ')
   {
     debugDisplay = !debugDisplay;
   }
}
