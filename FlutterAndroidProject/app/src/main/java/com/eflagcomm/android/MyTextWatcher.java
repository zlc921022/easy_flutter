package com.eflagcomm.android;

import android.text.Editable;
import android.text.TextWatcher;

/**
 * <p>{d}</p>
 *
 * @author zhenglecheng
 * @date 2020-01-14
 */
public interface MyTextWatcher extends TextWatcher {
    @Override
    default void beforeTextChanged(CharSequence s, int start, int count, int after) {

    }

    @Override
    default void onTextChanged(CharSequence s, int start, int before, int count) {

    }

    @Override
    default void afterTextChanged(Editable s) {

    }
}
