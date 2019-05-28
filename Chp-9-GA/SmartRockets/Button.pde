class Button
{
  PVector m_Position;
  PVector m_Dimensions;
  
  Button(PVector position, PVector dimensions)
  {  
    m_Position = position;
    m_Dimensions = dimensions;
  }
  
  void Display()
  {
     rectMode(CORNER);
     stroke (0);
     fill(175);
     
     rect(m_Position.x, m_Position.y, m_Dimensions.x, m_Dimensions.y);
  }
  
  void OnClicked()
  {
    
  }
}

class QuickTrainButton extends Button
{
  QuickTrainButton(PVector position, PVector dimensions)
  {
    super(position, dimensions);
  }
  
  void OnClicked()
  {
    
  }
}
