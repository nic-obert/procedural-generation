

static final int speed = 70;

int xPos = 0;
int yPos = 0;

enum Map {heightMap, biomeMap, temperatureMap, humidityMap, finalMap};
Map shownMap = Map.heightMap;

float fluctuation = 0;

// generation parameters

float scale =               0.005f;

float MAX_FLUCTUATION =     0f;


static final int MAX_HEIGHT =   255;

float TEMPERATURE_INCREMENT =   0.3f;
int MAX_TEMPERATURE_HEIGHT   =  140;
int DEFAULT_TEMPERATURE =       20;
float TEMPERATURE_SCALE = 0.001f;

float HUMIDITY_TEMPERATURE =    1.3f;
float HUMIDITY_HIGH_TEMP =      23f;
float HUMIDITY_LOW_TEMP =       2f;
float HUMIDITY_HEIGHT =         0.2f;
float HUMIDITY_SCALE =          0.003f;


// end  of gneration parameters



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
