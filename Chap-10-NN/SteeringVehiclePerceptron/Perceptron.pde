class Perceptron
{
   float[] m_Weights;
   float m_LearningConstant;
   
   Perceptron(int numInputs, float learningConstant)
   {
      m_Weights = new float[numInputs]; 
      for (int iter = 0; iter < numInputs; ++iter)
      {
         m_Weights[iter] = random(-1, 1); 
      }
      
      m_LearningConstant = learningConstant;
   }
   
   int FeedForward(float[] inputs)
   {
      //#TODO FIX THIS
      inputs[2] = 1;
     
      float sum = 0;
      for (int iter = 0; iter < m_Weights.length; ++iter)
      {
          sum += inputs[iter] * m_Weights[iter];
      }
      
      return Activate(sum);
   }
   
   int Activate(float sumInputs)
   {
     if (sumInputs > 0)
     {
       return 1;
     }
     
     return -1;
   }
   
   void Train(float[] inputs, int desiredResult)
   {
      int guessedResult = FeedForward(inputs);
      
      int error = desiredResult - guessedResult;
      
      for (int iter = 0; iter < m_Weights.length; ++iter)
      {
         m_Weights[iter] += m_LearningConstant * inputs[iter] * error;
      }
   }
}
