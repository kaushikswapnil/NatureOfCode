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
   
   float m_RecordDistance;
   int m_RecordFinishTime;
   boolean m_HitTarget;
   
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
      
      m_RecordDistance = 10000; //Random high distance
      m_RecordFinishTime = 10000;
      m_HitTarget = false;
      
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
      
      m_RecordDistance = 10000; //Random high distance
      m_RecordFinishTime = 10000;
      m_HitTarget = false;
      
      m_Fitness = 0;
   }
   
   void Age()
   {
     ++m_Age; 
   }
   
   void Update()
   {
      if (IsAlive())
      {
        PhysicsUpdate();
        Age();
      }
      Display();
   }
   
   boolean IsAlive()
   {
      return m_Age < m_LifeTime; 
   }
   
   void PhysicsUpdate()
   {  
      PVector forceFromCurrentGene = m_DNA.m_Genes[m_Age].get();
      ApplyForce(forceFromCurrentGene);
      
      m_Velocity.add(m_Acceleration);
      m_Position.add(m_Velocity);
      
      m_Acceleration.mult(0);
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
   
   void UpdateTargetStatistics(PVector target)
   {
      float distToTarget = PVector.dist(target, m_Position);
      
      if (distToTarget < m_RecordDistance)
      {
         m_RecordDistance = distToTarget; 
         m_RecordFinishTime = m_Age;
      }
      
      if (distToTarget < 1)
      {
         m_HitTarget = true; 
      }
   }
   
   void EvaluateFitness(PVector targetLoc)
   {
       float fitness = PVector.dist(targetLoc, m_Position);
       
       fitness = pow(1/fitness,2);
     
       /*if (m_RecordDistance < 1)
       {
          m_RecordDistance = 1; 
       }
       
       float fitness = pow(1/m_RecordFinishTime*m_RecordDistance, 2);
       
     
       float distToTargetLoc = PVector.dist(targetLoc, m_Position);
       if (distToTargetLoc > m_RecordDistance)
       {
         fitness *= 0.6; //Reduce fitness if we have overshot at the end
       }
       
       if (m_HitTarget)
       {
         fitness *= 2; 
       }*/
       
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
