package com.example.client;

import com.example.RubyThunderMod;
import com.example.ModEntityTypes;
import com.example.client.model.DarkIronGolemEntityModel;
import com.example.client.renderer.DarkIronGolemEntityRenderer;
import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.rendering.v1.EntityRendererRegistry;
import net.minecraft.client.render.entity.EntityRendererFactory;

public class RubyThunderModClient implements ClientModInitializer {
    @Override
    public void onInitializeClient() {
        EntityRendererRegistry.register(ModEntityTypes.DARK_IRON_GOLEM, DarkIronGolemEntityRenderer::new);
        RubyThunderMod.LOGGER.info("Client renderers registered");
    }
}
