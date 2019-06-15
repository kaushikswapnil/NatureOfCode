interface IWorldEntity
{
   void CreateBody(float posX, float posY);
   void KillBody();
   
   BodyDef GetBodyDefinition(float posX, float posY);
   FixtureDef GetFixtureDefinition();
   Body GetPhysicBody();
   Vec2 GetDimensions();
   Vec2 GetPixelPosition();
   Vec2 GetPhysicWorldPosition();
   
   void Display();
}

class WorldEntityImpl implements IWorldEntity
{
    Body m_Body;
    Vec2 m_Dimensions;
    
    WorldEntityImpl(float entityDimensionX, float entityDimensionY, float posX, float posY)
    {
      m_Dimensions = new Vec2(entityDimensionX, entityDimensionY);
      
      CreateBody(posX, posY);
    }
    
    void CreateBody(float posX, float posY)
    {
       m_Body = GetPhysicWorld().createBody(GetBodyDefinition(posX, posY));
       
       m_Body.createFixture(GetFixtureDefinition());
    }
    
    void KillBody()
    {
       GetPhysicWorld().destroyBody(m_Body); 
    }
    
    BodyDef GetBodyDefinition(float posX, float posY)
    {
       BodyDef bodyDef = new BodyDef();
       bodyDef.type = BodyType.DYNAMIC;
       bodyDef.position.set(GetPhysicWorld().coordPixelsToWorld(posX, posY));
       
       return bodyDef;
    }
    
    FixtureDef GetFixtureDefinition()
    {
       PolygonShape ps = new PolygonShape();
       
       float shapeWidth = ConvertScalarPixelsToPhysicWorldUnit(m_Dimensions.x/2);
       float shapeHeight = ConvertScalarPixelsToPhysicWorldUnit(m_Dimensions.y/2);
       
       ps.setAsBox(shapeWidth, shapeHeight);
     
       FixtureDef fixDef = new FixtureDef();
       fixDef.shape = ps;
       fixDef.density = 1;
       fixDef.friction = 0.3;
       fixDef.restitution = 0.5;
       
       return fixDef;
    }
    
   Body GetPhysicBody()
   {
     return m_Body; 
   }
   
   Vec2 GetDimensions() 
   {
     return m_Dimensions;  
   }
   
   Vec2 GetPixelPosition()
   {
     return GetPhysicWorld().getBodyPixelCoord(m_Body); 
   }
   
   Vec2 GetPhysicWorldPosition()
   {
     return GetPhysicWorld().getBodyPixelCoord(m_Body); //FIXTHIS 
   }
   
   void Display()
   {
    Vec2 pos = GetPhysicWorld().getBodyPixelCoord(m_Body);
    float angle = m_Body.getAngle();
    
    pushMatrix();
    
    stroke(0);
    fill(175);
    
    translate(pos.x, pos.y);
    rotate(-angle);
    
    rectMode(CENTER);
    rect(0, 0, m_Dimensions.x, m_Dimensions.y);
    
    popMatrix();
   }
}
