CA ca;
float startingAliveChance = 0.10;

void setup()
{
  size (500,500);
  
  ca = new CA(10);
  
  frameRate(1);
}

void draw()
{
  background(0);
  
  ca.ComputeNewGeneration();
  ca.Display();
}
