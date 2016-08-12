package com.tokbox.android.annotations;

import android.content.Context;
import android.graphics.Paint;
import android.widget.EditText;

import com.tokbox.android.annotations.Annotatable;
import com.tokbox.android.annotations.AnnotationsPath;

import junit.framework.Assert;

import org.junit.Test;
//import org.junit.Assert;

import java.lang.Integer;
import java.util.Random;

import static org.junit.Assert.*;

public class AnnotatableTest {

    private Context context;
    private Annotatable annotatable;
    private String mode = "";
    private AnnotationsPath path = new AnnotationsPath();
    private AnnotationsText text = new AnnotationsText(new EditText(context), 1.0f, 1.0f);
    private Paint paint = new Paint();
    private int canvasWidth = 1;
    private int canvasHeight = 1;
    private String cid = "";

    private String generateLongString(int length){

        StringBuilder tmp = new StringBuilder();
        for (char ch = '0'; ch <= '9'; ++ch)
            tmp.append(ch);
        for (char ch = 'a'; ch <= 'z'; ++ch)
            tmp.append(ch);
        char[] symbols = tmp.toString().toCharArray();
        char[] buf = new char[length];
        Random random = new Random();

        for (int idx = 0; idx < buf.length; ++idx)
            buf[idx] = symbols[random.nextInt(symbols.length)];
        return new String(buf);
    }

    @Test
    public void AnnotatablePath_When_OK() throws Exception {

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        Assert.assertNotNull(annotatable);

        Assert.assertEquals(annotatable.getMode(), mode);
        Assert.assertEquals(annotatable.getPath(), path);
        Assert.assertEquals(annotatable.getPaint(), paint);
        Assert.assertEquals(annotatable.getCanvasWidth(), canvasWidth);
        Assert.assertEquals(annotatable.getCanvasHeight(), canvasHeight);
        Assert.assertEquals(annotatable.getCId(), cid);

    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_modeIsNull() throws Exception {

        mode = null;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_modeIsEmptyString() throws Exception {

        mode = "";

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_modeIsLongString() throws Exception {

        mode = generateLongString(1001);

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
/*    @Test
    public void AnnotatablePath_When_modeIsNotValidString() throws Exception {
    }*/
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_pathIsNull() throws Exception {

        path = null;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_paintIsNull() throws Exception {

        paint = null;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_canvasWidthIsLowerThanZero() throws Exception {

        canvasWidth = -1;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_canvasWidthIsMAXINT() throws Exception {

        canvasWidth = Integer.MAX_VALUE;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_canvasHeightIsLowerThanZero() throws Exception {

        canvasHeight = -1;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_canvasHeightIsMAXINT() throws Exception {

        canvasHeight = Integer.MAX_VALUE;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_cidIsNull() throws Exception {

        cid = null;

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_cidIsEmptyString() throws Exception {

        cid = "";

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatablePath_When_cidIsLongString() throws Exception {

        cid = generateLongString(1001);

        annotatable = new Annotatable(mode, path, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
/*    @Test
    public void AnnotatablePath_When_cidIsNotValidString() throws Exception {
    }*/

    @Test
    public void AnnotatableText_When_OK() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        Assert.assertNotNull(annotatable);

        Assert.assertEquals(annotatable.getMode(), mode);
        Assert.assertEquals(annotatable.getText(), text);
        Assert.assertEquals(annotatable.getPaint(), paint);
        Assert.assertEquals(annotatable.getCanvasWidth(), canvasWidth);
        Assert.assertEquals(annotatable.getCanvasHeight(), canvasHeight);
        Assert.assertEquals(annotatable.getCId(), cid);

    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_modeIsNull() throws Exception {

        mode = null;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_modeIsEmptyString() throws Exception {

        mode = "";

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_modeIsLongString() throws Exception {

        mode = generateLongString(1001);

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
/*    @Test
    public void AnnotatableText_When_modeIsNotValidString() throws Exception {
    }*/
    @Test(expected=Exception.class)
    public void AnnotatableText_When_textIsNull() throws Exception {

        text = null;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_paintIsNull() throws Exception {

        paint = null;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_canvasWidthIsLowerThanZero() throws Exception {

        canvasWidth = -1;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_canvasWidthIsMAXINT() throws Exception {

        canvasWidth = Integer.MAX_VALUE;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_canvasHeightIsLowerThanZero() throws Exception {

        canvasHeight = -1;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_canvasHeightIsMAXINT() throws Exception {

        canvasHeight = Integer.MAX_VALUE;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_cidIsNull() throws Exception {

        cid = null;

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_cidIsEmptyString() throws Exception {

        cid = "";

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
    @Test(expected=Exception.class)
    public void AnnotatableText_When_cidIsLongString() throws Exception {

        cid = generateLongString(1001);

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);

        //Assert.assertNull(annotatable);
    }
/*    @Test
    public void AnnotatableText_When_cidIsNotValidString() throws Exception {
    }*/

    @Test
    public void setMode_When_OK() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setMode(null);

    }
    @Test(expected=Exception.class)
    public void setMode_When_modeIsNull() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setMode(null);

    }
    @Test(expected=Exception.class)
    public void setMode_When_modeIsEmptyString() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setMode("");

    }
    @Test(expected=Exception.class)
    public void setMode_When_modeIsLongString() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setMode(generateLongString(1001));

    }
/*    @Test
    public void setMode_When_modeIsNotValidString() throws Exception {
    }*/

    @Test
    public void setData_When_OK() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setData(null);

    }
    @Test(expected=Exception.class)
    public void setData_When_dataIsNull() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setData(null);

    }
    @Test(expected=Exception.class)
    public void setData_When_dataIsEmptyString() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setData("");

    }
    @Test(expected=Exception.class)
    public void setData_When_dataIsLongString() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setData(generateLongString(1001));

    }
/*    @Test
    public void setData_When_dataIsNotValidString() throws Exception {
    }*/

    @Test
    public void setType_When_OK() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setType(null);

    }
    @Test(expected=Exception.class)
    public void setType_When_typeIsNull() throws Exception {

        annotatable = new Annotatable(mode, text, paint, canvasWidth, canvasHeight, cid);
        annotatable.setType(null);

    }
}