

enum BaseBiome
{
  Abyss,
  Ocean,
  Shore,
  Plains,
  Hills,
  Mountains
};

static int BASE_BIOMES = 6;

HashMap<BaseBiome, String[]> BiomeVariants = new HashMap<BaseBiome, String[]>(BASE_BIOMES);

void initBiomes()
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
