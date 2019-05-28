class Population
{
  ArrayList<Rocket> m_Population;
  float m_MutationRate;
  int m_Generation;
  float m_AvgFitnessOfLastGen;
  float m_AvgFitnessOfTopPerformersOfLastGen;
  
  Population(int populationSize, int lifetime, float maxForce, float mutationRate)
  {
     m_Population = new ArrayList<Rocket>();
     
     for (int iter = 0; iter < populationSize; ++iter)
     {
        m_Population.add(new Rocket(new PVector(width/2, height), lifetime, maxForce)); 
     }
     
     m_MutationRate = mutationRate;
     m_Generation = 0;
     
     m_AvgFitnessOfLastGen = m_AvgFitnessOfTopPerformersOfLastGen = 0;
  }
  
  void Update(PVector target, ArrayList<Obstacle> obstacles)
  {
     for (Rocket rocket : m_Population)
     {
        rocket.Update(); 
        rocket.UpdateTargetStatistics(target);
        rocket.UpdateObstacleStatistics(obstacles);
     }
  }
  
  void QuickUpdate(PVector target, ArrayList<Obstacle> obstacles)
  {
    for (Rocket rocket : m_Population)
     {
        rocket.QuickUpdate(); 
        rocket.UpdateTargetStatistics(target);
        rocket.UpdateObstacleStatistics(obstacles);
     }
  }
  
  void EvaluateFitness(PVector targetLoc)
  {
     for (Rocket rocket : m_Population)
     {
        rocket.EvaluateFitness(targetLoc); 
     }
  }
  
  ArrayList<Rocket> Selection()
  {
    float maxFitness = GetMaxFitness();
    
    //Generate mating pool   
    ArrayList<Rocket> matingPool = new ArrayList<Rocket>();
    
    for (Rocket rocket : m_Population)
    {
       float fitnessNormal = map(rocket.m_Fitness, 0, maxFitness, 0, 1); 
       int matingPoolRepCount = (int)(fitnessNormal*100); //Arbitrary multiplier
       
       for (int matingPoolAdder = 1; matingPoolAdder < matingPoolRepCount; ++matingPoolAdder)
       {
         matingPool.add(rocket);
       }
    }
    
    return matingPool;
  }
  
  void Reproduce(ArrayList<Rocket> matingPool)
  {
    ArrayList<Rocket> newPopulation = new ArrayList<Rocket>();
    
    for (int iter = 0; iter < m_Population.size(); ++iter)
    {
       int parentAIndex = (int)random(0, matingPool.size());
       int parentBIndex = (int)random(0, matingPool.size());
       
       Rocket parentA = matingPool.get(parentAIndex);
       Rocket parentB = matingPool.get(parentBIndex);
       
       Rocket offspring = parentA.Reproduce(parentB);
       offspring.Mutate(m_MutationRate);
       newPopulation.add(offspring); 
    }
    
    m_Population = newPopulation;
    ++m_Generation;
  }
  
  void EvolvePopulation()
  {    
    Collections.sort(m_Population, new RocketFitnessComparator());
    
    float topSelectionPercentage = 0.35f;
    float fitnessSumForTopSelection = GetFitnessSumForTop(topSelectionPercentage);
    
    int topSelection = (int)(m_Population.size() * topSelectionPercentage);
    
    //Generate mating pool   
    ArrayList<Rocket> matingPool = new ArrayList<Rocket>();
    
    m_AvgFitnessOfLastGen = GetFitnessSumForTop(1) / m_Population.size();
    
    if (fitnessSumForTopSelection > 0)
    {
      m_AvgFitnessOfTopPerformersOfLastGen = fitnessSumForTopSelection / topSelection;
      for (int topSelectionIter = 0; topSelectionIter < topSelection; ++topSelectionIter)
      {
         float fitnessForRocket = m_Population.get(topSelectionIter).m_Fitness;
         float percentageFitness = map(fitnessForRocket, 0, GetMaxFitness(), 0, 100);
         
         for (int matingPoolAdder = 0; matingPoolAdder < percentageFitness; ++ matingPoolAdder)
         {
            matingPool.add(m_Population.get(topSelectionIter)); 
         }
      }
    }
    else
    {
       matingPool = m_Population;
       m_AvgFitnessOfTopPerformersOfLastGen = 0;
    }
    
    //Generate new population
    ArrayList<Rocket> newPopulation = new ArrayList<Rocket>();
    int newPopulationSize = m_Population.size();
    for (int newPopulationIter = 0; newPopulationIter < newPopulationSize; ++newPopulationIter)
    {  
       int parentAIndex = (int)random(0, matingPool.size());
       int parentBIndex = (int)random(0, matingPool.size());
       
       Rocket parentA = matingPool.get(parentAIndex);
       Rocket parentB = matingPool.get(parentBIndex);
       
       Rocket offspring = parentA.Reproduce(parentB);
       offspring.Mutate(m_MutationRate);
       newPopulation.add(offspring); 
    }
    
    m_Population = newPopulation;
    ++m_Generation;
  }
  
  float GetFitnessSumForTop(float topSelectionPercentage)
  { 
    float fitnessSum = 0;
    
    int topSelection = (int)(m_Population.size() * topSelectionPercentage);
    for (int iter = 0; iter < topSelection; ++iter)
    {
       fitnessSum += m_Population.get(iter).m_Fitness ;
    }
    
    return fitnessSum;
  }
  
  float GetFitnessSum()
  { 
    float fitnessSum = 0;

    for (int iter = 0; iter < m_Population.size(); ++iter)
    {
       fitnessSum += m_Population.get(iter).m_Fitness;
    }
    
    return fitnessSum;
  }
  
  float GetMaxFitness()
  {
     float maxFitness = -10000; //absurdly low number
     
     for (Rocket rocket : m_Population)
     {
        if (maxFitness < rocket.m_Fitness)
        {
           maxFitness = rocket.m_Fitness; 
        }
     }
     
     return maxFitness; //<>//
  }
}
