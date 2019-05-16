//Variables
Vehicle[] vehicles = new Vehicle[1];//[45];
ExplosionGenerator explosionGenerator;

boolean isDebugModeOn;

Path path;
//


void setup() 
{
  size(1280,720);
  
  isDebugModeOn = true;
  
  path = new Path();
 
  explosionGenerator = new ExplosionGenerator();
  
  Init();
}

void draw()
{
   background(0);
   
   path.Display();
   
   PVector mousePos = new PVector(mouseX, mouseY);
   float explosionMagnitude = explosionGenerator.TryExplode();
   explosionMagnitude = explosionMagnitude*10;
   for (int i = 0; i < vehicles.length; i++) 
  { 
    if (explosionMagnitude > 0)
    {
        PVector explosionDirection = PVector.sub(vehicles[i].m_Position, mousePos);
        PVector explosionForce = new PVector(0.0f,0.0f);
        
        if (explosionDirection.mag() == 0.0f) //For vehicles that are already at the target position, produce a greater, random explosion
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
        }
        
        explosionDirection.normalize();
        
        explosionForce = explosionDirection.copy();
        explosionForce.mult(explosionMagnitude);
        vehicles[i].ApplyForce(explosionForce);
    }
    vehicles[i].FollowPath(path); 
    vehicles[i].Update();
    vehicles[i].Display();
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
     isDebugModeOn = !isDebugModeOn;
   else if (key == 'r')
     Reset();
}

void Reset()
{
 path.Reset(); 
 Init(); 
}

void Init()
{
  float radius = random(1, 30);
  
  //float yComp = random(0, height);
  //PVector start = new PVector(radius, yComp);
  //PVector end = new PVector(width-radius, yComp);
  
  path.Reset(); //#TODO Remove this call later
  
  ArrayList<PVector> points = new ArrayList<PVector>();

  int xResolution = (int)random(100,200);
  int startX = 50;
  int endX = 1200;
  
  int startY = height/2;
  
  int availableWidth = endX - startX;
  int numSections = availableWidth/xResolution;
  
  int numPoints = numSections+1;
  
  for (int iter = 0; iter < numPoints; ++iter)
  {
     int xOffset = availableWidth * iter/numSections;
     int yOffset = (int)random(-100,100);
     PVector point = new PVector(startX + xOffset, startY + yOffset);
     points.add(point);
  }
  
  path.Init(points, radius);
  
  for (int i = 0; i < vehicles.length; i++) 
  { 
    //PVector position = new PVector(random(0, width), random(0, height));
    PVector position = new PVector(80, 0);
    PVector velocity = new PVector(0,0);
    PVector acceleration = new PVector(0,0);
    
    float mass = 3;//random(1,6);
    float massInverse = 7 - mass;
    
    PVector dimension = new PVector(10*mass, 10*mass);
    float maxSpeed = 6.0f;//massInverse * 10.0f;
    float maxSteerForce = massInverse * 2.25f;
    
    float slowDownDistance = massInverse * 12;
    
    float wanderCircleCenterDistance = mass * 4f;
    float wanderCircleRadius = (massInverse * 1.0f) + (mass * 3.0f);
    vehicles[i] = new Vehicle(position, velocity, acceleration, dimension, maxSpeed, maxSteerForce, mass, slowDownDistance, wanderCircleCenterDistance, wanderCircleRadius); 
  }
}
