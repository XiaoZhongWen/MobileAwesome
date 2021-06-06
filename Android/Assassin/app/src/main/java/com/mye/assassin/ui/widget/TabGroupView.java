package com.mye.assassin.ui.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.LinearLayout;

import java.util.HashMap;
import java.util.List;

public abstract class TabGroupView extends LinearLayout {
    public TabGroupView(Context context) {
        super(context);
    }

    public TabGroupView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public TabGroupView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    private HashMap<Integer, View> views;

    public void initView(List<TabItem> items) {
        if (items == null || items.size() == 0) {
            return;
        }
        if (views == null) {
            views = new HashMap<>();
        }
        for (TabItem item:items) {
            View view = createView(item);
            views.put(item.id, view);
            view.setTag(item);
            LayoutParams params = new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1);
            addView(view, params);
        }
    }

    protected abstract View createView(TabItem item);
}
