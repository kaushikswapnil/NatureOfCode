Population population;

PVector targetPos;

int initialPopulationSize = 100; 
int numCyclesToRun = 600;
float maxForce = 0.8;
float populationMutationRate = 0.02;

int cyclesCompleted;

ArrayList<Obstacle> obstacleList;

void setup()
{
  size(900, 900);
  
  cyclesCompleted = 0;
  
  targetPos = new PVector(width/2, 50);
  
  population = new Population(initialPopulationSize, numCyclesToRun, maxForce, populationMutationRate);
  
  obstacleList = new ArrayList<Obstacle>();
  
  obstacleList.add(new Obstacle(new PVector((width/2) - 100, height/2), new PVector(100, 20)));
  
  //QuickTrainPopulation(1000);
}

void draw()
{
  if (cyclesCompleted < numCyclesToRun)
  {
    background(255);
    fill(255);
    
    population.Update(targetPos, obstacleList);
    
    ellipse(targetPos.x, targetPos.y, 10, 10);
    
    for (Obstacle obstacle : obstacleList)
    {
       obstacle.Display(); 
    }
    
    ++cyclesCompleted;
  }
  else
  {
    population.EvaluateFitness(targetPos);
    //population.Reproduce(population.Selection());
    population.EvolvePopulation();
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

void QuickTrainPopulation(int numGens)
{
   for (int iter = 0; iter < numGens; ++iter)
   {
      for (int cycleIter = 0; cycleIter < numCyclesToRun; ++cycleIter)
      {
          population.QuickUpdate(targetPos);
      }
      
      population.EvaluateFitness(targetPos);
      population.EvolvePopulation();
   }
}
