package com.eflagcomm.android;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        EditText etInput = findViewById(R.id.et_input);
        findViewById(R.id.open).setOnClickListener(v -> {
            Intent intent = new Intent(this, FlutterActivity.class);
            String s = etInput.getText().toString();
            intent.putExtra("initParam", TextUtils.isEmpty(s) ?
                    "你好，Flutter，我是native" : s);
            startActivity(intent);
        });
    }
}
