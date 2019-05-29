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
    boolean isPointInside = false;
    
    switch(m_ShapeType)
    {
       case 0:
       isPointInside = (point.x > m_Position.x && point.x < m_Position.x + m_Dimensions.x)
       && (point.y > m_Position.y && point.y < m_Position.y + m_Dimensions.y);
       break;
       
       case 1:
       {
          float equationForPointInsideEllipse = ((sq((point.x - m_Position.x))/sq(m_Dimensions.x/2)) //We divide the dimensions by 2, because when drawing ellipses in processing, the total height and width of ellipse are used
           + (sq((point.y - m_Position.y))/sq(m_Dimensions.y/2)));
          
          isPointInside = (equationForPointInsideEllipse <= 1);
       }
       break;
       
    }
     return isPointInside;
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
