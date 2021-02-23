
static color map[][];
static BaseBiome baseBiomeMap[][];
static boolean waterMap[][];
static int heightMap[][];
static float humidityMap[][];
static float temperatureMap[][];


final void settings()
{
  size(500, 500);
  noSmooth();
  //frameRate(5);
}


final void setup()
{
  
  map = new color[width][height];
  baseBiomeMap = new BaseBiome[width][height];
  waterMap = new boolean[width][height];
  heightMap = new int[width][height];
  humidityMap = new float[width][height];
  temperatureMap = new float[width][height];
  
  initBiomes();
  
  generateWorld();
}
