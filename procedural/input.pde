


void keyPressed()
{
 switch (key)
 {
   case 'w':
     yPos -= speed;
     break;
   case 's':
     yPos += speed;
     break;
   case 'a':
     xPos -= speed;
     break;
   case 'd':
     xPos += speed;
     break;
   case 'h':
     shownMap = Map.heightMap;
     break;
   case 'j':
     shownMap = Map.waterMap;
     break;
   case 'b':
     shownMap = Map.biomeMap;
     
   default:
     return;
 }
 
 generateWorld();
}


void mouseClicked()
{
 if (mouseButton == LEFT)
 {
   switch (shownMap)
      {
        case waterMap:
          if (waterMap[mouseX][mouseY])
            println("Land: " + heightMap[mouseX][mouseY]);
          else
            println("Water: " + heightMap[mouseX][mouseY]);
          break;
        case heightMap:
          println("Height: " + heightMap[mouseX][mouseY]);
          break;
        case biomeMap:
          println("Biome: " + biomes[biomeMap[mouseX][mouseY]]);
          break;
      }
   
 }
}


void mouseWheel(MouseEvent event) 
{
  float value = event.getCount();
 
  switch (keyCode)
  {
    case SHIFT:
      scale += value * 0.0005;
      if (scale <= 0)
        scale = 0.0005;
      println("Scale: " + scale);
      break;
    
    default:
      switch (key)
      {
        case 'f':
          MAX_FLUCTUATION += value * 0.0001;
          if (MAX_FLUCTUATION < 0)
            MAX_FLUCTUATION = 0;
          println("Max fluctuation: " + MAX_FLUCTUATION);
          break;
        case 'm':
          WATER_THRESHOLD += round(value);
          println("Water threshold: " + WATER_THRESHOLD);
          break;
         
        default:
          return;
      }
    
  }
  
  generateWorld();
}
