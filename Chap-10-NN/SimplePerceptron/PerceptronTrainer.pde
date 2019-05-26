class PerceptronTrainer
{
   Perceptron m_Perceptron;
  
   PerceptronTrainer(Perceptron perceptron)
   {
      m_Perceptron = perceptron; 
   }
  
   void Train(float x, float y, int desiredResult)
   {
     float[] inputs = new float[3];
     inputs[0] = x;
     inputs[1] = y;
     inputs[2] = 1; //bias
     m_Perceptron.Train(inputs, desiredResult);
   }
}
