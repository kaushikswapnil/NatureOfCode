class Cell
{
   float m_PosX, m_PosY;
   float m_Width;
   int m_State;
   
   Cell(float posX, float posY, float cellwidth)
   {
      this(posX, posY, cellwidth, (int)random(2)); 
   }
   
   Cell(float posX, float posY, float cellwidth, int state)
   {
      m_PosX = posX;
      m_PosY = posY;
      m_Width = cellwidth;
      m_State = state;
   }
   
   void Display()
   {
      if (m_State == 1)
      {
         stroke(0);
         fill(255);
         rect(m_PosX, m_PosY, m_Width, m_Width);
      }
      else
      {
         stroke(255);
         fill(0);
         rect(m_PosX, m_PosY, m_Width, m_Width);
      }
   }
}
