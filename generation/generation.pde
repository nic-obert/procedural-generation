


final void draw()
{
  drawMap(); //<>//
}


final void generateWorld()
{
  generateHeight();
  generateHumidity();
  divideBaseBiomes();
  divideBiomes();
}


final void divideBiomes()
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      
      color col;
      
      switch (baseBiomeMap[x][y])
      {
        case Abyss:
          col = abyssMap(x, y);
          break;
        case Ocean:
          col = abyssMap(x, y);
          break;
        case Shore:
          col = abyssMap(x, y);
          break;
        case Plains:
          col = abyssMap(x, y);
          break;
        case Hills:
          col = abyssMap(x, y);
          break;
        case Mountains:
          col = abyssMap(x, y);
          break;
        default:
          col = 0;
          break;
      }
      
      map[x][y] = col;
            
    }
  }
  
}


final void divideBaseBiomes()
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      float value = noise((x + xPos) * scale, (y + yPos) * scale);
      BaseBiome biome = BaseBiome.Abyss; // not an actual initialization
      
      if (!waterMap[x][y])
      {
        value = map(value, 0f, ((float)WATER_THRESHOLD / MAX_HEIGHT), 0f, 1f);
        
        if (value < ABYSS_THRESHOLD)
          biome = BaseBiome.Abyss;
        else if (value < OCEAN_THRESHOLD)
          biome = BaseBiome.Ocean;
      }
      else
      {   
        value = map(value, ((float)WATER_THRESHOLD / MAX_HEIGHT), 1f, 0f, 1f);
        
        if (value < SHORE_THRESHOLD) 
          biome = BaseBiome.Shore;
        else if (value < PLAINS_THRESHOLD)
          biome = BaseBiome.Plains;
        else if (value < HILLS_THRESHOLD)
          biome = BaseBiome.Hills;
        else if (value < MOUNTAINS_THRESHOLD)
          biome = BaseBiome.Mountains;
      }
      
      baseBiomeMap[x][y] = biome ;
    }
  }
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
          
        case waterMap:
          if (heightMap[x][y] < WATER_THRESHOLD)
            col = waterMapColors[0];
          else
            col = waterMapColors[1];
          break;
          
        case biomeMap:
          col = baseBiomeColor(baseBiomeMap[x][y]);
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


final void generateHumidity()
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
      
      temperatureMap[x][y] = calculateTemperature(x + xPos, y + yPos, h);
      
      waterMap[x][y] = h > WATER_THRESHOLD;
            
    }
  }
  
}



final float calculateTemperature(int x, int y, int h)
{
  float tempNoise = noise(x * TEMPERATURE_OFFSET * scale, y * TEMPERATURE_OFFSET * scale) * 100 - 50;
  
  int xMod = x % 1000;
  int yMod = y % 1000;
  if (xMod > 500 || yMod > 500)
  {
    if (xMod > 250)
      xMod = 500 - xMod;
    if (yMod > 250)
      yMod = 500 - yMod;
    tempNoise += 0.02 * (xMod + yMod);
  }
  else
  {
    xMod -= 500;
    yMod -= 500;
    
    if (xMod > 250)
      xMod = 500 - xMod;
    if (yMod > 250)
      yMod = 500 - yMod;
      
    tempNoise -= 0.02 * (xMod + yMod);
  }
    
  return DEFAULT_TEMPERATURE - abs(h - MAX_TEMPERATURE_HEIGHT) * TEMPERATURE_INCREMENT + tempNoise;
  
}
