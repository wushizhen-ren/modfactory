package com.example;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.itemgroup.v1.ItemGroupEvents;
import net.minecraft.item.Item;
import net.minecraft.item.ItemGroups;
import net.minecraft.registry.Registries;
import net.minecraft.registry.Registry;
import net.minecraft.util.Identifier;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RubyThunderMod implements ModInitializer {
    public static final String MOD_ID = "rubythunder";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        LOGGER.info("Ruby & Thunder Mod initializing...");

        // Register items
        ModItems.register();
        // Register entities
        ModEntityTypes.register();

        LOGGER.info("Ruby & Thunder Mod initialized!");
    }
}
