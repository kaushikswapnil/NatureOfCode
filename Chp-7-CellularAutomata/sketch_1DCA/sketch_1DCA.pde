CA ca;
int timeBetweenCompletionToReset = 5000; //in millis
int timeOfLastCompletion = 0;
boolean showcaseActive = false;

void setup()
{
  size(1200,700);
  background(0);
  
  int[] ruleset = {0, 1, 0, 1, 1, 0, 1, 0};
  
  ca = new CA(ruleset, 10);
}

void draw()
{  
  if (!ca.HasFinished())
  {
     ca.Display();
     ca.Update();
  }
  else
  {
     if (showcaseActive == false)
     {
       showcaseActive = true;
       timeOfLastCompletion = millis();
     }
     else if (millis() - timeOfLastCompletion > timeBetweenCompletionToReset)
     {
       showcaseActive = false;
       background(0);
       ca.CreateRandomRuleset();
       ca.Reset();
     } 
  }
}
