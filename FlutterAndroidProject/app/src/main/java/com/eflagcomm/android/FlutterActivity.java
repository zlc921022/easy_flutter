package com.eflagcomm.android;

import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.eflagcomm.android.plugin.BasicMessageChannelPlugin;
import com.eflagcomm.android.plugin.EventChannelPlugin;
import com.eflagcomm.android.plugin.MethodChannelPlugin;

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
public class FlutterActivity extends AppCompatActivity implements IShowMessage {

    private EditText mInput;
    private RadioGroup mRadioGroup;
    private BasicMessageChannelPlugin mBasicMessageChannelPlugin;
    private EventChannelPlugin mEventChannelPlugin;
    private FlutterView mFlutterView;
    private TextView mReceiveMessage;
    private Button mBtnHandle;
    private MethodChannelPlugin mMethodChannelPlugin;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter);
        initView();
        initData();
        initListener();
    }

    private void initListener() {
        mInput.addTextChangedListener(new MyTextWatcher() {
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                switch (mRadioGroup.getCheckedRadioButtonId()) {
                    case R.id.rb_message_channel:
                        if (mBasicMessageChannelPlugin != null) {
                            mBasicMessageChannelPlugin.send(s.toString());
                        }
                        break;
                    case R.id.rb_event_channel:
                        if (mEventChannelPlugin != null) {
                            mEventChannelPlugin.sendEvent(s.toString());
                        }
                        break;
                    default:
                }
            }
        });
        mRadioGroup.setOnCheckedChangeListener((group, checkedId) -> {
            if (checkedId == R.id.rb_method_channel) {
                mBtnHandle.setVisibility(View.VISIBLE);
            } else {
                mBtnHandle.setVisibility(View.GONE);
            }
        });
        mBtnHandle.setOnClickListener(v -> {
            if (mRadioGroup.getCheckedRadioButtonId() == R.id.rb_method_channel) {
                mMethodChannelPlugin.callFlutterMethod("getFlutter", "123456");
            }
        });
    }

    private void initData() {
        String initParam = getIntent().getStringExtra("initParam");
        FrameLayout frameLayout = findViewById(R.id.frame_layout);
        mFlutterView = Flutter.createView(
                this,
                getLifecycle(),
                initParam
        );
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT);
        params.gravity = Gravity.CENTER;
        frameLayout.addView(mFlutterView, params);

        // 注册插件
        registerPlugin();
    }

    private void initView() {
        mRadioGroup = findViewById(R.id.radio_group);
        mInput = findViewById(R.id.et_input);
        mRadioGroup.check(R.id.rb_message_channel);
        mReceiveMessage = findViewById(R.id.tv_message);
        mBtnHandle = findViewById(R.id.btn_handle);
    }

    private void registerPlugin() {
        if (mBasicMessageChannelPlugin == null) {
            mBasicMessageChannelPlugin = BasicMessageChannelPlugin.registerPlugin(mFlutterView, this);
        }
        if (mEventChannelPlugin == null) {
            mEventChannelPlugin = EventChannelPlugin.registerPlugin(mFlutterView);
        }
        if (mMethodChannelPlugin == null) {
            mMethodChannelPlugin = MethodChannelPlugin.registerPlugin(mFlutterView, this);
        }
    }

    @Override
    public void showMessage(String message) {
        mReceiveMessage.setText("收到Flutter消息：" + message);
    }
}
