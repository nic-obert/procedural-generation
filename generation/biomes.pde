



class Range<T>
{
  public final T min;
  public final T max;
  
  public Range(T min, T max)
  {
    this.min = min;
    this.max = max;
  }
};



class Biome
{
  
  public final String name;
  public final Range<Integer> heightRange;
  public final Range<Float> tempRange;
  public final Range<Float> humidityRange;
  
  
  
  public Biome(String name, Range<Integer> heightRange, Range<Float> tempRange, Range<Float> humidityRange)
  {
    this.name = name;
    this.heightRange = heightRange;
    this.tempRange = tempRange;
    this.humidityRange = humidityRange;
  }
  
};



final Biome[] biomes = new Biome[]
{
  new Biome("Abyss", new Range<Integer>(0, 39), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("Ocean", new Range<Integer>(40, 129), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("IceLands", new Range<Integer>(40, 129), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("Shore", new Range<Integer>(130, 139), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("SnowyShore", new Range<Integer>(130, 139), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("Plains", new Range<Integer>(140, 169), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("FireLands", new Range<Integer>(140, 169), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("Forest", new Range<Integer>(140, 169), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("Tundra", new Range<Integer>(140, 169), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("Desert", new Range<Integer>(140, 169), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("GrassyHills", new Range<Integer>(170, 189), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("ForestyHills", new Range<Integer>(170, 189), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("DesertDunes", new Range<Integer>(170, 189), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("Volcano", new Range<Integer>(170, MAX_HEIGHT), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("RockyMountains", new Range<Integer>(190, MAX_HEIGHT), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("IceMountains", new Range<Integer>(190, MAX_HEIGHT), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),
  new Biome("None", new Range<Integer>(0, MAX_HEIGHT), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE), new Range<Float>(Float.MIN_VALUE, Float.MAX_VALUE)),

};

 
 
 
 
 
