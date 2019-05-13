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
    float maxSpeed = (7 - mass) * 5.0f;
    float maxSteerForce = (7 - mass) * 0.5f;
    vehicles[i] = new Vehicle(position, velocity, acceleration, dimension, maxSpeed, maxSteerForce, mass, random(1,4)); 
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
        PVector explosionForce = PVector.sub(vehicles[i].m_Position, mousePos);
        
        if (explosionForce.mag() == 0.0f) //For vehicles that are already at the target position, produce a greater, random explosion
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
           
           explosionForce.x = xComponent;
           explosionForce.y = yComponent;
           
           
        }
        
        vehicles[i].ApplyForce(explosionForce);
    }
    vehicles[i].Seek(mousePos); 
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
