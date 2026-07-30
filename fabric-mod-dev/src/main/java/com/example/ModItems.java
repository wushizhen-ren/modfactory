package com.example;

import net.fabricmc.fabric.api.itemgroup.v1.ItemGroupEvents;
import net.minecraft.item.Item;
import net.minecraft.item.ItemGroups;
import net.minecraft.item.SwordItem;
import net.minecraft.item.ToolMaterials;
import net.minecraft.registry.Registries;
import net.minecraft.registry.Registry;
import net.minecraft.util.Identifier;

public class ModItems {
    public static final Item THUNDER_SWORD = new SwordItem(
        ToolMaterials.DIAMOND,
        new Item.Settings()
    );

    public static void register() {
        Registry.register(Registries.ITEM,
            Identifier.of(RubyThunderMod.MOD_ID, "thunder_sword"),
            THUNDER_SWORD);

        ItemGroupEvents.modifyEntriesEvent(ItemGroups.COMBAT).register(entries -> {
            entries.add(THUNDER_SWORD);
        });
    }
}
