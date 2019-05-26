Perceptron percept;
PerceptronTrainer trainer;

PVector[] trainingPoints;

int trainingCounter = 0;

// Coordinate space
float xmin = -400;
float ymin = -100;
float xmax =  400;
float ymax =  100;

float f(float x)
{
  return (2*x) + 1;
}

void setup()
{
  size(500, 500);
  
  percept = new Perceptron(3, 0.01);
  trainer = new PerceptronTrainer(percept);
  
  trainingPoints = new PVector[2000];
  
  for (int iter = 0; iter < trainingPoints.length; ++iter)
  {
    float x = random(xmin, xmax);
    float y = random(ymin, ymax);
    
    int answer = 1;
    if (y < f(x))
    {
       answer = -1; 
    }
    
    trainingPoints[iter] = new PVector( x, y, answer);
  }
}

void draw()
{
  background(255);
  translate(width/2,height/2);
  
  // Draw the line
  strokeWeight(1);
  stroke(255, 0, 0);
  float x1 = xmin;
  float y1 = f(x1);
  float x2 = xmax;
  float y2 = f(x2);
  line(x1,y1,x2,y2);

  // Draw the line based on the current weights
  // Formula is weights[0]*x + weights[1]*y + weights[2] = 0
  stroke(0, 255, 0);
  //strokeWeight(1);
  x1 = xmin;
  y1 = (-percept.m_Weights[2] - percept.m_Weights[0]*x1)/percept.m_Weights[1];
  x2 = xmax;
  y2 = (-percept.m_Weights[2] - percept.m_Weights[0]*x2)/percept.m_Weights[1];
  line(x1,y1,x2,y2); 
  
  stroke(0);
  
  trainer.Train(trainingPoints[trainingCounter].x, trainingPoints[trainingCounter].y, (int)trainingPoints[trainingCounter].z); 
  
  trainingCounter = (trainingCounter + 1) % trainingPoints.length;
  
  for (int iter = 0; iter < trainingCounter; ++iter)
  {
    float[] inputs = new float[3];
    inputs[0] = trainingPoints[iter].x;
    inputs[1] = trainingPoints[iter].y;
    inputs[2] = trainingPoints[iter].z;
    int guess = percept.FeedForward(inputs);
    if (guess > 0) noFill();
    else           fill(0);
    
    ellipse(trainingPoints[iter].x, trainingPoints[iter].y, 8, 8);
  }
}
