class FlowField
{
   PVector[][] m_Field;
   int m_Columns, m_Rows;
   int m_Resolution;
   
   FlowField()
   {
      m_Resolution = 10;
      m_Columns = width/m_Resolution;
      m_Rows = height/m_Resolution;
      
      m_Field = new PVector[m_Columns][m_Rows];
   }
   
   FlowField(int resolution)
   {
      m_Resolution = resolution;
      m_Columns = width/m_Resolution;
      m_Rows = height/m_Resolution;
      
      m_Field = new PVector[m_Columns][m_Rows];
   }
   
   void Init()
   {
      noiseSeed((int)random(10000));
      float xOffset = 0.0f;
      for (int colIter = 0; colIter < m_Columns; ++colIter)
      {
        float yOffset = 0.0f;
        for (int rowIter = 0; rowIter < m_Rows; ++rowIter)
        {
          float theta = map(noise(xOffset, yOffset), 0, 1, 0, TWO_PI);
          m_Field[colIter][rowIter] = new PVector(cos(theta), sin(theta));
          yOffset += 0.1;
        }
        xOffset += 0.1;
      }
   }
   
   PVector GetFlowDirectionAt(PVector position)
   {
      return GetFlowDirectionAt(position.x, position.y); 
   }
   
   PVector GetFlowDirectionAt(float x, float y)
   {
      int col = constrain((int)(x/m_Resolution), 0 , m_Columns - 1); 
      int row = constrain((int)(y/m_Resolution), 0 , m_Rows - 1);
      
      return m_Field[col][row].copy();
   }
   
   void Display()
   {
     for (int colIter = 0; colIter < m_Columns; ++colIter)
      {
        for (int rowIter = 0; rowIter < m_Rows; ++rowIter)
        {
          pushMatrix();
          translate(colIter*m_Resolution, rowIter*m_Resolution);
          stroke(255, 150);
          PVector flowVector = m_Field[colIter][rowIter];
          rotate(flowVector.heading());
          line(0, 0, flowVector.mag()*(m_Resolution - 2), 0);
          popMatrix();
        }
      }
   }
}
