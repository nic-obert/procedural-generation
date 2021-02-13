

float map[][];
int biomeMap[][];
boolean waterMap[][];
int heightMap[][];

int speed = 70;

int xPos = 0;
int yPos = 0;

enum Map {heightMap, waterMap, biomeMap};
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





void draw()
{
  drawMap();
}


void setup()
{
  size(500, 500);
  map = new float[width][height];
  biomeMap = new int[width][height];
  waterMap = new boolean[width][height];
  heightMap = new int[width][height];
  
  noSmooth();
  frameRate(5);
  
  generateWorld();
}


void generateWorld()
{
  generateHeight();
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
         
        default:
          col = 0;
      }
      
      stroke(col);
      point(x, y);
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
      
      
      waterMap[x][y] = h > WATER_THRESHOLD;
      
      //fluctuation += random(-MAX_FLUCTUATION, MAX_FLUCTUATION);      
    }
  }
  
}
