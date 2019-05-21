LSystem lSystem;
Turtle turtle;

int numGen = 5;

void setup()
{
   size(800, 800);
  
   Rule[] ruleset = new Rule[1];
   ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
   
   lSystem = new LSystem("F", ruleset);
   
   turtle = new Turtle(lSystem.GetCurrentSentence(), 10, 0.3);

   background(0);
   
   frameRate(1);
}

void draw()
{
   background(0);
   stroke(255);
   translate(width/2, height);
   rotate(-PI/2);
   lSystem.Generate();
   turtle.SetTodo(lSystem.GetCurrentSentence());
   turtle.Render();
}
