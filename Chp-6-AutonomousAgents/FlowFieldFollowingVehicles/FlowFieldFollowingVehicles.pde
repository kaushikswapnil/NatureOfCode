//Variables
Vehicle[] vehicles = new Vehicle[45];
ExplosionGenerator explosionGenerator;

boolean isDebugModeOn;

FlowField flowField;
//


void setup() 
{
  size(1280,720);
  
  isDebugModeOn = false;
  
  flowField = new FlowField(20);
  flowField.Init();
 
  explosionGenerator = new ExplosionGenerator();
  
  for (int i = 0; i < vehicles.length; i++) 
  { 
    PVector position = new PVector(random(0, width), random(0, height));
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
  }
}

void draw()
{
   background(0);
   
   if (isDebugModeOn)
     flowField.Display();
   
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
        
        explosionForce = explosionDirection.copy();
        explosionForce.mult(explosionMagnitude);
        vehicles[i].ApplyForce(explosionForce); //<>//
    }
    vehicles[i].FollowFlow(flowField); 
    vehicles[i].Update();
    vehicles[i].Display();
  }
}

void mouseClicked()
{
   Reset();
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
}

void Reset()
{
  flowField.Init();
  
  for (int i = 0; i < vehicles.length; i++) 
  { 
    PVector position = new PVector(random(0, width), random(0, height));
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
  }
}
