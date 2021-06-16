import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class generation extends PApplet {




public final void draw()
{
  drawMap(); //<>// //<>//
}


public final void generateWorld()
{
  generateHeight();
  //generateHumidity(); // commented out for optimization
  
}



public final void drawMap() 
{
  for (int x = 0; x != width; x++)
  {
    for (int y = 0; y != height; y++)
    {
      int col;
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
          col = 0xffE513C3;
      }
      
      stroke(col);
      point(x, y);
    }
  }
}


public final void generateHumidity()
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


public final float calculateHumidity(int x, int y, float temp)
{
  float humidityNoise = noise(x * HUMIDITY_SCALE, y * HUMIDITY_SCALE) * 100 - 50;
  if (temp > HUMIDITY_HIGH_TEMP)
  {
    temp -= temp - HUMIDITY_HIGH_TEMP;
  }
  else if (temp < HUMIDITY_LOW_TEMP)
  {
    temp += HUMIDITY_LOW_TEMP - temp;
  }
  return humidityNoise + temp * HUMIDITY_TEMPERATURE;
}


public final void generateHeight()
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



public final float calculateTemperature(int x, int y, int h)
{
  float tempNoise = noise(x * TEMPERATURE_SCALE, y * TEMPERATURE_SCALE) * 100 - 50;
    
  return DEFAULT_TEMPERATURE - abs(h - MAX_TEMPERATURE_HEIGHT) * TEMPERATURE_INCREMENT + tempNoise;
  
}




class Range
{
  public final float min;
  public final float max;
  
  public Range(float min, float max)
  {
    this.min = min;
    this.max = max;
  }
  
  public boolean fits(float value)
  {
    return min <= value && value <= max;
  }
};



class Biome
{
  
  public final String name;
  public final Range heightRange;
  public final Range tempRange;
  public final Range humidityRange;
  public final int col;
  
  
  public Biome(String name, Range heightRange, Range tempRange, Range humidityRange, int col)
  {
    this.name = name;
    this.heightRange = heightRange;
    this.tempRange = tempRange;
    this.humidityRange = humidityRange;
    this.col = col;
  }
  
};



