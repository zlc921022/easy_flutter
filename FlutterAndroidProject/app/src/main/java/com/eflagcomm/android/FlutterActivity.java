package com.eflagcomm.android;

import android.os.Bundle;
import android.view.Gravity;
import android.widget.FrameLayout;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

/**
 * <p>{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-14
 */
public class FlutterActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter);
        String initParam = getIntent().getStringExtra("initParam");
        FrameLayout frameLayout = findViewById(R.id.frame_layout);
        FlutterView flutterView = Flutter.createView(
                this,
                getLifecycle(),
                initParam
        );
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT);
        params.gravity = Gravity.CENTER;
        frameLayout.addView(flutterView, params);
    }
}
