import java.util.*;  

class Rocket
{
   PVector m_Position;
   PVector m_Velocity;
   PVector m_Acceleration;
   
   int m_Age;
   int m_LifeTime;
   
   float m_Fitness;
   
   DNA m_DNA;
   
   float m_RecordMinDistance;
   float m_RecordMaxDistance;
   int m_RecordMinTime;
   int m_RecordMaxTime;
   boolean m_HitTarget;
   boolean m_HitObstacle;
   
   Rocket(DNA dna)
   {
      this(new PVector(width/2, height), dna); 
   }
  
   Rocket(PVector position, DNA dna)
   {
      m_Position = position;
      m_DNA = dna;
      
      m_Velocity = new PVector(0, 0);
      m_Acceleration = new PVector(0, 0);
      
      m_Age = 0;
      m_LifeTime = m_DNA.m_Genes.length;
      
      m_RecordMinDistance = 10000; //Random high distance
      m_RecordMaxDistance = 0;
      m_RecordMinTime = 10000;
      m_RecordMaxTime = 10000;
      m_HitObstacle = m_HitTarget = false;
      
      m_Fitness = 0;
   }
   
   Rocket(PVector position, int dnaSequenceLength, float maxForce)
   {
      m_Position = position;
      m_DNA = new DNA(dnaSequenceLength, maxForce);
      
      m_Velocity = new PVector(0, 0);
      m_Acceleration = new PVector(0, 0);
      
      m_Age = 0;
      m_LifeTime = m_DNA.m_Genes.length;
      
      m_RecordMinDistance = 10000; //Random high distance
      m_RecordMaxDistance = 0;
      m_RecordMinTime = 10000;
      m_RecordMaxTime = 10000;
      m_HitObstacle = m_HitTarget = false;
      
      m_Fitness = 0;
   }
   
   void Age()
   {
     ++m_Age; 
   }
   
   void Update()
   {
      PhysicsUpdate();
      Display();
      Age();
   }
   
   void QuickUpdate()
   {
      PhysicsUpdate();
      Age();
   }
   
   boolean IsAlive()
   {
      return m_Age < m_LifeTime && !m_HitTarget && !m_HitObstacle; 
   }
   
   void PhysicsUpdate()
   {  
      if (IsAlive())
      {
        PVector forceFromCurrentGene = m_DNA.m_Genes[m_Age].get();
        ApplyForce(forceFromCurrentGene);
      
        m_Velocity.add(m_Acceleration);
        m_Position.add(m_Velocity);
      
        m_Acceleration.mult(0);
      }
   }
   
   void Display()
   {
    float theta = m_Velocity.heading2D() + PI/2;
    fill(200, 100);
    stroke(0);
    pushMatrix();
    translate(m_Position.x, m_Position.y);
    rotate(theta);
    
    float r = 10;
     
    // Thrusters
    rectMode(CENTER);
    fill(0);
    rect(-r/2, r*2, r/2, r);
    rect(r/2, r*2, r/2, r);

    // Rocket body
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    
    popMatrix();
   }
   
   void ApplyForce(PVector force)
   {
      m_Acceleration.add(force); 
   }
   
   void UpdateTargetStatistics(Obstacle target)
   {
      if (target.IsPointInside(m_Position))
      {
         m_HitTarget = true; 
      }
   }
   
   void UpdateObstacleStatistics(ArrayList<Obstacle> obstacles)
   {
     if (!m_HitObstacle)
     {
        for (Obstacle obstacle : obstacles)
        {
           if (obstacle.IsPointInside(m_Position))
           {
              m_HitObstacle = true;
              break;
           }
        }
     }
   }
   
   void EvaluateFitness()
   {
       if (m_RecordMinDistance < 1)
       {
          m_RecordMinDistance = 1; 
       }
      
       float fitnessDenom = (pow(m_RecordMinDistance,3) * pow(m_RecordMinTime,2));
       float fitnessNum = 1;
       float fitness = fitnessNum/fitnessDenom;
       
       if (m_HitTarget)
       {
          fitness *= 2; 
       }
       
       if (m_HitObstacle)
       {
          fitness *= 0.5; 
       }
       
       m_Fitness = fitness;
   }
   
   void Mutate(float mutationRate)
   {
      m_DNA.Mutate(mutationRate); 
   }
   
   Rocket Reproduce(Rocket otherParent)
   {
     DNA offspringDNA = m_DNA.Reproduce(otherParent.m_DNA);
     
     return new Rocket(offspringDNA);
   }
}

class RocketFitnessComparator implements Comparator<Rocket>
{
   int compare(Rocket r1, Rocket r2)
   {
      if (r1.m_Fitness > r2.m_Fitness)
      {
         return -1; 
      }
      else if (r1.m_Fitness == r2.m_Fitness)
      {
         return 0; 
      }
      else
      {
         return 1; 
      }
   }
}
