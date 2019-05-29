class Obstacle
{
  PVector m_Position;
  PVector m_Dimensions;
  int m_ShapeType; //0 = rect, 1 = ellipse
  
  Obstacle(PVector position, PVector dimensions, int shapeType)
  {  
    m_Position = position;
    m_Dimensions = dimensions;
    m_ShapeType = shapeType;
  }
  
  boolean IsPointInside(PVector point)
  {
     return (point.x > m_Position.x && point.x < m_Position.x + m_Dimensions.x)
       && (point.y > m_Position.y && point.y < m_Position.y + m_Dimensions.y);
  }
  
  void Display()
  {
     stroke (0);
     fill(175);
    
     switch (m_ShapeType)
     {
        case 0: //rect
        rectMode(CORNER);
        rect(m_Position.x, m_Position.y, m_Dimensions.x, m_Dimensions.y);
        break;
        
        case 1: //ellipse
        ellipse(m_Position.x, m_Position.y, m_Dimensions.x, m_Dimensions.y);
        break;
     }
  }
}
