class DNA
{
 float[] m_Genes;
 
 DNA(int geneLength)
 {
    m_Genes = new float[geneLength];
    
    for (int iter = 0; iter < m_Genes.length; ++iter)
    {
        m_Genes[iter] = random(0, 1);
    }
 }
 
 DNA(float[] genes)
 {
    m_Genes = genes;
 }
 
 void Mutate(float mutationRate)
 {
   for (int iter = 0; iter < m_Genes.length; ++iter)
   {
      if (random(1) < mutationRate)
      {
         m_Genes[iter] = random(0, 1); 
      }
   }
 }
 
 DNA CrossOver(DNA otherParent)
 {
   int geneLength = m_Genes.length;
   
   float[] offspringGenes = new float[geneLength];
   
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
   
   return new DNA(offspringGenes);
 }
}
