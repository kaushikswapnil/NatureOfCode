class Circle extends WorldEntityImpl
{
  Circle(float centerX, float centerY, float radius)
  {
     super(radius*2, radius*2, centerX, centerY);
  }
  
  FixtureDef GetFixtureDefinition()
  {
    CircleShape circleShape = new CircleShape();
    float radius = ConvertScalarPixelsToPhysicWorldUnit(m_Dimensions.x/2);
    
    circleShape.m_radius = radius;
    
    FixtureDef fixDef = new FixtureDef();
    fixDef.shape = circleShape;
    fixDef.density = 1;
    fixDef.friction = 0.3;
    fixDef.restitution = 0.5;
     
    return fixDef;
  }
  
  void Display()
  {
    Vec2 pos = GetPhysicWorld().getBodyPixelCoord(m_Body);
    
    pushMatrix();
    
    stroke(0);
    fill(175);
    
    translate(pos.x, pos.y);
    
    ellipse(0, 0, m_Dimensions.x, m_Dimensions.x);
    
    popMatrix();
  }
}
