


void draw()
{
  drawMap(); //<>//
}


void generateWorld()
{
  generateHeight();
  generateHumidity();
  divideBiomes();
}


void divideBiomes()
{
   for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      float value = noise((x + xPos) * scale, (y + yPos) * scale);
      int biome = 0;
      
      if (!waterMap[x][y])
      {
        value = map(value, 0f, ((float)WATER_THRESHOLD / MAX_HEIGHT), 0f, 1f);
        
        if (value < ABYSS_THRESHOLD)
          biome = 0; // abyss
        else if (value < OCEAN_THRESHOLD)
          biome = 1; // ocean
      }
      else
      {   
        value = map(value, ((float)WATER_THRESHOLD / MAX_HEIGHT), 1f, 0f, 1f);
        
        if (value < SHORE_THRESHOLD) 
          biome = 2; // shore
        else if (value < PLAINS_THRESHOLD)
          biome = 3; // plains
        else if (value < HILLS_THRESHOLD)
          biome = 4; // hills
        else if (value < MOUNTAINS_THRESHOLD)
          biome = 5; // mountains
      }
      
      biomeMap[x][y] = biome ;
    }
  }
}


void drawMap() 
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
          
        case waterMap:
          if (heightMap[x][y] < WATER_THRESHOLD)
            col = waterMapColors[0];
          else
            col = waterMapColors[1];
          break;
          
        case biomeMap:
          col = biomeColors[biomeMap[x][y]];
          break;
          
        case temperatureMap:
          col = temperatureColor(temperatureMap[x][y]);
          break;
        
        case humidityMap:
          col = humidityColor(humidityMap[x][y]);
          break;
         
        default:
          col = 0;
      }
      
      stroke(col);
      point(x, y);
    }
  }
}


void generateHumidity()
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      float humidityNoise = noise((x + xPos) * scale, (y + yPos) * scale);
      humidityMap[x][y] = humidityNoise + temperatureMap[x][y] * HUMIDITY_TEMPERATURE;
    }
  }
}


void generateHeight()
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      
      //float value = noise((x + xPos + fluctuation) * scale, (y + yPos + fluctuation) * scale);
      float value = noise((x + xPos) * scale, (y + yPos) * scale);
      
      int h = round(map(value, 0f, 1f, 0, MAX_HEIGHT));
      heightMap[x][y] = h;
      
      temperatureMap[x][y] = calculateTemperature(h);
      
      waterMap[x][y] = h > WATER_THRESHOLD;
            
      //fluctuation += random(-MAX_FLUCTUATION, MAX_FLUCTUATION);      
    }
  }
  
}


float calculateTemperature(int h)
{
  return DEFAULT_TEMPERATURE - abs(h - MAX_TEMPERATURE_HEIGHT) * TEMPERATURE_INCREMENT;
}
