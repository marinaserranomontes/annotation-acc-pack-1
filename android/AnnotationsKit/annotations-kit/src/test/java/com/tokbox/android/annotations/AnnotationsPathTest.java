package com.tokbox.android.annotations;

import android.graphics.PointF;

import junit.framework.Assert;

import org.junit.Test;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class AnnotationsPathTest {

    private AnnotationsPath annotationsPath = new AnnotationsPath();

    @Test
    public void setStartPoint_When_OK() throws Exception {
        PointF pointF = new PointF(0,0);
        annotationsPath.setStartPoint(pointF);
        Assert.assertTrue(annotationsPath.getStartPoint() == pointF);
    }
    @Test(expected=Exception.class)
    public void setStartPoint_When_startPointIsNull() throws Exception {

        annotationsPath.setStartPoint(null);
    }

    @Test
    public void setLastPointF_When_OK() throws Exception {
        PointF pointF = new PointF(1.0f,1.0f);
        annotationsPath.setLastPointF(pointF);
        Assert.assertTrue(annotationsPath.getLastPointF() == pointF);
    }
    @Test(expected=Exception.class)
    public void setLastPointF_When_endPointIsNull() throws Exception {

        annotationsPath.setLastPointF(null);
    }

    @Test
    public void setEndPoint_When_OK() throws Exception {
        PointF pointF = new PointF(1.0f,1.0f);
        annotationsPath.setEndPoint(pointF);
        Assert.assertTrue(annotationsPath.getEndPoint() == pointF);
    }
    @Test(expected=Exception.class)
    public void setEndPoint_When_endPointIsNull() throws Exception {

        annotationsPath.setEndPoint(null);
    }

    @Test
    public void addPoint_When_OK() throws Exception {
        PointF pointF = new PointF(1.0f,1.0f);
        annotationsPath.addPoint(pointF);
        ArrayList<PointF> pointFArrayList = annotationsPath.getPoints();
        for (int i = 0; i < pointFArrayList.size(); i++){
            Assert.assertTrue(pointFArrayList.get(i) == pointF);
        }
    }
    @Test(expected=Exception.class)
    public void addPoint_When_pointIsNull() throws Exception {

        annotationsPath.addPoint(null);
    }
}