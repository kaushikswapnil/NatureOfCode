class KochLine
{
   PVector m_Start;
   PVector m_End;
   
   KochLine(PVector start, PVector end)
   {
      m_Start = start;
      m_End = end;
   }
   
   PVector GetPathVector()
   {
      return PVector.sub(m_End, m_Start); 
   }
   
   void Display()
   {
      line(m_Start.x, m_Start.y, m_End.x, m_End.y); 
   }
   
   PVector GetA()
   {
      return m_Start.get();
   }
   
   PVector GetB()
   {
      PVector path = GetPathVector();
      path.div(3);
      return PVector.add(path, m_Start);
   }
   
   PVector GetC()
   {
     PVector locator = m_Start.get();
     PVector path = GetPathVector();
          
     path.div(3); //Set the size to 1/3
     locator.add(path); //Move to new point
     
     path.rotate(-radians(60));
     
     locator.add(path); //Moving to point C
     
     return locator;
   }
   
   PVector GetD()
   {
      PVector path = GetPathVector();
      path.mult(2/3.0f);
      return PVector.add(path, m_Start);
   }
   
   PVector GetE()
   {
      return m_End.get(); 
   }
}
