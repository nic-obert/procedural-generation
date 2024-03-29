


final void keyPressed()
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
   case 'b':
     shownMap = Map.biomeMap;
     break;
   case 't':
     shownMap = Map.temperatureMap;
     break;
   case 'o':
     shownMap = Map.humidityMap;
     break;
   case 'm':
     shownMap = Map.finalMap;
     break;
     
   default:
     return;
 }
 
 generateWorld();
}


final void mouseClicked()
{
 if (mouseButton == LEFT)
 {
   switch (shownMap)
      {
        case heightMap:
          println("Height: " + heightMap[mouseX][mouseY]);
          break;
        case temperatureMap:
          println("Temperature: " + temperatureMap[mouseX][mouseY]);
          break;
        case humidityMap:
          println("Humidity: " + humidityMap[mouseX][mouseY]);
          break;
        case biomeMap:
          println("Biome: " + biomeMap[mouseX][mouseY].name + "\tHeight: " + heightMap[mouseX][mouseY] + "\tTemperature: " + temperatureMap[mouseX][mouseY] + "\tHumidity: " + humidityMap[mouseX][mouseY]);
          break;
          
        default:
          return;
      }
   
 }
}


final void mouseWheel(MouseEvent event) 
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
         
        default:
          return;
      }
    
  }
  
  generateWorld();
}
