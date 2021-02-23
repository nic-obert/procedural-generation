

static enum BaseBiome
{
  Abyss,
  Ocean,
  Shore,
  Plains,
  Hills,
  Mountains
};

final int BASE_BIOMES = 6;

final HashMap<BaseBiome, String[]> BiomeVariants = new HashMap<BaseBiome, String[]>(BASE_BIOMES);

final void initBiomes()
{
  BiomeVariants.put(BaseBiome.Abyss, new String[]{
    "Abyss"});
  BiomeVariants.put(BaseBiome.Ocean, new String[]{
    "Ocean"});
  BiomeVariants.put(BaseBiome.Shore, new String[]{
    "Snowy Shore", "Sandy Shore"});
  BiomeVariants.put(BaseBiome.Plains, new String[]{
    "Fire Lands", "Grass Lands", "Forest Plains"});
  BiomeVariants.put(BaseBiome.Hills, new String[]{
    "Forest Hills", "Naked Hills"});
  BiomeVariants.put(BaseBiome.Mountains, new String[]{
    "Snowy Mountains", "Volcano", "Rocky Mountains"});
}


final color abyssMap(int x, int y)
{
 return #110155;
}


final color oceanMap(int x, int y)
{
 return #1014DE; 
}


final color shoreMap(int x, int y)
{
  return 0;
}
