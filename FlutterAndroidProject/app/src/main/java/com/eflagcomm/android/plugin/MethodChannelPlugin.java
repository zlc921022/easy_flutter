package com.eflagcomm.android.plugin;

import android.app.Activity;

import com.eflagcomm.android.IShowMessage;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

/**
 * <p>{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-14
 */
public class MethodChannelPlugin implements MethodChannel.MethodCallHandler {

    private IShowMessage mShowMessage;

    public static MethodChannelPlugin registerPlugin(FlutterView flutterView, IShowMessage showMessage) {
        return new MethodChannelPlugin(flutterView, showMessage);
    }

    private MethodChannelPlugin(FlutterView flutterView, IShowMessage showMessage) {
        this.mShowMessage = showMessage;
        MethodChannel methodChannel = new MethodChannel(flutterView, "MethodChannelPlugin");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
        switch (methodCall.method) {
            case "showMessage":
                showMessage(methodCall.arguments());
                result.success("你好，flutter，收到消息了");
                break;
            case "sum":
                int sum = sum(methodCall.arguments());
                result.success("原生计算结果为： " + sum);
                break;
            default:
                result.notImplemented();
        }
    }

    private void showMessage(String message) {
        if (mShowMessage != null) {
            mShowMessage.showMessage(message);
        }
    }

    private int sum(int a) {
        return a + 100;
    }
}
