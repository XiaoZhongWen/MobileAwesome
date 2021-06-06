package com.mye.assassin.ui.widget;

import android.graphics.drawable.Drawable;

public class TabItem {
    public enum Type {
        BUTTON,
        CHECKBOX,
        RADIOBUTTON
    }

    public static class AnimationDrawableBean {
        public int drawableNormal;
        public int drawableAnimation;

        public AnimationDrawableBean(int drawableNormal, int drawableAnimation) {
            this.drawableNormal = drawableNormal;
            this.drawableAnimation = drawableAnimation;
        }
    }

    public int id;
    public int tag;
    public int drawable;
    public int width;
    public int height;
    public int top;
    public int bottom;
    public int left;
    public int right;
    public String text;
    public Type type;
    public AnimationDrawableBean animationDrawableBean;
}
