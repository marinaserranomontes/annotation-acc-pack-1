package com.tokbox.android.annotations;

import android.graphics.Paint;

import com.tokbox.android.annotations.Annotatable;
import com.tokbox.android.annotations.AnnotationsManager;

import junit.framework.Assert;

import org.junit.Test;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class AnnotationsManagerTest {

    private AnnotationsManager annotationsManager = new AnnotationsManager();

    @Test
    public void addAnnotatable_When_OK() throws Exception {
        Annotatable annotatable = new Annotatable("", new AnnotationsPath(), new Paint(), 1, 1, "");
        annotationsManager.addAnnotatable(annotatable);
        ArrayList<Annotatable> annotatableList = annotationsManager.getAnnotatableList();
        for(int i = 0; i < annotatableList.size(); i++){
            Assert.assertEquals(annotatableList.get(i), annotatable);
        }
    }
    @Test(expected=Exception.class)
    public void addAnnotatable_When_annotatableIsNull() throws Exception {

        annotationsManager.addAnnotatable(null);

    }
}