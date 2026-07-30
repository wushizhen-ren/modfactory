package com.example;

import net.minecraft.entity.EntityType;
import net.minecraft.entity.SpawnGroup;
import net.minecraft.registry.Registries;
import net.minecraft.registry.Registry;
import net.minecraft.util.Identifier;

public class ModEntityTypes {
    public static final EntityType<DarkIronGolemEntity> DARK_IRON_GOLEM = Registry.register(
        Registries.ENTITY_TYPE,
        Identifier.of(RubyThunderMod.MOD_ID, "dark_iron_golem"),
        EntityType.Builder.create(DarkIronGolemEntity::new, SpawnGroup.MISC)
            .dimensions(1.4F, 2.9F)
            .build("dark_iron_golem")
    );

    public static void register() {
        RubyThunderMod.LOGGER.info("Entity types registered");
    }
}
