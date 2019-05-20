class CA
{
 Cell[][] m_Board; 
 
 int m_Cols, m_Rows;
 float m_CellWidth;
 
 CA(float cellWidth)
 {
    m_Cols = (int)(width/cellWidth);
    m_Rows = (int)(height/cellWidth);
    m_CellWidth = cellWidth;
    m_Board = new Cell[m_Cols][m_Rows];
    
    Reset();
 }
 
 void Display()
 {
   for (int xIter = 0; xIter < m_Cols; ++xIter)
   {
    for (int yIter = 0; yIter < m_Rows; ++yIter)
    {
      m_Board[xIter][yIter].Display();
    } 
   }
 }
 
 void Reset()
 {
   for (int xIter = 0; xIter < m_Cols; ++xIter)
   {
    for (int yIter = 0; yIter < m_Rows; ++yIter)
    {
       int state = 0;
       if ((random(1) < startingAliveChance))
       {
         state = 1;
       }
       m_Board[xIter][yIter] = new Cell( m_CellWidth * xIter, m_CellWidth * yIter, m_CellWidth, state);
    }
   }
 }
 
 void ComputeNewGeneration()
 {
   for (int xIter = 0; xIter < m_Cols; ++xIter)
   {
    for (int yIter = 0; yIter < m_Rows; ++yIter)
    {
      int numAliveNeighbours = 0;
      
      //To move between neighbours
      for (int neighbourXIter = -1; neighbourXIter <= 1; ++neighbourXIter)
      {
        for (int neighbourYIter = -1; neighbourYIter <= 1; ++neighbourYIter)
        {
          if (m_Board[(xIter + neighbourXIter + m_Cols) % m_Cols][(yIter + neighbourYIter + m_Rows) % m_Rows].m_State == 1)
          {
            ++numAliveNeighbours;
          }
        }
      }
      
      int newState = m_Board[xIter][yIter].m_State;
      
      if (m_Board[xIter][yIter].m_State == 1)
      {
        //Since we added the value of the current cell as well in the loop, now we must remove it
        --numAliveNeighbours;
        
        if (numAliveNeighbours >= 4) //Overpopulation
        {
          newState = 0;
        }
        else if (numAliveNeighbours < 2) //loneliness
        {
          newState = 0; 
        }
        else
        {
          newState = 1; 
        }
      }
      else if (numAliveNeighbours == 3)
      {
         newState = 1; 
      }
      
      if (m_Board[xIter][yIter].m_State != newState)
      {
         m_Board[xIter][yIter].m_State = newState; 
      }
    }
   }
 }
}
