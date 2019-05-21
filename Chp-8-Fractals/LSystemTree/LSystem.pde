//Back to old school turtle graphics
//Symbols
//F: Forward draw
//G: forward
//+: turn right
//-: turn left
//[: remember this state
//]: forget this state

class LSystem
{
   String m_Axiom;
   String m_CurrentSentence;
   
   int m_Generation;
   
   Rule[] m_Ruleset;
   
   LSystem(String axiom, Rule[] ruleset)
   {
      m_Axiom = axiom;
      m_CurrentSentence = axiom;
      m_Ruleset = ruleset;
      m_Generation = 0;
   }
   
   String GetCurrentSentence()
   {
      return m_CurrentSentence; 
   }
   
   void Generate()
   {
      StringBuffer nextSentence = new StringBuffer();
      
      for(int sentenceIter = 0; sentenceIter < m_CurrentSentence.length(); ++sentenceIter)
      {
         char c = m_CurrentSentence.charAt(sentenceIter);
         String replacement = "" + c; //If we dont match with any rule, replace by itself
         
         for (int ruleIter = 0; ruleIter < m_Ruleset.length; ++ruleIter)
         {
            if (c == m_Ruleset[ruleIter].GetA())
            {
               replacement = m_Ruleset[ruleIter].GetB(); 
               break;
            }
         }
         
         nextSentence.append(replacement);
      }
      
      m_CurrentSentence = nextSentence.toString();
      ++m_Generation;      
   }
   
   void PrintCurrentGeneration()
   {
      println("Generation " + (m_Generation) + ": " + m_CurrentSentence);
   }
}
