class Rule
{
   char m_A;
   String m_B;
   
   Rule(char a, String b)
   {
      m_A = a;
      m_B = b;
   }
   
   char GetA()
   {
      return m_A; 
   }
   
   String GetB()
   {
      return m_B;
   }
}
