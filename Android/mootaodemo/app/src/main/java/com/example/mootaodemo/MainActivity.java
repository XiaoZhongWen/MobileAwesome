package com.example.mootaodemo;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.view.View;

import com.example.mootaodemo.fragment.FindFragment;
import com.example.mootaodemo.fragment.IndexFragment;
import com.example.mootaodemo.fragment.MeFragment;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void tabClick(View v) {
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        switch (v.getId()) {
            case R.id.index:
                transaction.replace(R.id.container, new IndexFragment());
                break;
            case R.id.find:
                transaction.replace(R.id.container, new FindFragment());
                break;
            case R.id.mine:
                transaction.replace(R.id.container, new MeFragment());
                break;
        }
        transaction.commit();
    }
}