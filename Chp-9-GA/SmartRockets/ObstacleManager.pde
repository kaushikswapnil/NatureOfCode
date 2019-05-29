class ObstacleManager
{
   ArrayList<Obstacle> m_Obstacles;
   
   ObstacleManager()
   {
      m_Obstacles = new ArrayList<Obstacle>(); 
   }
   
   void AddNewObstacle(PVector position, PVector dimensions)
   {
      m_Obstacles.add(new Obstacle(position, dimensions, 0)); 
   }
   
   void DisplayObstacles()
   {
      for (Obstacle obstacle : m_Obstacles)
      {
         obstacle.Display(); 
      }
   }
   
   ArrayList<Obstacle> GetObstacles()
   {
      return m_Obstacles; 
   }
}
