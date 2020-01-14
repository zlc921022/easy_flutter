package com.eflagcomm.android.plugin;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.EventChannel;
import io.flutter.view.FlutterView;

/**
 * <p>{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-14
 */
public class EventChannelPlugin implements EventChannel.StreamHandler {

    private final EventChannel mEventChannel;
    private List<EventChannel.EventSink> mEventSinks = new ArrayList<>();

    public static EventChannelPlugin registerPlugin(FlutterView flutterView) {
        return new EventChannelPlugin(flutterView);
    }

    private EventChannelPlugin(FlutterView flutterView) {
        mEventChannel = new EventChannel(flutterView, "EventChannelPlugin");
        mEventChannel.setStreamHandler(this);
    }

    /**
     * 发送事件
     *
     * @param content 事件内容
     */
    public void sendEvent(Object content) {
        for (EventChannel.EventSink e : mEventSinks) {
            e.success(content);
        }
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.mEventSinks.add(eventSink);
    }

    @Override
    public void onCancel(Object o) {
        this.mEventSinks.clear();
    }
}
