

int speed = 70;

int xPos = 0;
int yPos = 0;

enum Map {heightMap, waterMap, biomeMap, temperatureMap, humidityMap};
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


// end  of gneration parameters



String biomes[] = new String[]
{
  "Abyss",
  "Ocean",
  "Shore",
  "Plains",
  "Hills",
  "Mountains"
};


color waterMapColors[] = new color[]
{
  #1014DE, // blue
  #0AC621  // green
};

color biomeColors[] = new color[]
{
  #110155, // dark blue
  #1014DE, // blue
  #DADE10, // yellow
  #0AC621, // green
  #00520A, // dark green
  #3E2302  // brown
};


// temperature = DEFAULT_TEMPERATURE - abs(h - MAX_TEMPERATURE_HEIGHT) * TEMPERATURE_INCREMENT;
color temperatureColor(float temperature)
{
  return round(map(temperature, 
                    DEFAULT_TEMPERATURE - max(MAX_HEIGHT - MAX_TEMPERATURE_HEIGHT, MAX_TEMPERATURE_HEIGHT) * TEMPERATURE_INCREMENT,
                    DEFAULT_TEMPERATURE, 
                    0, 255));
}
