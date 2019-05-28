class Button
{
  float m_PosX, m_PosY;
  float m_Width, m_Height;
  
  Button(float posX, float posY, float buttonWidth, float buttonHeight)
  {  
    m_PosX = posX;
    m_PosY = posY;
    
    m_Width = buttonWidth;
    m_Height = buttonHeight;
  }
  
  void Display()
  {
     rectMode(CORNER);
     stroke (0);
     fill(175);
     
     rect(m_PosX, m_PosY, m_Width, m_Height);
  }
  
  boolean IsPositionInsideButtonArea(float posX, float posY)
  {
    return (posX > m_PosX && posX < m_PosX + m_Width)
      && (posY > m_PosY && posY < m_PosY + m_Height);
  }
  
  void OnClicked()
  {
    
  }
}

class QuickTrainButton extends Button
{
  QuickTrainButton(float posX, float posY, float buttonWidth, float buttonHeight)
  {
    super(posX, posY, buttonWidth, buttonHeight);
  }
  
  void OnClicked()
  {
    pendingQuickTrain = true;
  }
}
