package com.example.client.renderer;

import com.example.DarkIronGolemEntity;
import com.example.client.model.DarkIronGolemEntityModel;
import net.minecraft.client.render.entity.EntityRendererFactory;
import net.minecraft.client.render.entity.MobEntityRenderer;
import net.minecraft.util.Identifier;

public class DarkIronGolemEntityRenderer extends MobEntityRenderer<DarkIronGolemEntity, DarkIronGolemEntityModel> {
    private static final Identifier TEXTURE = Identifier.of("rubythunder", "textures/entity/dark_iron_golem.png");

    public DarkIronGolemEntityRenderer(EntityRendererFactory.Context ctx) {
        super(ctx, new DarkIronGolemEntityModel(DarkIronGolemEntityModel.getTexturedModelData().createModel()), 0.5F);
    }

    @Override
    public Identifier getTexture(DarkIronGolemEntity entity) {
        return TEXTURE;
    }
}
