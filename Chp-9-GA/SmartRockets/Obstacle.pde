class Obstacle
{
  PVector m_Position;
  PVector m_Dimensions;
  
  Obstacle(PVector position, PVector dimensions)
  {  
    m_Position = position;
    m_Dimensions = dimensions;
  }
  
  boolean IsPointInside(PVector point)
  {
     return (point.x > m_Position.x && point.x < m_Position.x + m_Dimensions.x)
       && (point.y > m_Position.y && point.y < m_Position.y + m_Dimensions.y);
  }
  
  void Display()
  {
     rectMode(CORNER);
     stroke (0);
     fill(175);
     
     rect(m_Position.x, m_Position.y, m_Dimensions.x, m_Dimensions.y);
  }
}
