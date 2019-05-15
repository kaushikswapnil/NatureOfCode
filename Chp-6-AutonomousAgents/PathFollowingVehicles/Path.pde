class PathSegment
{
  PVector m_Start;
  PVector m_End;
  float m_Radius;
  
  PathSegment(PVector start, PVector end, float radius)
  {
     m_Start = start;
     m_End = end;
     m_Radius = radius;
  }
  
  PVector GetPathSegmentDirection()
   {
      PVector pathVector = PVector.sub(m_End, m_Start);
      pathVector.normalize();
      return pathVector;
   }
   
   PVector GetNormalVectorToPathSegment(PVector fromPos)
   {
     PVector pathVector = GetPathSegmentDirection();
     
     PVector relDisplacementToPosFromStart = PVector.sub(fromPos, m_Start);
     
     PVector normalPointRelToPath = pathVector.copy();
     normalPointRelToPath.mult(PVector.dot(pathVector, relDisplacementToPosFromStart));
     
     PVector normalPoint = PVector.add(normalPointRelToPath, m_Start);
     
     PVector normalVector = PVector.sub(normalPoint, fromPos);
     
     return normalVector;
   }
   
   float GetPerpendicularDistanceToPathSegment(PVector fromPos)
   {
     return GetNormalVectorToPathSegment(fromPos).mag();
   }
   
   PVector GetClosestPointOnPathSegment(PVector fromPos)
   {
     PVector closestPoint;
     
     PVector normalVector = GetNormalVectorToPathSegment(fromPos);
     PVector normalPoint = PVector.add(normalVector, fromPos);
     
     if (IsPositionOnPathSegment(normalPoint))
     {
       closestPoint =  normalPoint;
     }
     else
     {
       PVector distanceToStart = PVector.sub(m_Start, fromPos);
       PVector distanceToEnd = PVector.sub(m_Start, fromPos);
       
       if (distanceToStart.mag() < distanceToEnd.mag())
       {
         closestPoint = m_Start.copy();
       }
       else
       {
         closestPoint = m_End.copy(); 
       }
     }
     
     return closestPoint;
   }
   
   boolean IsPositionOnPathSegment(PVector position)
   {
     PVector positionRelToStart = PVector.sub(position, m_Start);
     
     PVector positionRelToStartDirection = positionRelToStart.copy();
     positionRelToStartDirection.normalize();
     
     PVector pathVector = PVector.sub(m_End, m_Start);
     PVector pathDirection = pathVector.copy();
     pathDirection.normalize();
     
     return ((PVector.angleBetween(positionRelToStartDirection, pathDirection) == 0.0f)
             && (positionRelToStart.mag() <= pathVector.mag()));
   }
   
   boolean IsPositionInsidePathSegmentArea(PVector position)
   {
     return (PVector.sub(GetClosestPointOnPathSegment(position), position).mag() - m_Radius) <= 0.0f; //If the distance between closest point on path and position is less than radius, position is inside path
   }
   
   void Display()
   {
     float diameter = m_Radius*2;
     strokeWeight(diameter);
     stroke(200);
     line(m_Start.x, m_Start.y, m_End.x, m_End.y);
     strokeWeight(1);
     stroke(255);
     line(m_Start.x, m_Start.y, m_End.x, m_End.y);
     fill(0,255,0);
     ellipse(m_Start.x, m_Start.y, diameter, diameter);
     fill(0,0,255);
     ellipse(m_End.x, m_End.y, diameter, diameter);
   }
}

class Path
{   
   ArrayList<PathSegment> m_PathSegments;
   
   Path()
   {
     //float yComp = random(0, height);
     //PVector start = new PVector(0, yComp);
     //PVector end = new PVector(width, yComp);
     m_PathSegments = new ArrayList<PathSegment>();
     
     PVector start = new PVector(random(0, width), random(0, height));
     PVector end = new PVector(random(0, width), random(0, height));
     float radius = 10.0f;
     Init(start, end, radius);
   }
   
   Path(PVector start, PVector end, float radius)
   {
     m_PathSegments = new ArrayList<PathSegment>();
     
     Init(start, end, radius);
   }
   
