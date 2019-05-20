class CA
{
 int[] m_Ruleset;
 int[] m_Cells;
 int m_Generation;
 int m_CellWidth;
  
 CA(int[] ruleset, int cellWidth)
 {
    m_Ruleset = ruleset;
    m_CellWidth = cellWidth;
    m_Cells = new int[width/m_CellWidth];
    
    Reset();
 }
  
 void Update()
 {
   ComputeNewGeneration();
 }
 
 void ComputeNewGeneration()
 {
   int[] newCells = new int[width/m_CellWidth];
   
   for(int iter = 0; iter < newCells.length; ++iter)
   {
      int leftNeighbourState;
      
      if (iter == 0) //if this is the first cell, loop around to the one on the other end
      {
        leftNeighbourState = m_Cells[m_Cells.length - 1];
      }
      else
      {
        leftNeighbourState = m_Cells[iter - 1]; 
      }
      
      int rightNeighbourState;
      
      if (iter == newCells.length - 1) //if this is the last cell, loop around to the one on the other end
      {
        rightNeighbourState = m_Cells[0];
      }
      else
      {
        rightNeighbourState = m_Cells[iter + 1]; 
      }
      
      int currentState = m_Cells[iter];
      
      newCells[iter] = EvaluateNewState(leftNeighbourState, currentState, rightNeighbourState);
   }
   
   m_Cells = newCells;
   
   ++m_Generation;
 }
 
 int EvaluateNewState(int leftNeighbourState, int currentState, int rightNeighbourState)
 {
   String s = "" + leftNeighbourState + currentState + rightNeighbourState;
   int ruleIndex = Integer.parseInt(s, 2); //parses the string as a binary value, returning the index of the ruleset element
   return m_Ruleset[ruleIndex];
 }
 
 boolean HasFinished()
 {
    return m_Generation * m_CellWidth > height;
 }
 
 void Display()
 {
   for (int iter = 0; iter < m_Cells.length; ++iter)
   {
     if (m_Cells[iter] == 1)
     {
       fill (255);
       rect(iter * m_CellWidth, m_Generation * m_CellWidth, m_CellWidth, m_CellWidth);
     }
   }
 }
 
 void CreateRandomRuleset()
 {
   for (int iter = 0; iter < 8; ++iter)
   {
     m_Ruleset[iter] = (int)random(2);
   }
 }
 
 void Reset()
 {
   m_Generation = 0;
   for (int iter = 0; iter < m_Cells.length; ++iter)
   {
     m_Cells[iter] = 0;
   }
   
   int middleIndex = m_Cells.length / 2;
   
   if (m_Cells.length % 2 != 0)
   {
     middleIndex = (m_Cells.length / 2) + 1;
   }
   
   m_Cells[middleIndex] = 1;
 }
}
