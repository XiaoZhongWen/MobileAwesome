package com.mye.assassin.ui.activity;

import android.os.Bundle;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.viewpager2.widget.ViewPager2;

import com.mye.assassin.R;
import com.mye.assassin.ui.BaseActivity;
import com.mye.assassin.ui.view.MainBottomTabGroupView;
import com.mye.assassin.ui.widget.TabItem;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends BaseActivity {

    private TextView tvTitle;
    private ImageButton btnMore;
    private RelativeLayout btnSearch;
    private ViewPager2 vpFragmentContainer;
    private MainBottomTabGroupView tabGroupView;

    public enum Tab {
        /**
         * 聊天
         */
        CHAT(0),

        /**
         * 联系人
         */
        CONTACT(1),

        /**
         * 发现
         */
        FIND(2),

        /**
         * 我的
         */
        Me(3);

        private int value;

        Tab(int value) {
            this.value = value;
        }

        public int getValue() {
            return this.value;
        }

        public static Tab getType(int value) {
            for (Tab type: Tab.values()) {
                if (type.value == value) {
                    return type;
                }
            }
            return null;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initView();
    }

    /**
     *  初始化布局
     */
    private void initView() {
        // 获取布局元素
        tvTitle = findViewById(R.id.tv_title);
        btnMore = findViewById(R.id.btn_more);
        btnSearch = findViewById(R.id.btn_search);
        vpFragmentContainer = findViewById(R.id.vp_main_container);
        tabGroupView = findViewById(R.id.tg_bottom_tabs);

        // 绑定事件

        // 初始化底部tabs
        initTabs();

        // 初始化ViewPager2的fragment
        initFragmentViewPager();

        // 设置当前选项为聊天界面
    }

    /**
     * 初始化Tabs
     */
    private void initTabs() {
        // 初始化Tab
        List<TabItem> list = new ArrayList<TabItem>();
        List<TabItem.AnimationDrawableBean> animationDrawableBeanList = new ArrayList<>();
        String[] tabNames = getResources().getStringArray(R.array.tab_names);
        int[] tabImages = {R.drawable.assassin_tab_chat_selector, R.drawable.assassin_tab_contacts_selector, R.drawable.assassin_tab_chatroom_selector, R.drawable.assassin_tab_me_selector};

        animationDrawableBeanList.add(new TabItem.AnimationDrawableBean(R.drawable.tab_chat_0, R.drawable.tab_chat_animation_list));
        animationDrawableBeanList.add(new TabItem.AnimationDrawableBean(R.drawable.tab_contacts_0, R.drawable.tab_contacts_animation_list));
        animationDrawableBeanList.add(new TabItem.AnimationDrawableBean(R.drawable.tab_chatroom_0, R.drawable.tab_chatroom_animation_list));
        animationDrawableBeanList.add(new TabItem.AnimationDrawableBean(R.drawable.tab_me_0, R.drawable.tab_me_animation_list));

        for (Tab tab: Tab.values()) {
            TabItem item = new TabItem();
            item.animationDrawableBean = animationDrawableBeanList.get(tab.value);
            item.id = tab.getValue();
            item.text = tabNames[tab.value];
            item.drawable = tabImages[tab.value];
            list.add(item);
        }
        tabGroupView.initView(list);

        // 绑定事件
    }

    /**
     * 初始化fragment
     */
    private void initFragmentViewPager() {

    }
}