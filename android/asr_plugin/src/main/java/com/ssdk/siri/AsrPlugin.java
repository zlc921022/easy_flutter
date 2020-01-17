package com.ssdk.siri;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.Map;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * <p>语音识别插件{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-17
 */
public class AsrPlugin implements MethodChannel.MethodCallHandler {

    private Activity mActivity;
    private AsrManager mAsrManager;
    private ResultStateful mResultStateful;

    public static AsrPlugin registerWith(PluginRegistry.Registrar registrar) {
        return new AsrPlugin(registrar);
    }

    private AsrPlugin(PluginRegistry.Registrar registrar) {
        mActivity = registrar.activity();
        MethodChannel methodChannel = new MethodChannel(registrar.messenger(), "asr_plugin");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall call, @NotNull MethodChannel.Result result) {
        initPermission();
        switch (call.method) {
            case "start":
                mResultStateful = ResultStateful.of(result);
                start(call);
                break;
            case "stop":
                stop();
                break;
            case "cancel":
                cancel();
                break;
            case "release":
                release();
                break;
            default:
        }
    }

    // 开始录音识别
    public void start(MethodCall call) {
        try {
            if (getAsrManager() != null) {
                getAsrManager().start(call.arguments instanceof Map ? (Map) call.arguments : null);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Log.e("start error：", e.getMessage());
        }
    }

    /**
     * 停止录音
     */
    public void stop() {
        try {
            if (getAsrManager() != null) {
                getAsrManager().stop();
            }
        } catch (Exception e) {
            e.printStackTrace();
            Log.e("start error：", e.getMessage());
        }
    }

    /**
     * 取消录音
     */
    public void cancel() {
        try {
            if (getAsrManager() != null) {
                getAsrManager().cancel();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 释放资源
     */
    public void release() {
        try {
            if (getAsrManager() != null) {
                getAsrManager().release();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建并获取语音识别管理类
     */
    private AsrManager getAsrManager() {
        if (mAsrManager != null) {
            return mAsrManager;
        }
        if (mActivity != null && !mActivity.isFinishing()) {
            mAsrManager = new AsrManager(mActivity, mOnAsrListener);
        }
        return mAsrManager;
    }

    private final OnAsrListener mOnAsrListener = new OnAsrListener() {

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {
            if (mResultStateful != null) {
                Log.e("识别到的内容为：", results[0]);
                mResultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if (mResultStateful != null) {
                Log.e("识别到的内容为：", descMessage);
                mResultStateful.error(errorCode + "", descMessage, recogResult);
            }
        }
    };

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
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(mActivity, perm)) {
                toApplyList.add(perm);
                // 进入到这里代表没有权限.

            }
        }
        String[] tmpList = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()) {
            ActivityCompat.requestPermissions(mActivity, toApplyList.toArray(tmpList), 123);
        }
    }
}
