package com.example.borrowbook;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.SeekBar;
import android.widget.ToggleButton;

import com.example.borrowbook.model.Food;
import com.example.borrowbook.model.Person;

import java.util.ArrayList;

public class OrderActivity extends AppCompatActivity {

    private EditText mInputNameEditText;
    private RadioGroup mSexRadioGroup;
    private CheckBox mHotCheckBox;
    private CheckBox mSourCheckBox;
    private CheckBox mSeaFoodCheckBox;
    private SeekBar mPriceSeekBar;
    private Button mSearchBtn;
    private ToggleButton mToggleButton;
    private ImageView mFoodImageView;
    private ArrayList<Food> mFoods;
    private Person mPerson;
    private ArrayList<Food> mResultFood;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order);

        // 初始化控件
        findViews();

        // 初始化数据
        initData();

        // 添加监听
        setListeners();
    }

    private void initData() {
        mFoods = new ArrayList<Food>();
        mFoods.add(new Food("麻辣香锅", "55.0", R.drawable.malaxiangguo, true, false, false));
        mFoods.add(new Food("水煮鱼", "48.0", R.drawable.shuizhuyu, true, true, false));
        mFoods.add(new Food("麻辣火锅", "80.0", R.drawable.malahuoguo, true, true, false));
        mFoods.add(new Food("清蒸鲈鱼", "68.0", R.drawable.qingzhengluyu, false, true, false));
        mFoods.add(new Food("桂林米粉", "15.0", R.drawable.guilin, false, false, false));
        mFoods.add(new Food("上汤娃娃菜", "28.0", R.drawable.wawacai, false, false, false));
        mFoods.add(new Food("红烧肉", "60.0", R.drawable.hongshaorou, false, false, false));
        mFoods.add(new Food("木须肉", "40.0", R.drawable.muxurou, false, false, false));
        mFoods.add(new Food("酸菜牛肉面", "35.0", R.drawable.suncainiuroumian, false, false, true));
        mFoods.add(new Food("西芹炒百合", "38.0", R.drawable.xiqin, false, false, false));
        mFoods.add(new Food("酸辣汤", "40.0", R.drawable.suanlatang, true, false, true));

        mPerson = new Person();
        mResultFood = new ArrayList<Food>();
    }

    private void findViews() {
        mInputNameEditText = findViewById(R.id.input_name_edit_text);
        mSexRadioGroup = findViewById(R.id.sex_radio_group);
        mHotCheckBox = findViewById(R.id.hot_check_box);
        mSourCheckBox = findViewById(R.id.sour_check_box);
        mSeaFoodCheckBox = findViewById(R.id.seafood_check_box);
        mPriceSeekBar = findViewById(R.id.price_seek_bar);
        mSearchBtn = findViewById(R.id.search_btn);
        mFoodImageView = findViewById(R.id.food_imageView);
        mToggleButton = findViewById(R.id.food_toggle_btn);
        mToggleButton.setChecked(true);
        mPriceSeekBar.setProgress(30);
    }

    private void setListeners() {
        mSexRadioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {

            }
        });

        mHotCheckBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

            }
        });

        mSourCheckBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

            }
        });

        mSeaFoodCheckBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {

            }
        });

        mPriceSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {

            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        mSearchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });

        mToggleButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
    }
}