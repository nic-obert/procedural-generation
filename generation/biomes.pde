

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
  BiomeVariants.put(BaseBiome.Abyss, new String[]{});
  BiomeVariants.put(BaseBiome.Ocean, new String[]{});
  BiomeVariants.put(BaseBiome.Shore, new String[]{});
  BiomeVariants.put(BaseBiome.Plains, new String[]{});
  BiomeVariants.put(BaseBiome.Hills, new String[]{});
  BiomeVariants.put(BaseBiome.Mountains, new String[]{});
}
