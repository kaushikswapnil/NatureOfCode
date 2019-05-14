//Variables
Vehicle[] vehicles = new Vehicle[20];
ExplosionGenerator explosionGenerator;
//

void setup() 
{
  size(1280,720);
  explosionGenerator = new ExplosionGenerator();
  for (int i = 0; i < vehicles.length; i++) 
  { 
    PVector position = new PVector(random(0, 640), random(0, 360));
    PVector velocity = new PVector(0,0);
    PVector acceleration = new PVector(0,0);
    float mass = random(1,6);
    PVector dimension = new PVector(10*mass, 10*mass);
    float maxSpeed = (7 - mass) * 12.0f;
    float maxSteerForce = (7 - mass) * 0.5f;
    vehicles[i] = new Vehicle(position, velocity, acceleration, dimension, maxSpeed, maxSteerForce, mass, 100.0f); 
  }
}

void draw()
{
   background(255);
   
   PVector mousePos = new PVector(mouseX, mouseY);
   float explosionMagnitude = explosionGenerator.TryExplode();
   for (int i = 0; i < vehicles.length; i++) 
  { 
    if (explosionMagnitude > 0)
    {
        PVector explosionDirection = PVector.sub(vehicles[i].m_Position, mousePos);
        PVector explosionForce = new PVector(0.0f,0.0f);
        
        if (explosionDirection.mag() == 0.0f) //For vehicles that are already at the target position, produce a greater, random explosion
        {
           int signSelector = (int)random(0, 2);
           
           int xComponent = 0;
           
           switch (signSelector)
           {
              case 0: //Positive
              xComponent = 1;
              break;
              
              case 1: //Negative
              xComponent = -1;
              break;
           }
           
           signSelector = (int)random(0, 2);
           
           int yComponent = 0;
           
           switch (signSelector)
           {
              case 0: //Positive
              yComponent = 1;
              break;
              
              case 1: //Negative
              yComponent = -1;
              break;
           }
           
           explosionDirection.x = xComponent;
           explosionDirection.y = yComponent; //<>//
        } //<>//
        else
        {
           explosionDirection.normalize();
        }
        
        explosionForce = explosionDirection.get();
        explosionForce.mult(explosionMagnitude);
        vehicles[i].ApplyForce(explosionForce); //<>//
    }
    vehicles[i].Seek(mousePos); 
    vehicles[i].Update();
    vehicles[i].Display();
  }
  stroke(50);
  fill(80);
}

void mousePressed()
{
  explosionGenerator.StartGeneration();
}

void mouseReleased()
{
  explosionGenerator.StopGeneration(); 
}
