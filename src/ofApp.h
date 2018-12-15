#pragma once

#include "ofxiOS.h"
#include "trace.h"

#define HIDDEN_POINT 2000
#define COUNT_DISAPPEAR 200
#define COUNT_APPEAR 60

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    //Door's touch points
    ofPoint touchPoint0, touchPoint1, centerPoint, tracePoint, newtracePoint;
    float doorRadius;
    
    //Trace
    vector <trace> traceArray;
    bool flagDoorDown, flagDoorUp, flagTrace, Direction;
    int STATE; //0: random generating, 1:meet, 2: absorb, 3: exit(generating at door), 4:without door;
    int num;
    float angle, distance;
    
    ofSoundPlayer sound;
};


