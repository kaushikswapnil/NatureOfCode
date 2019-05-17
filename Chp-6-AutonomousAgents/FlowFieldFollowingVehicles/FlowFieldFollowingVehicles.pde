//Variables
Vehicle[] vehicles = new Vehicle[1000];
ExplosionGenerator explosionGenerator;

boolean isDebugModeOn;

FlowField flowField;

boolean movingFlowField;

int clearanceRate = 10; //Increase this value to delete more particles

int tickCounter;

float colorMultiplier = 500.0;
int flowFieldResolution;

int timeLastFrame = 0;

float xFlowMove = 0.0f;
float yFlowMove = 0.0f;
float zFlowMove = 0.0f;

float xFlowSpeed = 0.0008f;
float yFlowSpeed = 0.01f;
float zFlowSpeed = 0.05f;
//


void setup() 
{
  size(900,700);
  
  tickCounter = 0;
  isDebugModeOn = true;
  movingFlowField = true;
  
  flowFieldResolution = 20;
  
  flowField = new FlowField(flowFieldResolution);
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
    float maxSpeed = 20;//massInverse * 10.0f;
    float maxSteerForce = 15;//massInverse * 2f;
    
    float slowDownDistance = massInverse * 12;
    
    float wanderCircleCenterDistance = mass * 4f;
    float wanderCircleRadius = (massInverse * 1.0f) + (mass * 3.0f);
    vehicles[i] = new Vehicle(position, velocity, acceleration, dimension, maxSpeed, maxSteerForce, mass, slowDownDistance, wanderCircleCenterDistance, wanderCircleRadius); 
  }
}

void draw()
{
   background(0, 0, 0, clearanceRate);
   
   if (movingFlowField)
   {
     int timePassed = (millis() - timeLastFrame);
     timeLastFrame = millis();
     
     xFlowMove += xFlowSpeed * timePassed;
     yFlowMove += yFlowSpeed * timePassed;
     zFlowMove += zFlowSpeed * timePassed;
   }
   
   //if (isDebugModeOn)
     DrawFlowField();   
   
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
    
    vehicles[i].FollowFlow(flowField); 
    vehicles[i].Update();
    vehicles[i].Display();
  }
  
  ++tickCounter;
}

PVector GetFlowDirectionAt(PVector position, FlowField flow)
 {  
  return GetFlowDirectionAt(position.x, position.y, flow);
 }
 
PVector GetFlowDirectionAt(float posX, float posY, FlowField flow)
 {  
  if (movingFlowField)
   {
      return flow.GetFlowDirectionAt(posX/flowFieldResolution, posY/flowFieldResolution, xFlowMove, yFlowMove, zFlowMove);
   }
   
   return flowField.GetFlowDirectionAt(posX, posY);
 }
 
 void DrawFlowField()
 {
    for ( int x = 0; x < width; x = x + flowFieldResolution)
    {
      for (int y = 0; y < height; y = y + flowFieldResolution)
      {
        pushMatrix();
        translate(x, y);
        stroke(255, 8);
        //fill(255);
        PVector flowVector = GetFlowDirectionAt(x, y, flowField);
        rotate(flowVector.heading());
        line(0, 0, flowVector.mag() * (flowFieldResolution -2), 0);
        //ellipse(x, y, 10, 10);
        //text("Hi there", x, y);
        popMatrix();
      }      
    }
    
    //ellipse(width/2, height/2, 10, 10);
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
   else if (key == 'f')
     movingFlowField = !movingFlowField;
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
