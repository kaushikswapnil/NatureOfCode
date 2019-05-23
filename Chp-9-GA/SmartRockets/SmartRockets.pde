Population population;

PVector targetPos;

int initialPopulationSize = 100; 
int numCyclesToRun = 600;
float maxForce = 0.8;
float populationMutationRate = 0.02;

int cyclesCompleted;

void setup()
{
  size(900, 900);
  
  cyclesCompleted = 0;
  
  targetPos = new PVector(width/2, 50);
  
  population = new Population(initialPopulationSize, numCyclesToRun, maxForce, populationMutationRate);
}

void draw()
{
  if (cyclesCompleted < numCyclesToRun)
  {
    background(255);
    fill(255);
    
    population.Update(targetPos);
    
    ellipse(targetPos.x, targetPos.y, 10, 10);
    
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
}
