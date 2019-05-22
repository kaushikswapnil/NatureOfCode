import java.util.*;  

class DNA
{
 char[] m_Genes;
 int m_Fitness;
 float m_MutationRate;
 
 DNA(String target, float mutationRate)
 {
    m_Genes = new char[target.length()];
    for (int iter = 0; iter < target.length(); ++iter)
    {
      m_Genes[iter] = (char)random(65,128);
    }
    m_Fitness = EvaluateFitness(target);
    m_MutationRate = mutationRate;
 }
 
 DNA(char[] genes, String target, float mutationRate)
 {  
    m_Genes = genes; 
    m_Fitness = EvaluateFitness(target);
    m_MutationRate = mutationRate;
 }
 
 int GetFitness()
 {
   return m_Fitness;
 }
 
 int EvaluateFitness(String againstTarget)
 {
    int fitness = 0;
    
    int pointsForCorrectPos = 5;
    int pointsForPresence = 1;
    float pointsForDistanceToTargetChar = -1/128.0f;
    
    for (int iter = 0; iter < m_Genes.length; ++iter)
    {
      char c = m_Genes[iter];
      
      String testCString = "" + c;
      
      if (againstTarget.contains(testCString))
      {
         //int distanceToTargetChar = (int)c - (int)(againstTarget.charAt(iter));
         //fitness +=  pointsForPresence*(1 + (distanceToTargetChar*pointsForDistanceToTargetChar));
         
         if (c == againstTarget.charAt(iter))
         {
           fitness += pointsForCorrectPos; 
         } 
      }     
    }
    
    fitness *= fitness;
    
    return fitness;
 }
 
 void Mutate()
 {
   for (int iter = 0; iter < m_Genes.length; ++iter)
   {
      if (random(1) < m_MutationRate)
      {
         m_Genes[iter] = (char)random(32, 128); 
      }
   }
 }
 
 DNA Reproduce(DNA otherParent, String target)
 {
   int geneLength = m_Genes.length;
   
   char[] offspringGenes = new char[geneLength];
   
   int randomMidPoint = (int)random(0, geneLength);
   
   for (int iter = 0; iter < geneLength; ++iter)
   {
      if (iter < randomMidPoint)
      {
         offspringGenes[iter] = m_Genes[iter]; 
      }
      else
      {
         offspringGenes[iter] = otherParent.m_Genes[iter];
      }
   } 
   
   return new DNA(offspringGenes, target, m_MutationRate);
 }
}

class DNAFitnessComparator implements Comparator<DNA>
{
  int compare(DNA dna1,DNA dna2)
  {  
    if (dna1.GetFitness() < dna2.GetFitness())
    {
      return 1; 
    }
    else if (dna1.GetFitness() == dna2.GetFitness())
    {
      return 0; 
    }
    else
    {
      return -1;
    }
  }  
}