final Biome[] biomes = new Biome[]
{
  //          name                  height                  temperature                                    humidity                                    color
  new Biome("Abyss",          new Range(0, 39),           new Range(-10, 50),                             new Range(-10, Float.MAX_VALUE),            0xff090140),
  new Biome("Ocean",          new Range(40, 129),         new Range(-10, 50),                             new Range(-10, Float.MAX_VALUE),             0xff2107D8),
  new Biome("IceLands",       new Range(0, 170),          new Range(-Float.MAX_VALUE, 0),               new Range(-Float.MAX_VALUE, Float.MAX_VALUE), 0xff75FCF2),
  new Biome("Shore",          new Range(130, 135),        new Range(0, 50),                             new Range(-Float.MAX_VALUE, 50),              0xffC7CE00),
  new Biome("SnowyShore",     new Range(130, 135),        new Range(-Float.MAX_VALUE, 0),               new Range(-Float.MAX_VALUE, Float.MAX_VALUE), 0xffEDFCA8),
  new Biome("Plains",         new Range(135, 169),        new Range(0, 50),                             new Range(0, 50),                             0xff40D115),
  new Biome("FireLands",      new Range(135, 169),        new Range(50, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 30),              0xffE57307),
  new Biome("Forest",         new Range(140, 169),        new Range(0, 25),                             new Range(5, 30),                             0xff128B03),
  new Biome("Tundra",         new Range(140, 169),        new Range(-10, 0),                            new Range(5, Float.MAX_VALUE),                0xff745F4E),
  new Biome("Desert",         new Range(135, 169),        new Range(30, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 5),               0xffCBB848),
  new Biome("GrassyHills",    new Range(160, 189),        new Range(5, 25),                             new Range(5, 30),                             0xff2E7612),
  new Biome("ForestyHills",   new Range(160, 189),        new Range(5, 30),                             new Range(0, 30),                             0xff1B5504),
  new Biome("MuddyHills",     new Range(170, 189),        new Range(0, 40),                             new Range(0, 50),                             0xff984319),
  new Biome("DryHills",       new Range(140, 189),        new Range(10, 40),                            new Range(-Float.MAX_VALUE, 0),               0xffC6950A),
  new Biome("SnowyHills",     new Range(170, 189),        new Range(-Float.MAX_VALUE, 0),               new Range(-Float.MAX_VALUE, Float.MAX_VALUE), 0xff1FA27C),
  new Biome("DesertDunes",    new Range(170, 189),        new Range(30, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 0),               0xff7E7109),
  new Biome("Volcano",        new Range(170, MAX_HEIGHT), new Range(30, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 35),              0xffAF1109),
  new Biome("RockyMountains", new Range(180, MAX_HEIGHT), new Range(-Float.MAX_VALUE, 30),              new Range(-Float.MAX_VALUE, 40),              0xff43100D),
  new Biome("IceMountains",   new Range(180, MAX_HEIGHT), new Range(-Float.MAX_VALUE, 0),               new Range(5, Float.MAX_VALUE),                0xff5B6A63),
  new Biome("Swamp",          new Range(130, 170),        new Range(0, 35),                             new Range(40, Float.MAX_VALUE),               0xff052403),
  new Biome("RainForest",     new Range(140, 180),        new Range(30, 40),                            new Range(40, Float.MAX_VALUE),               0xff324B28),
  new Biome("DryLands",       new Range(0, 150),          new Range(0, 40),                             new Range(-Float.MAX_VALUE, 0),               0xff834C10),
  new Biome("Savannah",       new Range(135, 169),        new Range(20, 50),                            new Range(-10, 10),                           0xff767618),
  new Biome("GeyserLand",     new Range(130, 170),        new Range(40, Float.MAX_VALUE),               new Range(40, Float.MAX_VALUE),               0xff3A3B55),
  
  new Biome("None",           new Range(0, MAX_HEIGHT),   new Range(-Float.MAX_VALUE, Float.MAX_VALUE), new Range(-Float.MAX_VALUE, Float.MAX_VALUE), 0xffE513C3),
};


public final Biome calculateBiome(int h, float temp, float humidity)
{
 for (Biome biome : biomes)
 {
   if (biome.heightRange.fits(h))
   {
     if (biome.tempRange.fits(temp))
     {
       if (biome.humidityRange.fits(humidity))
       {
         return biome; 
       }
     }
   }
 }
 
 throw new UnsupportedOperationException("No biome fits the following parameters: height: " + h + ", temperature: " + temp + ", humidity: " + humidity);
}

 
 
 
 
 



public final void keyPressed()
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


public final void mouseClicked()
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


public final void mouseWheel(MouseEvent event) 
{
  float value = event.getCount();
 
  switch (keyCode)
  {
    case SHIFT:
      scale += value * 0.0005f;
      if (scale <= 0)
        scale = 0.0005f;
      println("Scale: " + scale);
      break;
    
    default:
      switch (key)
      {
        case 'f':
          MAX_FLUCTUATION += value * 0.0001f;
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
public final int temperatureColor(float temperature)
{
  return round(map(temperature, -10, 60, 0, 255));
}


public final int humidityColor(float humidity)
{
  return round(map(humidity,
                    0, MAX_HEIGHT * HUMIDITY_HEIGHT + DEFAULT_TEMPERATURE * HUMIDITY_TEMPERATURE,
                    0xff0000ff, 0xff000000));
}

static int map[][];
static Biome biomeMap[][];
static int heightMap[][];
static float humidityMap[][];
static float temperatureMap[][];


public final void settings()
{
  size(500, 500);
  noSmooth();
  //frameRate(5);
}


public final void setup()
{
  
  map = new int[width][height];
  biomeMap = new Biome[width][height];
  heightMap = new int[width][height];
  humidityMap = new float[width][height];
  temperatureMap = new float[width][height];
    
  generateWorld();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "generation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
