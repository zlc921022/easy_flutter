package com.eflagcomm.android;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        findViewById(R.id.add).setOnClickListener(v -> {
            Intent intent = new Intent(this, FlutterActivity.class);
            intent.putExtra("initParam", "你好，flutter，我是原生native");
            startActivity(intent);
        });
    }
}
