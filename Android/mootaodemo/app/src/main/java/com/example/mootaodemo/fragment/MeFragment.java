package com.example.mootaodemo.fragment;

import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.VerifiedInputEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import com.example.mootaodemo.R;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link MeFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class MeFragment extends Fragment {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public MeFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment MeFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static MeFragment newInstance(String param1, String param2) {
        MeFragment fragment = new MeFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_me, container, false);

        ListView listView = view.findViewById(R.id.menu_listview);

        ArrayList list = new ArrayList();
        String[] txts = {"我的订单", "我的口令", "我的收藏", "我的锦囊", "我的设置", "安全中心"};
        int[] icons = {R.mipmap.list_my_menu, R.mipmap.list_pwd, R.mipmap.list_save, R.mipmap.list_my, R.mipmap.list_setting, R.mipmap.list_safe_center};
        for (int i = 0; i < txts.length; i++) {
            Map<String, Object> map = new HashMap<>();
            map.put("img", icons[i]);
            map.put("txt", txts[i]);
            list.add(map);
        }

        String[] from = {"img", "txt"};
        int[] to = {R.id.menu_item_img, R.id.menu_item_txt};

        SimpleAdapter simpleAdapter = new SimpleAdapter(getContext(), list, R.layout.me_menu_item, from, to);
        listView.setAdapter(simpleAdapter);

        return view;
    }
}