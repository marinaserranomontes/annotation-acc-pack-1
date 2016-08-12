package com.tokbox.android.annotations;

import android.content.Context;
import android.widget.EditText;

import junit.framework.Assert;

import org.junit.Test;

import static org.junit.Assert.*;

public class AnnotationsTextTest {

    private Context context;
    AnnotationsText annotationsText;

    @Test
    public void AnnotationsText_When_OK() throws Exception {
        EditText editText = new EditText(context);
        annotationsText = new AnnotationsText(editText, 1.0f, 1.0f);

        Assert.assertEquals(annotationsText.getEditText(), editText);
        Assert.assertEquals(1.0f, annotationsText.getX());
        Assert.assertEquals(1.0f, annotationsText.getY());

    }
    @Test(expected=Exception.class)
    public void AnnotationsText_When_editTextIsNull() throws Exception {
        annotationsText = new AnnotationsText(null, 1.0f, 1.0f);
    }

    @Test(expected=Exception.class)
    public void AnnotationsText_When_xIsLowerThanZero() throws Exception {
        annotationsText = new AnnotationsText(new EditText(context), -1.0f, 1.0f);
    }
    @Test(expected=Exception.class)
    public void AnnotationsText_When_xIsMAXFLOAT() throws Exception {
        annotationsText = new AnnotationsText(new EditText(context), Float.MAX_VALUE, 1.0f);
    }
    @Test(expected=Exception.class)
    public void AnnotationsText_When_yIsLowerThanZero() throws Exception {
        annotationsText = new AnnotationsText(new EditText(context), 1.0f, -1.0f);
    }
    @Test(expected=Exception.class)
    public void AnnotationsText_When_yIsMAXFLOAT() throws Exception {
        annotationsText = new AnnotationsText(new EditText(context), 1.0f, Float.MAX_VALUE);
    }
}