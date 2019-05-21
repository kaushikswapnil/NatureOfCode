class KochFractal
{
  ArrayList<KochLine> m_Current;
  int m_Generation;
  
  KochFractal(ArrayList<KochLine> startingLines)
  {
     m_Current = startingLines; 
     m_Generation = 0;
  }
  
  KochFractal(PVector start, PVector end)
  {
     m_Current = new ArrayList<KochLine>(); 
     m_Current.add(new KochLine(start, end));
     m_Generation = 0;
  }
  
  void Display()
  {
     for (KochLine line : m_Current)
     {
        line.Display(); 
     }
  }
  
  void Generate()
  {  
     ArrayList<KochLine> newGeneration = new ArrayList<KochLine>(); 
    
     for (KochLine line : m_Current)
     {
       PVector lineA = line.GetA();
       PVector lineB = line.GetB();
       PVector lineC = line.GetC();
       PVector lineD = line.GetD();
       PVector lineE = line.GetE();

       newGeneration.add(new KochLine(lineA, lineB));
       newGeneration.add(new KochLine(lineB, lineC));
       newGeneration.add(new KochLine(lineC, lineD));
       newGeneration.add(new KochLine(lineD, lineE));
     }
     
     m_Current = newGeneration;
     
     ++m_Generation;
  }
}
