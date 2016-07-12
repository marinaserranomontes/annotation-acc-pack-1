package com.tokbox.android.annotations;


import java.util.ArrayList;

public class AnnotationsManager {

    private ArrayList<Annotatable> mAnnotatableList;
    protected final String SIGNAL_TYPE = "annotations";

    public AnnotationsManager(){
        mAnnotatableList = new ArrayList<Annotatable>();
    }

     public void addAnnotatable(Annotatable annotatable){
        mAnnotatableList.add(annotatable);
        if ( annotatable.getPath() != null){
            annotatable.setType (Annotatable.AnnotatableType.PATH);
        }
        else  {
            if ( annotatable.getText() != null ){
                annotatable.setType(Annotatable.AnnotatableType.TEXT);
            }
        }
    }

    public ArrayList<Annotatable> getAnnotatableList() {
        return mAnnotatableList;
    }

}
