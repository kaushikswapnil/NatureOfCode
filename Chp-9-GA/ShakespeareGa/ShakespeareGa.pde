ArrayList<DNA> population;
String targetString;
int initialPopulationSize;

float populationFitnessFilter = 0.4f;
float populationSizeMultiplier = 1.3f;

void setup()
{
  initialPopulationSize = 10;
  
  targetString = "To Be Or Not To Be";
  
  population = new ArrayList<DNA>();
  
  float mutationRate = 0.03;
  
  for (int iter = 0; iter < initialPopulationSize; ++iter)
  {
    population.add(new DNA(targetString, mutationRate));
  }
  
 int generation = 0;
  while(!TestPopulationForTargetMatch())
  {
    println("Generation : " + generation + " Generation Size : " + population.size());
    PrintPopulationDNA();
    EvolvePopulation();
    ++generation;
  }
  
  println("Mission Successful on Generation :" + generation);
}

void draw()
{
  
}

void EvolvePopulation()
{
  int newPopulationSize = (int)(population.size() * populationSizeMultiplier);
  
  ArrayList<DNA> newPopulation = new ArrayList<DNA>();
  
  ArrayList<DNA> matingPool = new ArrayList<DNA>();
  
  Collections.sort(population, new DNAFitnessComparator());
  
  int topPopulationFilter = (int)(population.size() * populationFitnessFilter);
  
  int totalFitness = GetTotalPopulationFitness(topPopulationFilter);
  
  println("Average Fitness : " + (GetTotalPopulationFitness(population.size())/population.size()));
  println("Average Fitness For Top " + topPopulationFilter + " : " + (totalFitness/topPopulationFilter));
  
  for (int populationIter = 0; populationIter < topPopulationFilter; ++populationIter)
  {
     float percentageFitness;
     if (totalFitness != 0)
     {
       percentageFitness = (int)(population.get(populationIter).GetFitness()*100/totalFitness);
     }
     else
     {
        percentageFitness = 0; 
     } 
     
     for (int matingPoolIter = 0; matingPoolIter < percentageFitness; ++matingPoolIter)
     {
       matingPool.add(population.get(populationIter));
     }       
  }
  
  if (matingPool.size() > 0)
  {
    for (int newPopulationIter = 0; newPopulationIter < newPopulationSize; ++ newPopulationIter)
    {
       int parentAIndex = (int)random(0, matingPool.size());
       int parentBIndex = (int)random(0, matingPool.size());
       
       DNA parentA = matingPool.get(parentAIndex);
       DNA parentB = matingPool.get(parentBIndex);
       
       DNA offspring = parentA.Reproduce(parentB, targetString);
       offspring.Mutate();
       
       newPopulation.add(offspring);
    }
    
    population = newPopulation;
  }  
  else
  {
    for (int populationMutationIter = 0; populationMutationIter < population.size(); ++populationMutationIter)
    {
      population.get(populationMutationIter).Mutate();
      population.get(populationMutationIter).m_Fitness =  population.get(populationMutationIter).EvaluateFitness(targetString);
    }
  }
}

void PrintPopulationDNA()
{
  for (int iter = 0; iter < population.size(); ++iter)
  {
     println(new String(population.get(iter).m_Genes)); 
  } 
}

boolean TestPopulationForTargetMatch()
{
  DNA perfectDNA = new DNA(targetString.toCharArray(), targetString, 0);
  
  for (int iter = 0; iter < population.size(); ++iter)
  {
     if (population.get(iter).GetFitness() == perfectDNA.GetFitness())
     {
        return true; 
     } //<>//
  } 
  
  return false;
}

int GetTotalPopulationFitness(int topFilter)
{
  Collections.sort(population, new DNAFitnessComparator());
  
  int totalFitness = 0;
  for (int iter = 0; iter < topFilter; ++iter)
  {
     totalFitness += population.get(iter).GetFitness();
  }
  
  return totalFitness;
}
