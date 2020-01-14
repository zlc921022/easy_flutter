package com.eflagcomm.android.plugin;

import android.app.Activity;

import com.eflagcomm.android.IShowMessage;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.view.FlutterView;

/**
 * <p>{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-14
 */
public class BasicMessageChannelPlugin implements BasicMessageChannel.MessageHandler<String>, BasicMessageChannel.Reply<String> {

    private final BasicMessageChannel<String> mMessageChannel;
    private IShowMessage mShowMessage;

    public static BasicMessageChannelPlugin registerPlugin(FlutterView flutterView, IShowMessage showMessage) {
        return new BasicMessageChannelPlugin(flutterView, showMessage);
    }

    private BasicMessageChannelPlugin(FlutterView flutterView, IShowMessage iShowMessage) {
        this.mShowMessage = iShowMessage;
        mMessageChannel = new BasicMessageChannel<>(flutterView,
                "BasicMessageChannelPlugin", StringCodec.INSTANCE);
        mMessageChannel.setMessageHandler(this);
    }

    @Override
    public void onMessage(String message, @NonNull BasicMessageChannel.Reply<String> reply) {
        reply.reply("原生BasicMessageChannelPlugin收到消息" + message);
        if (mShowMessage != null) {
            mShowMessage.showMessage(message);
        }
    }

    /**
     * 发送消息
     *
     * @param message 消息内容
     */
    public void send(String message) {
        if (mMessageChannel != null) {
            mMessageChannel.send(message, this);
        }
    }

    @Override
    public void reply(String s) {

    }
}