   void Init(ArrayList<PVector> points, float radius)
   {
      if (points.size() >= 1)
      {
        int iter = 0;
      
        do
        {
           PVector start = points.get(iter);
           PVector end = points.get(iter+1);
           
           m_PathSegments.add(new PathSegment(start, end, radius));
           
           ++iter;
        }
        while(iter < points.size() - 1);
      }
      else
      {
        Init(radius); 
      }
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
     ArrayList<PVector> points = new ArrayList<PVector>();
     points.add(start);
     points.add(end);
     Init(points, radius);
   }
   
   void Reset()
   {
     m_PathSegments.clear(); 
   }
   
   PVector GetPathDirectionOfClosestPathSegment(PVector fromPos)
   {
      int indexOfClosestPathSegment = GetIndexOfPathSegmentWithClosestPoint(fromPos);
      
      return m_PathSegments.get(indexOfClosestPathSegment).GetPathSegmentDirection();
   }
   
   PVector GetShortestNormalVectorToPath(PVector fromPos)
   {
     //Initialize closest normal and min distance to first path segment
     PVector shortestNormal = m_PathSegments.get(0).GetNormalVectorToPathSegment(fromPos);
     float minDistance = m_PathSegments.get(0).GetPerpendicularDistanceToPathSegment(fromPos);
     
     for (PathSegment segment : m_PathSegments)
     {
         if (minDistance > segment.GetPerpendicularDistanceToPathSegment(fromPos))
         {
           minDistance = segment.GetPerpendicularDistanceToPathSegment(fromPos);
           shortestNormal = segment.GetNormalVectorToPathSegment(fromPos);
         }
     }
     
     return shortestNormal;
   }
   
   float GetShortestPerpendicularDistanceToPath(PVector fromPos)
   {
     return GetShortestNormalVectorToPath(fromPos).mag();
   }
   
   int GetIndexOfPathSegmentWithClosestPoint(PVector fromPos)
   {
     //Initialize min distance to first path segment
     float minDistance = PVector.dist(m_PathSegments.get(0).GetClosestPointOnPathSegment(fromPos), fromPos);
     int indexOfPathSegmentWithClosestPoint = 0;
     
     for (int iter = 0; iter < m_PathSegments.size(); ++iter)
     {
         PVector closestPointToSegment = m_PathSegments.get(iter).GetClosestPointOnPathSegment(fromPos);
         if (minDistance > PVector.dist(closestPointToSegment, fromPos))
         {
           minDistance = PVector.dist(closestPointToSegment, fromPos);
           indexOfPathSegmentWithClosestPoint = iter;
         }
     }
     
     return indexOfPathSegmentWithClosestPoint;
   }
   
   PVector GetClosestPointOnPath(PVector fromPos)
   {
     //Initialize closest point and min distance to first path segment
     PVector closestPointToPath = m_PathSegments.get(0).GetClosestPointOnPathSegment(fromPos);
     float minDistance = PVector.dist(closestPointToPath, fromPos);
     
     for (int iter = 0; iter < m_PathSegments.size(); ++iter)
     {
         PVector closestPointToSegment = m_PathSegments.get(iter).GetClosestPointOnPathSegment(fromPos);
         if (minDistance > PVector.dist(closestPointToSegment, fromPos))
         {
           minDistance = PVector.dist(closestPointToSegment, fromPos);
           closestPointToPath = closestPointToSegment;
         }
     }
     
     return closestPointToPath;
   }
   
   boolean IsPositionOnPath(PVector position)
   {
     for (PathSegment segment : m_PathSegments)
     {
        if (segment.IsPositionOnPathSegment(position))
        {
           return true; 
        }
     }
     
     return false; //<>//
   }
   
   boolean IsPositionInsidePathArea(PVector position)
   {
     return m_PathSegments.get(GetIndexOfPathSegmentWithClosestPoint(position)).IsPositionInsidePathSegmentArea(position);
   }
   
   void AddPointToPath(PVector point)
   {
     PathSegment pathSegment = new PathSegment(m_PathSegments.get(m_PathSegments.size()-1).m_End, point, m_PathSegments.get(m_PathSegments.size()-1).m_Radius);
     m_PathSegments.add(pathSegment);
   }
   
   void Display()
   {
     for (PathSegment segment : m_PathSegments)
     {
        segment.Display();
     }
   }
}
