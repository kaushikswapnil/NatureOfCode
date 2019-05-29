Population population;

int initialPopulationSize = 100; 
int numCyclesToRun = 600;
float maxForce = 0.8;
float populationMutationRate = 0.02;

int cyclesCompleted;

ObstacleManager obstacleManager;

float dragStartPosX = 0;
float dragStartPosY = 0;

int obstacleGenerationState = 0; //0 = Not Generating, 1 = TrackingMouse 

ArrayList<Button> buttons;

int pendingQuickTrainCounter = 0;

boolean drawDebug = true;

int targetMovementState = 0; //0 = static, 1 = moving, 2 = moved;

Obstacle targetObstacle;

void setup()
{
  size(900, 900);
  
  cyclesCompleted = 0;
  
  PVector targetPos = new PVector(width/2, 50);
  PVector targetDimensions = new PVector(20, 20);
  
  targetObstacle = new Obstacle(targetPos, targetDimensions, 1);
  
  population = new Population(initialPopulationSize, numCyclesToRun, maxForce, populationMutationRate);
  
  obstacleManager = new ObstacleManager();
  
  //obstacleManager.AddNewObstacle(new PVector(width/2, height/2), new PVector(100, 100));
  
  buttons = new ArrayList<Button>();
  
  buttons.add(new QuickTrainButton("Quick Train by 1000", 10, 100, 18));
  
  //population.QuickTrainPopulation(1000);
}

void draw()
{
  if (cyclesCompleted < numCyclesToRun)
  {
    background(255);
    fill(255);
    
    population.Update(targetObstacle, obstacleManager.GetObstacles());
    
    targetObstacle.Display();
    
    obstacleManager.DisplayObstacles();
    
    ++cyclesCompleted;
    
    for (Button button : buttons)
    {
       button.Display(); 
    }
  }
  else if (targetMovementState == 1 || targetMovementState == 2) //if target was moved, we want to create a new population instead
  {
    population = new Population(initialPopulationSize, numCyclesToRun, maxForce, populationMutationRate);
    targetMovementState = 0;
    cyclesCompleted = 0;
  }
  else
  {
    population.EvaluateFitness();
    population.EvolvePopulation();
    
    if (pendingQuickTrainCounter > 0)
    {
       population.QuickTrainPopulation(1000 * pendingQuickTrainCounter); 
       pendingQuickTrainCounter = 0;
    }
    
    cyclesCompleted = 0;
  }
  
  if (drawDebug)
  {
     DebugDraw(); 
  }
}

void DebugDraw()
{
  fill(0);
  text("Generation #: " + population.m_Generation, 10, 18);
  text("Cycles left: " + (numCyclesToRun-cyclesCompleted), 10, 36);
  text("Avg Fitness of Last Gen: " + population.m_AvgFitnessOfLastGen, 10, 54);
  text("Avg Fitness of Top Performers in Last Gen: " + population.m_AvgFitnessOfTopPerformersOfLastGen, 10, 72);
  text("Max Fitness: " + population.GetMaxFitness(), 10, 90);
}

void mouseDragged()
{
  PVector mousePos = new PVector(mouseX, mouseY);
  if ((targetObstacle.IsPointInside(new PVector(mouseX, mouseY)))
    && (targetMovementState == 0 || targetMovementState == 2)) //if we are dragging the target, then we want to move it instead of creating an obstacle
  {
    targetMovementState = 1;
  }
  
  if (targetMovementState == 1)
  {
    targetObstacle.m_Position = mousePos;
  }
  else if (obstacleGenerationState == 0)
  {  
     dragStartPosX = mouseX;
     dragStartPosY = mouseY;
     obstacleGenerationState = 1; 
  }
}

void mouseReleased()
{
   if (targetMovementState == 1)
   {
      targetMovementState = 2; 
   }
   else if (obstacleGenerationState == 1)
   {
      obstacleManager.AddNewObstacle(new PVector(dragStartPosX, dragStartPosY), new PVector(abs(mouseX - dragStartPosX), abs(mouseY - dragStartPosY)));
      obstacleGenerationState = 0;
   }
}

void mouseClicked()
{
   for (Button button : buttons) //<>//
   {
      if (button.IsPositionInsideButtonArea(mouseX, mouseY))
      { //<>//
         button.OnClicked(); 
      }
   }
}

void keyPressed()
{
   if (key == ' ')
   {
      drawDebug = !drawDebug; 
   }
}
