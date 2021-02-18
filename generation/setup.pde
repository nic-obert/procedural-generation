
float map[][];
int biomeMap[][];
boolean waterMap[][];
int heightMap[][];
float humidityMap[][];
float temperatureMap[][];


void settings()
{
  size(500, 500);
  noSmooth();
  //frameRate(5);
}


void setup()
{
  
  map = new float[width][height];
  biomeMap = new int[width][height];
  waterMap = new boolean[width][height];
  heightMap = new int[width][height];
  humidityMap = new float[width][height];
  temperatureMap = new float[width][height];
  
  initBiomes();
  
  generateWorld();
}
