import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<IWorldEntity> worldEntities;
ArrayList<Boundary> boundaries;

void setup()
{
  size(800, 800);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  
  worldEntities = new ArrayList<IWorldEntity>();
  
  worldEntities.add(new Box(50, 50, 70, 80));
  worldEntities.add(new Circle(300, 50, 70));
  
  boundaries = new ArrayList<Boundary>();
  
  float boundWidth = 20;
  float halfBoundWidth = boundWidth/2;
  boundaries.add(new Boundary(halfBoundWidth, height/2, boundWidth, height));
  boundaries.add(new Boundary(width/2, halfBoundWidth, width, boundWidth));
  boundaries.add(new Boundary(width - halfBoundWidth, height/2, boundWidth, height));
  boundaries.add(new Boundary(width/2, height - halfBoundWidth, width, boundWidth));
}

void draw()
{
  background(255);
  
  box2d.step();
  
  for (IWorldEntity worldEntity : worldEntities)
  {
    worldEntity.Display();
  }  
  
  for (Boundary boundary : boundaries)
  {
    boundary.Display();
  }
}

Box2DProcessing GetPhysicWorld()
{
   return box2d; 
}

float ConvertScalarPixelsToPhysicWorldUnit(float value)
{
   return box2d.scalarPixelsToWorld(value); 
}
