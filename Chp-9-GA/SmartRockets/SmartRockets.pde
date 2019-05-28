Population population;

PVector targetPos;

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

boolean pendingQuickTrain = false;

void setup()
{
  size(900, 900);
  
  cyclesCompleted = 0;
  
  targetPos = new PVector(width/2, 50);
  
  population = new Population(initialPopulationSize, numCyclesToRun, maxForce, populationMutationRate);
  
  obstacleManager = new ObstacleManager();
  
  obstacleManager.AddNewObstacle(new PVector(width/2, height/2), new PVector(100, 100));
  
  buttons = new ArrayList<Button>();
  
  buttons.add(new QuickTrainButton(10, 110, 50, 15));
  
  population.QuickTrainPopulation(1000);
}

void draw()
{
  if (cyclesCompleted < numCyclesToRun)
  {
    background(255);
    fill(255);
    
    population.Update(targetPos, obstacleManager.GetObstacles());
    
    ellipse(targetPos.x, targetPos.y, 10, 10);
    
    obstacleManager.DisplayObstacles();
    
    ++cyclesCompleted;
    
    for (Button button : buttons)
    {
       button.Display(); 
    }
  }
  else
  {
    population.EvaluateFitness(targetPos);
    //population.Reproduce(population.Selection());
    population.EvolvePopulation();
    
    if (pendingQuickTrain)
    {
       population.QuickTrainPopulation(500); 
       pendingQuickTrain = false;
    }
    
    cyclesCompleted = 0;
  }
  
  // Display some info
  fill(0);
  text("Generation #: " + population.m_Generation, 10, 18);
  text("Cycles left: " + (numCyclesToRun-cyclesCompleted), 10, 36);
  text("Avg Fitness of Last Gen: " + population.m_AvgFitnessOfLastGen, 10, 54);
  text("Avg Fitness of Top Performers in Last Gen: " + population.m_AvgFitnessOfTopPerformersOfLastGen, 10, 72);
  text("Max Fitness: " + population.GetMaxFitness(), 10, 90);
}

void mouseDragged()
{
  if (obstacleGenerationState == 0)
  {  
    dragStartPosX = mouseX;
    dragStartPosY = mouseY;
    obstacleGenerationState = 1;
  }
}

void mouseReleased()
{
   if (obstacleGenerationState == 1)
   {
      obstacleManager.AddNewObstacle(new PVector(dragStartPosX, dragStartPosY), new PVector(abs(mouseX - dragStartPosX), abs(mouseY - dragStartPosY)));
      obstacleGenerationState = 0;
   }
}

void mouseClicked()
{
   for (Button button : buttons)
   {
      if (button.IsPositionInsideButtonArea(mouseX, mouseY))
      {
         button.OnClicked(); 
      }
   }
}
