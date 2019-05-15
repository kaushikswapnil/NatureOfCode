class PathSegment
{
  PVector m_Start;
  PVector m_End;
  float m_Radius;
}

class Path
{
   PVector m_Start;
   PVector m_End;
   float m_Radius;
   
   Path()
   {
     float yComp = random(0, height);
     PVector start = new PVector(0, yComp);
     PVector end = new PVector(width, yComp);
     float radius = 10.0f;
     Init(start, end, radius);
   }
   
   Path(PVector start, PVector end, float radius)
   {
     Init(start, end, radius);
   }
   
   void Init(float radius)
   {
     float yComp = random(0, height);
     PVector start = new PVector(0, yComp);
     PVector end = new PVector(width, yComp);
     Init(start, end, radius);
   }
   
   void Init(PVector start, PVector end, float radius)
   {
     m_Start = start;
     m_End = end;
     m_Radius = radius;
   }
   
   PVector GetPathDirection()
   {
      PVector pathVector = PVector.sub(m_End, m_Start);
      pathVector.normalize();
      return pathVector;
   }
   
   PVector GetNormalVectorToPathCenter(PVector fromPos)
   {
     PVector pathVector = GetPathDirection();
     
     PVector relDisplacementToPosFromStart = PVector.sub(fromPos, m_Start);
     
     PVector normalPointRelToPath = pathVector.copy();
     normalPointRelToPath.mult(PVector.dot(pathVector, relDisplacementToPosFromStart));
     
     PVector normalPoint = PVector.add(normalPointRelToPath, m_Start);
     
     PVector normalVector = PVector.sub(normalPoint, fromPos);
     
     return normalVector;
   }
   
   float GetShortestDistanceToPathCenter(PVector fromPos)
   {
     return GetNormalVectorToPathCenter(fromPos).mag();
   }
   
   boolean IsPositionInsidePath(PVector position)
   {
     return (GetShortestDistanceToPathCenter(position) - m_Radius) <= 0.0f; 
   }
   
   void Display()
   {
     strokeWeight(m_Radius*2);
     stroke(200);
     line(m_Start.x, m_Start.y, m_End.x, m_End.y);
     strokeWeight(1);
     stroke(255);
     line(m_Start.x, m_Start.y, m_End.x, m_End.y);
   }
}
