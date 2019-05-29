class DNA
{
 PVector[] m_Genes;
 float m_MaxForce;
 
 DNA(int geneSequenceLength, float maxForce)
 {
    m_Genes = new PVector[geneSequenceLength];
    for (int iter = 0; iter < geneSequenceLength; ++iter)
    {
       m_Genes[iter] =  PVector.random2D();
       m_Genes[iter].mult(random(0, maxForce));
    }
    
    m_MaxForce = maxForce;
 }
 
 DNA(PVector[] genes, float maxForce)
 {  
    m_Genes = genes; 
    m_MaxForce = maxForce;
 }
 
 void Mutate(float mutationRate)
 {
   for (int iter = 0; iter < m_Genes.length; ++iter)
   {
      if (random(1) < mutationRate)
      {
         m_Genes[iter] = PVector.random2D(); 
      }
   }
 }
 
 DNA Reproduce(DNA otherParent)
 {
   int geneLength = m_Genes.length;
   
   PVector[] offspringGenes = new PVector[geneLength];
   
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
   
   float maxForce;
   if (random(1) < 0.5)
   {
     maxForce = m_MaxForce;
   }
   else 
   {
     maxForce = otherParent.m_MaxForce;
   }
   
   return new DNA(offspringGenes, maxForce);
 }
}
