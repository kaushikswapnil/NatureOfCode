class Vehicle
{
 PVector m_Position;
 PVector m_Velocity;
 PVector m_Acceleration;
 PVector m_Dimensions; //Width, Height
 
 float m_MaxSpeed;
 float m_MaxSteerForce;
 float m_Mass;
 
 float m_SlowdownDistance;
 
 Vehicle()
 {
   m_Position = new PVector(0,0); 
   m_Velocity = new PVector(0,0); 
   m_Acceleration = new PVector(0,0); 
   m_Dimensions = new PVector(10,10); 
   m_MaxSpeed = 100.0f;
   m_MaxSteerForce = 10.0f;
   m_Mass = 2.0f;
   m_SlowdownDistance = 50.0f;
 }
 
 Vehicle(PVector position, PVector velocity, PVector acceleration, PVector dimensions, float maxSpeed, float maxSteerForce, float mass, float slowdownDistance)
 {
   m_Position = position; 
   m_Velocity = velocity; 
   m_Acceleration = acceleration; 
   m_Dimensions = dimensions; 
   m_MaxSpeed = maxSpeed;
   m_MaxSteerForce = maxSteerForce;
   m_Mass = mass;
   m_SlowdownDistance = slowdownDistance;
 }
 
 void Seek(PVector targetPosition)
 {
   PVector displacementToTarget = PVector.sub(targetPosition, m_Position);
   PVector desiredVelocity = displacementToTarget.get();
   desiredVelocity.normalize();
   
   float distanceToTarget = displacementToTarget.mag();
   
   if (distanceToTarget < m_SlowdownDistance)
   {
     float speed = map(distanceToTarget, 0.0f, m_SlowdownDistance, 0.0f, m_MaxSpeed);
     desiredVelocity.mult(speed);
   }
   else
   {
     desiredVelocity.mult(m_MaxSpeed);
   }
   
   PVector steeringForce = PVector.sub(desiredVelocity, m_Velocity);
   steeringForce.limit(m_MaxSteerForce);
   
   ApplyForce(steeringForce);
 }
 
 void ApplyForce(PVector force)
 {
   PVector resultantAcceleration = PVector.div(force, m_Mass);
    m_Acceleration.add(resultantAcceleration); 
 }
 
 void Update()
 {
   m_Velocity.add(m_Acceleration);
   m_Position.add(m_Velocity);
   
   m_Acceleration.mult(0);
 }
 
 void Display()
 {
    float theta = m_Velocity.heading() + PI/2;
    stroke(0);
    fill(175);
    //pushMatrix();
    //translate(m_Position.x, m_Position.y);
    //rotate(theta);
    //beginShape();
    //vertex(0, 2*m_Dimensions.x/3);
    //vertex(-m_Dimensions.x/3, -m_Dimensions.y/2);
    //vertex(-m_Dimensions.x/3, +m_Dimensions.y/2);
    //endShape();
    //popMatrix();
    ellipse(m_Position.x, m_Position.y, m_Dimensions.x, m_Dimensions.y);
 }
}
