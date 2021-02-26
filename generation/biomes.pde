



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
  public final color col;
  
  
  public Biome(String name, Range heightRange, Range tempRange, Range humidityRange, color col)
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
  new Biome("Abyss",          new Range(0, 39),           new Range(0, 50),                             new Range(-10, Float.MAX_VALUE),              #090140),
  new Biome("Ocean",          new Range(40, 129),         new Range(0, 50),                             new Range(-10, Float.MAX_VALUE),              #2107D8),
  new Biome("IceLands",       new Range(0, 170),          new Range(-Float.MAX_VALUE, 0),               new Range(-Float.MAX_VALUE, Float.MAX_VALUE), #75FCF2),
  new Biome("Shore",          new Range(130, 135),        new Range(0, 50),                             new Range(-Float.MAX_VALUE, 50),              #C7CE00),
  new Biome("SnowyShore",     new Range(130, 135),        new Range(-Float.MAX_VALUE, 0),               new Range(-Float.MAX_VALUE, Float.MAX_VALUE), #EDFCA8),
  new Biome("Plains",         new Range(135, 169),        new Range(0, 50),                             new Range(10, 50),                            #40D115),
  new Biome("FireLands",      new Range(135, 169),        new Range(50, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 30),              #E57307),
  new Biome("Forest",         new Range(140, 169),        new Range(0, 25),                             new Range(5, 30),                             #128B03),
  new Biome("Tundra",         new Range(140, 169),        new Range(-10, 0),                            new Range(5, Float.MAX_VALUE),                #745F4E),
  new Biome("Desert",         new Range(135, 169),        new Range(30, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 5),               #CBB848),
  new Biome("GrassyHills",    new Range(170, 189),        new Range(5, 25),                             new Range(5, 30),                             #2E7612),
  new Biome("ForestyHills",   new Range(170, 189),        new Range(5, 30),                             new Range(0, 30),                             #1B5504),
  new Biome("MuddyHills",     new Range(170, 189),        new Range(0, 40),                             new Range(0, 50),                             #984319),
  new Biome("DryHills",       new Range(170, 189),        new Range(10, 40),                            new Range(-Float.MAX_VALUE, 0),               #C6950A),
  new Biome("SnowyHills",     new Range(170, 189),        new Range(-Float.MAX_VALUE, 0),               new Range(0, Float.MAX_VALUE),                #1FA27C),
  new Biome("DesertDunes",    new Range(170, 189),        new Range(30, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 0),               #7E7109),
  new Biome("Volcano",        new Range(170, MAX_HEIGHT), new Range(30, Float.MAX_VALUE),               new Range(-Float.MAX_VALUE, 35),              #AF1109),
  new Biome("RockyMountains", new Range(180, MAX_HEIGHT), new Range(-Float.MAX_VALUE, 30),              new Range(-Float.MAX_VALUE, 40),              #43100D),
  new Biome("IceMountains",   new Range(180, MAX_HEIGHT), new Range(-Float.MAX_VALUE, 0),               new Range(5, Float.MAX_VALUE),                #5B6A63),
  new Biome("None",           new Range(0, MAX_HEIGHT),   new Range(-Float.MAX_VALUE, Float.MAX_VALUE), new Range(-Float.MAX_VALUE, Float.MAX_VALUE), #E513C3),
  new Biome("Swamp",          new Range(130, 150),        new Range(0, 35),                             new Range(40, Float.MAX_VALUE),               #052403),
  new Biome("DryLands",       new Range(0, 140),          new Range(0, 40),                             new Range(-Float.MAX_VALUE, -10),             #834C10),
  new Biome("Savannah",       new Range(135, 169),        new Range(20, 50),                            new Range(-10, 10),                           #767618),
};


final Biome calculateBiome(int h, float temp, float humidity)
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

 
 
 
 
 
