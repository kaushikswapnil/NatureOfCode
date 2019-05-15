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
 
 float m_WB_CircleCenterDistance;
 float m_WB_CircleRadius;
 float m_MaxWanderForce;
 
 float m_PathLookAheadFactor;
 
 PVector m_Color;
 
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
   m_WB_CircleCenterDistance = 20.0f;
   m_WB_CircleRadius = 10.0f;
   m_PathLookAheadFactor = 25.0f;
   
   m_Color = new PVector(random(0,255), random(0,255), random(0,255));
 }
 
 Vehicle(PVector position, PVector velocity, PVector acceleration, PVector dimensions, float maxSpeed, float maxSteerForce, float mass, float slowdownDistance, float wanderCircleCenterDistance, float wanderCircleRadius)
 {
   m_Position = position; 
   m_Velocity = velocity; 
   m_Acceleration = acceleration; 
   m_Dimensions = dimensions; 
   m_MaxSpeed = maxSpeed;
   m_MaxSteerForce = maxSteerForce;
   m_Mass = mass;
   
   m_SlowdownDistance = slowdownDistance;
   
   m_WB_CircleCenterDistance = wanderCircleCenterDistance;
   m_WB_CircleRadius = wanderCircleRadius;
   
   m_PathLookAheadFactor = 25.0f;

   m_Color = new PVector(random(0,255), random(0,255), random(0,255));
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
 
 void Wander()
 {
     PVector circleCenterVector = m_Velocity.get();
     circleCenterVector.normalize();
     circleCenterVector.mult(m_WB_CircleCenterDistance);
     
     PVector relativeDisplacementForWanderPoint = new PVector(1.0f, 0.0f);
     float randomRotationAngle = map(random(0, 1), 0.0f, 1.0f, 0.0f, 2 * PI);
     relativeDisplacementForWanderPoint.rotate(randomRotationAngle);
     relativeDisplacementForWanderPoint.mult(m_WB_CircleRadius);
     
     PVector displacementForWanderPoint = PVector.add(relativeDisplacementForWanderPoint, m_Position);
     
     Seek(displacementForWanderPoint);
 }
 
 void FollowFlow(FlowField flowField)
 {
   PVector desiredVelocity = flowField.GetFlowDirectionAt(m_Position);
   desiredVelocity.mult(m_MaxSpeed);
   
   PVector desiredLocation = PVector.add(desiredVelocity, m_Position);
   
   Seek(desiredLocation);
 }
 
 void FollowPath(Path path)
 {
   PVector predictedPos = m_Velocity.copy();
   predictedPos.normalize();
   predictedPos.mult(m_PathLookAheadFactor); //Look ahead 
   predictedPos.add(m_Position);
   
   if (!path.IsPositionInsidePath(predictedPos))
   {
     PVector normalToPath = path.GetNormalVectorToPathCenter(predictedPos);
     
     PVector pathDirection = path.GetPathDirection();
     
     PVector targetToSeek = PVector.add(predictedPos, normalToPath);
     targetToSeek.add(pathDirection.mult(m_PathLookAheadFactor));
     
     Seek(targetToSeek);
     
     if (isDebugModeOn)
     {
       PVector normalPointPos = PVector.add(normalToPath, predictedPos);
       stroke(255, 0, 0);
       line (predictedPos.x, predictedPos.y, normalPointPos.x, normalPointPos.y);
       stroke(0, 255, 0);
       line (predictedPos.x, predictedPos.y, targetToSeek.x, targetToSeek.y); 
     }
   }
 }
 
 void ApplyForce(PVector force)
 {
   PVector resultantAcceleration = PVector.div(force, m_Mass);
    m_Acceleration.add(resultantAcceleration); 
 }
 
 void Update()
 {
   PhysicsUpdate();
   WrapAroundWalls();
 }
 
 void Display()
 {     
    float theta = m_Velocity.heading() + PI/2;
    stroke(0);
    fill(m_Color.x, m_Color.y, m_Color.z);
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
 
 void PhysicsUpdate()
 {
   m_Velocity.add(m_Acceleration);
   m_Position.add(m_Velocity);
   
   m_Acceleration.mult(0);
 }
 
 void TurnAwayFromWalls()
 {
   //Turn away from walls
   float wallTurnDistanceOffset = 0.0f;
   if (m_Position.x > (width - m_Dimensions.x - wallTurnDistanceOffset))
   {
      m_Position.x = (width - m_Dimensions.x - wallTurnDistanceOffset);
   }
   else if (m_Position.x - m_Dimensions.x - wallTurnDistanceOffset < 0.0f)
   {
     m_Position.x = m_Dimensions.x + wallTurnDistanceOffset;
   }
   
   if (m_Position.y > (height - m_Dimensions.y - wallTurnDistanceOffset)) 
   {
     m_Position.y = (height - m_Dimensions.y - wallTurnDistanceOffset);
   }
   else if (m_Position.y - m_Dimensions.y - wallTurnDistanceOffset < 0.0f)
   {
     m_Position.y = m_Dimensions.y + wallTurnDistanceOffset;
   }
 }
 
 void WrapAroundWalls()
 {
   if (m_Position.x > (width + m_Dimensions.x))
   {
      m_Position.x = - m_Dimensions.x;
   }
   else if (m_Position.x - m_Dimensions.x < 0.0f)
   {
     m_Position.x = width + m_Dimensions.x;
   }
   
   if (m_Position.y > (height + m_Dimensions.y)) 
   {
     m_Position.y = -m_Dimensions.y; //<>//
   } //<>//
   else if (m_Position.y - m_Dimensions.y < 0.0f)
   {
     m_Position.y = height + m_Dimensions.y;
   }
 }
}
