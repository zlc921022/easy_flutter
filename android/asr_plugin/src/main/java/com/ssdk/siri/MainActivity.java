package com.ssdk.siri;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.widget.Button;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import static com.ssdk.siri.IStatus.STATUS_FINISHED;
import static com.ssdk.siri.IStatus.STATUS_LONG_SPEECH_FINISHED;
import static com.ssdk.siri.IStatus.STATUS_NONE;
import static com.ssdk.siri.IStatus.STATUS_READY;
import static com.ssdk.siri.IStatus.STATUS_RECOGNITION;
import static com.ssdk.siri.IStatus.STATUS_SPEAKING;
import static com.ssdk.siri.IStatus.STATUS_STOPPED;
import static com.ssdk.siri.IStatus.STATUS_WAITING_READY;

/**
 * <p>{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-17
 */
public class MainActivity extends AppCompatActivity implements OnAsrListener {

    private AsrPlugin mAsrPlugin;
    private TextView mTvResult;
    private Button btn;
    private Button setting;
    /**
     * 控制UI按钮的状态
     */
    protected int status;
    private Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            handleMsg(msg);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.common);
        initPermission();
        MessageStatusRecogListener listener = new MessageStatusRecogListener(mHandler);
        mTvResult = findViewById(R.id.txtResult);
        btn = findViewById(R.id.btn);
        setting = findViewById(R.id.setting);
//        btn.setOnClickListener(v -> mAsrPlugin.start(fetchParams()));
//        mAsrPlugin = AsrPlugin.registerWith(this);
    }

    protected void handleMsg(Message msg) {
        // 处理MessageStatusRecogListener中的状态回调
        switch (msg.what) {
            case STATUS_FINISHED:
                if (msg.arg2 == 1) {
                    mTvResult.setText(msg.obj.toString());
                }
                status = msg.what;
                updateBtnTextByStatus();
                break;
            case STATUS_NONE:
            case STATUS_READY:
            case STATUS_SPEAKING:
            case STATUS_RECOGNITION:
                status = msg.what;
                updateBtnTextByStatus();
                break;
            default:
                break;
        }
    }

    private void updateBtnTextByStatus() {
        switch (status) {
            case STATUS_NONE:
                btn.setText("开始录音");
                btn.setEnabled(true);
                setting.setEnabled(true);
                break;
            case STATUS_WAITING_READY:
            case STATUS_READY:
            case STATUS_SPEAKING:
            case STATUS_RECOGNITION:
                btn.setText("停止录音");
                btn.setEnabled(true);
                setting.setEnabled(false);
                break;
            case STATUS_LONG_SPEECH_FINISHED:
            case STATUS_STOPPED:
                btn.setText("取消整个识别过程");
                btn.setEnabled(true);
                setting.setEnabled(false);
                break;
            default:
                break;
        }
    }

    protected Map<String, Object> fetchParams() {
        //  上面的获取是为了生成下面的Map， 自己集成时可以忽略
        Map<String, Object> params = new HashMap<>();
        //  集成时不需要上面的代码，只需要params参数。
        return params;
    }

    /**
     * android 6.0 以上需要动态申请权限
     */
    private void initPermission() {
        String[] permissions = {
                Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
        };

        ArrayList<String> toApplyList = new ArrayList<>();

        for (String perm : permissions) {
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(this, perm)) {
                toApplyList.add(perm);
                // 进入到这里代表没有权限.

            }
        }
        String[] tmpList = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()) {
            ActivityCompat.requestPermissions(this, toApplyList.toArray(tmpList), 123);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        // 此处为android 6.0以上动态授权的回调，用户自行实现。
    }
}
