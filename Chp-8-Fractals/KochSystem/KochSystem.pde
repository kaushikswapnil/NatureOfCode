KochFractal koch;

void setup()
{
   size(800,800);
   
   ArrayList<KochLine> startingLines = new ArrayList<KochLine>();
   
   int numStartingLines = 3;
   float startingLineLength = 200.0f;

   PVector startingPoint = new PVector((width/2) - 100, height/2);
   
   PVector endingPointRelToStart = new PVector(1, 0);
   
   float internalAngleOfPolygon = PI - (TWO_PI/numStartingLines);
   endingPointRelToStart.rotate(-internalAngleOfPolygon/2);
   endingPointRelToStart.mult(startingLineLength);
   
   PVector endingPoint = PVector.add(startingPoint, endingPointRelToStart);
   
   for (int iter = 0; iter < numStartingLines; ++iter)
   {
     startingLines.add(new KochLine(startingPoint, endingPoint));
     
     endingPointRelToStart.rotate(PI - internalAngleOfPolygon);
     startingPoint = endingPoint.get();
     endingPoint = PVector.add(startingPoint, endingPointRelToStart);
   }

   koch = new KochFractal(startingLines);
   
   frameRate(1);
}

void draw()
{
   background(0);
   
   stroke(255);
   strokeWeight(2);
   
   koch.Display();
   koch.Generate();
}
