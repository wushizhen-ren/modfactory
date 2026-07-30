package com.example.client.model;

import net.minecraft.client.model.*;
import net.minecraft.client.render.VertexConsumer;
import net.minecraft.client.render.entity.model.EntityModel;
import net.minecraft.client.util.math.MatrixStack;
import com.example.DarkIronGolemEntity;

public class DarkIronGolemEntityModel extends EntityModel<DarkIronGolemEntity> {
    private final ModelPart root;

    public DarkIronGolemEntityModel(ModelPart root) {
        this.root = root.getChild("body");
    }

    public static TexturedModelData getTexturedModelData() {
        ModelData modelData = new ModelData();
        ModelPartData modelPartData = modelData.getRoot();
        modelPartData.addChild("body",
            ModelPartBuilder.create()
                .uv(0, 0)
                .cuboid(-7.0F, -14.0F, -4.0F, 14.0F, 25.0F, 8.0F),
            ModelTransform.NONE
        );
        return TexturedModelData.of(modelData, 128, 64);
    }

    @Override
    public void setAngles(DarkIronGolemEntity entity, float limbAngle, float limbDistance, float animationProgress, float headYaw, float headPitch) {
    }

    @Override
    public void render(MatrixStack matrices, VertexConsumer vertexConsumer, int light, int overlay, int color) {
        root.render(matrices, vertexConsumer, light, overlay, color);
    }
}
