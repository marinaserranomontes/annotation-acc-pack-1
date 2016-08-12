package com.tokbox.android.annotations;

import android.content.Context;
import android.test.mock.MockContext;
import android.view.View;

import org.junit.Test;

import static org.junit.Assert.*;

public class AnnotationsToolbarTest {

    private Context context = new MockContext();
    private AnnotationsToolbar annotationsToolbar;

    /*@Test
    public void setActionListener_When_OK() throws Exception {
        annotationsToolbar = new AnnotationsToolbar(context);
        annotationsToolbar.setActionListener(new AnnotationsToolbar.ActionsListener() {
            @Override
            public void onItemSelected(View v, boolean selected) {

            }

            @Override
            public void onColorSelected(int color) {

            }
        });
    }*/

    @Test(expected=Exception.class)
    public void setActionListener_When_listenerIsNull() throws Exception {
        annotationsToolbar = new AnnotationsToolbar(context);
        annotationsToolbar.setActionListener(null);
    }

    @Test(expected=Exception.class)
    public void AnnotationsToolbar_When_contextIsNull() throws Exception {
        annotationsToolbar = new AnnotationsToolbar(null);
    }

/*    @Test
    public void AnnotationsToolbar_When_contextIsNull() throws Exception {
        assertEquals(4, 2 + 2);
    }*/

    @Test(expected=Exception.class)
    public void AnnotationsToolbar_When_attrsIsNull() throws Exception {
        annotationsToolbar = new AnnotationsToolbar(context, null);
    }

    /*@Test
    public void updateColorPickerSelectedButtons_When_viewIsNull() throws Exception {
        annotationsToolbar = new AnnotationsToolbar(context);
    }

    @Test
    public void updateColorPickerSelectedButtons_When_colorIsLowerThanZero() throws Exception {
    }

    @Test
    public void updateColorPickerSelectedButtons_When_colorIsMAXINT() throws Exception {
    }

    @Test
    public void updateColorPickerSelectedButtons_When_viewIsNull() throws Exception {
        assertEquals(4, 2 + 2);
    }*/

}
