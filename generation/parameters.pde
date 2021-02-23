

int speed = 70;

int xPos = 0;
int yPos = 0;

enum Map {heightMap, waterMap, biomeMap, temperatureMap, humidityMap, finalMap};
Map shownMap = Map.heightMap;

float fluctuation = 0;

// generation parameters

float scale =               0.005f;

float ABYSS_THRESHOLD =     0.6f;
float OCEAN_THRESHOLD =     1.1f;
float SHORE_THRESHOLD =     0.05f;
float PLAINS_THRESHOLD =    0.4f;
float HILLS_THRESHOLD =     0.6f;
float MOUNTAINS_THRESHOLD = 1.1f;

float MAX_FLUCTUATION =     0f;

int WATER_THRESHOLD =       130;

int MAX_HEIGHT =            255;

float TEMPERATURE_INCREMENT =   0.3f;
int MAX_TEMPERATURE_HEIGHT   =  140;
int DEFAULT_TEMPERATURE =       20;
float TEMPERATURE_OFFSET =      0.02f;

float HUMIDITY_TEMPERATURE =    1.3f;
float HUMIDITY_HEIGHT =         0.2f;


// end  of gneration parameters



final color waterMapColors[] = new color[]
{
  #1014DE, // blue
  #0AC621  // green
};


final color baseBiomeColor(BaseBiome biome)
{
  switch (biome)
  {
   case Abyss:
     return color(#110155); // dark blue
   case Ocean:
     return color(#1014DE); // blue
   case Shore:
     return color(#FFFF5D); // yellow
   case Plains:
     return color(#33FF15); // green
   case Hills:
     return color(#00520A); // dark green
   case Mountains:
     return color(#3E2302); // brown
   default:
     return color(0);
  }
}


// temperature = DEFAULT_TEMPERATURE - abs(h - MAX_TEMPERATURE_HEIGHT) * TEMPERATURE_INCREMENT;
final color temperatureColor(float temperature)
{
  return round(map(temperature, -10, 60, 0, 255));
}


final color humidityColor(float humidity)
{
  return round(map(humidity,
                    0, MAX_HEIGHT * HUMIDITY_HEIGHT + DEFAULT_TEMPERATURE * HUMIDITY_TEMPERATURE,
                    #0000ff, #000000));
}
