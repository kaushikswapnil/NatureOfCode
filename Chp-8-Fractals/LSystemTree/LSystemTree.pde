LSystem lSystem;
Turtle turtle;

int numGen = 5;

void setup()
{
   size(400, 400);
  
   Rule[] ruleset = new Rule[1];
   ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
   
   lSystem = new LSystem("F", ruleset);
   lSystem.PrintCurrentGeneration();
   
   turtle = new Turtle(lSystem.GetCurrentSentence(), 10, 0.3);

   background(0);
}

void draw()
{
   stroke(255);
   strokeWeight(10);
   for (int iter = 0; iter < numGen; ++iter)
   {
      lSystem.Generate();
      lSystem.PrintCurrentGeneration();
      turtle.Render();
   }
   
   noLoop();
}
