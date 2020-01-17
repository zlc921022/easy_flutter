package com.ssdk.siri;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;

/**
 * <p>{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-17
 */
public class ResultStateful implements MethodChannel.Result {

    private boolean called;
    private final String TAG = "ResultStateful";
    private MethodChannel.Result result;
    public static ResultStateful of(MethodChannel.Result result){
        return  new ResultStateful(result);
    }

    private ResultStateful(MethodChannel.Result result){
        this.result = result;
    }

    @Override
    public void success(Object o) {
        if (called) {
            Log.e(TAG, "已经调用过success");
            return;
        }
        called = true;
        result.success(o);
    }

    @Override
    public void error(String errorCode, String errorMessage, Object errorDetails) {
        if (called) {
            Log.e(TAG, "已经调用过error");
            return;
        }
        called = true;
        result.error(errorCode,errorMessage,errorDetails);
    }

    @Override
    public void notImplemented() {

    }
}
