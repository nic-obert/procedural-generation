

final void draw()
{
  drawMap(); //<>// //<>//
}


final void generateWorld()
{
  generateHeight();
  //generateHumidity(); // commented out for optimization
  
}


final void drawMap() 
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      color col;
      switch (shownMap)
      {
        case heightMap:
          col = heightMap[x][y];
          break;
          
        case temperatureMap:
          col = temperatureColor(temperatureMap[x][y]);
          break;
        
        case humidityMap:
          col = humidityColor(humidityMap[x][y]);
          break;
          
        case biomeMap:
          col = biomeMap[x][y].col;
          break;
         
        default:
          col = #E513C3;
      }
      
      stroke(col);
      point(x, y);
    }
  }
}


final void generateHumidity()
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      float humidityNoise = noise((x + xPos) * HUMIDITY_SCALE, (y + yPos) * HUMIDITY_SCALE) * 100 - 50;
      float temp = temperatureMap[x][y];
      if (temp > HUMIDITY_HIGH_TEMP)
      {
        temp -= temp - HUMIDITY_HIGH_TEMP;
      }
      else if (temp < HUMIDITY_LOW_TEMP)
      {
        temp += HUMIDITY_LOW_TEMP - temp;
      }
      humidityMap[x][y] = humidityNoise + temp * HUMIDITY_TEMPERATURE;
    }
  }
}


final float calculateHumidity(int x, int y, float temp)
{
  float humidityNoise = noise(x * HUMIDITY_SCALE, y * HUMIDITY_SCALE) * 100 - 50;

  if (temp > HUMIDITY_HIGH_TEMP)
    temp -= temp - HUMIDITY_HIGH_TEMP;
  else if (temp < HUMIDITY_LOW_TEMP)
    temp += HUMIDITY_LOW_TEMP - temp;
  
  return humidityNoise + temp * HUMIDITY_TEMPERATURE;
}


final void generateHeight()
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      
      //float value = noise((x + xPos + fluctuation) * scale, (y + yPos + fluctuation) * scale);
      float value = noise((x + xPos) * scale, (y + yPos) * scale);
      
      int h = round(map(value, 0f, 1f, 0, MAX_HEIGHT));
      heightMap[x][y] = h;
            
      float temp = calculateTemperature(x + xPos, y + yPos, h);
      float humidity = calculateHumidity(x + xPos, y + yPos, temp);
      
      temperatureMap[x][y] = temp;
      humidityMap[x][y] = humidity;
      
      biomeMap[x][y] = calculateBiome(h, temp, humidity);
      
    }
  }
  
}


final float calculateTemperature(int x, int y, int h)
{
  float tempNoise = noise(x * TEMPERATURE_SCALE, y * TEMPERATURE_SCALE) * 100 - 50;
    
  return DEFAULT_TEMPERATURE - abs(h - MAX_TEMPERATURE_HEIGHT) * TEMPERATURE_INCREMENT + tempNoise;
  
}

