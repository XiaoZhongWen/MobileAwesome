package com.mye.assassin;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentTransaction;

import android.app.Fragment;
import android.os.Bundle;
import android.view.View;
import android.widget.RadioButton;

import com.mye.assassin.fragment.MeFragment;
import com.mye.assassin.fragment.MessageFragment;
import com.mye.assassin.fragment.ShareFragment;
import com.mye.assassin.fragment.WorkFragment;

public class MainActivity extends AppCompatActivity {

    private MessageFragment messageFragment;
    private ShareFragment shareFragment;
    private WorkFragment workFragment;
    private MeFragment meFragment;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.messageFragment = new MessageFragment();
        this.shareFragment = new ShareFragment();
        this.workFragment = new WorkFragment();
        this.meFragment = new MeFragment();

        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        transaction.add(R.id.container, this.messageFragment);
        transaction.commit();
    }

    public void onTabClick(View view) {
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        switch (view.getId()) {
            case R.id.tab_message:
                transaction.replace(R.id.container, this.messageFragment);
                break;
            case R.id.tab_share:
                transaction.replace(R.id.container, this.shareFragment);
                break;
            case R.id.tab_work:
                transaction.replace(R.id.container, this.workFragment);
                break;
            case R.id.tab_me:
                transaction.replace(R.id.container, this.meFragment);
                break;
        }
        transaction.commit();
    }
}