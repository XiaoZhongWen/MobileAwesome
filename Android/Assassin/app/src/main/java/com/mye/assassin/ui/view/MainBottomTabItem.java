package com.mye.assassin.ui.view;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.mye.assassin.R;
import com.mye.assassin.ui.widget.TabItem;

public class MainBottomTabItem extends RelativeLayout {

    private ImageView tabImage;
    private ImageView redIv;
    private TextView tabText;
    private TabItem.AnimationDrawableBean mAnimationDrawable;

    public MainBottomTabItem(Context context) {
        super(context);
        initView();
    }

    public MainBottomTabItem(Context context, AttributeSet attrs) {
        super(context, attrs);
        initView();
    }

    public MainBottomTabItem(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initView();
    }

    private void initView() {
        View view = View.inflate(getContext(), R.layout.item_tab, this);
        tabImage = view.findViewById(R.id.iv_tab_img);
        redIv = view.findViewById(R.id.iv_red);
        tabText = view.findViewById(R.id.tv_tab_text);
    }

    public void setAnimationDrawable(TabItem.AnimationDrawableBean animationDrawableBean) {
        this.mAnimationDrawable = animationDrawableBean;
        setDrawable(mAnimationDrawable.drawableNormal);
    }

    public void setName(String name) {
        this.tabText.setText(name);
    }

    public void setDrawable(int drawable) {
        tabImage.setImageResource(drawable);
    }
}
