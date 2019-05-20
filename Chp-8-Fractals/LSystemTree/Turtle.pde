//Back to old school turtle graphics
//F: line(0,0,0,len); translate(0,len);
//G: translate(0,len);
//+: rotate(angle);
//-: rotate(-angle);
//[: pushMatrix();
//]: popMatrix();

class Turtle
{
   String m_Todo;
   float m_DrawLength;
   float m_Angle;
   
   Turtle(String todo, float drawLength, float angle)
   {
      m_Todo = todo;
      m_DrawLength = drawLength;
      m_Angle = angle;
   }
   
   void SetTodo(String todo)
   {
      m_Todo = todo; 
   }
   
   void SetDrawLength(float drawLength)
   {
      m_DrawLength = drawLength; 
   }
   
   void SetAngle(float angle)
   {
      m_Angle = angle; 
   }
   
   void Render()
   {
      for (int iter = 0; iter < m_Todo.length(); ++iter)
      {
         switch (m_Todo.charAt(iter))
         {
            case 'F':
            line(0, 0, m_DrawLength, 0);
            case 'G':
            translate(m_DrawLength, 0);
            break;
            
            case '+':
            rotate(m_Angle);
            break;
            
            case '-':
            rotate(-m_Angle);
            break;
            
            case '[':
            pushMatrix();
            break;
            
            case ']':
            popMatrix();
            break;
            
            default:
            break;
         }
      }
   }
}
