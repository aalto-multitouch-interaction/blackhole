#include "ofApp.h"
//--------------------------------------------------------------
void ofApp::setup(){
    sound.load("music.mp3");
    sound.setLoop(true);
    sound.play();
    
    flagDoorDown = false; //If there is door on tablet, it is true.
    flagDoorUp = false;
    flagTrace = true; //If trace is generating, it is true.
    
    STATE = 0;
    
    ofBackground(0);
    ofSetCircleResolution(100);
    ofSetBackgroundAuto(true);
    
    touchPoint0.set(HIDDEN_POINT,HIDDEN_POINT);
    touchPoint1.set(HIDDEN_POINT,HIDDEN_POINT);
    centerPoint.set(HIDDEN_POINT,HIDDEN_POINT);
    tracePoint.set(ofRandom(50,ofGetWidth()-50),ofRandom(50,ofGetHeight()-50));
    newtracePoint.set(HIDDEN_POINT+500,HIDDEN_POINT+500);
    
    num = 0;
    distance = 50;
    Direction = true;
    angle = ofRandom(0,360);
    
    doorRadius = 260;
}

//--------------------------------------------------------------
void ofApp::update(){
    if(flagDoorDown){
        centerPoint.x = (touchPoint0.x+touchPoint1.x)/2;
        centerPoint.y = (touchPoint0.y+touchPoint1.y)/2;
    }else{
        centerPoint.x = HIDDEN_POINT;
        centerPoint.y = HIDDEN_POINT;
    }
    
    //**setup trace
    if(flagTrace){ //generate trace.
        //flagAbsorb = false;
        //cout << "flagTrace" << endl;
        trace newTrace;
        num ++;
        if(num%40 == 0){
            newtracePoint.x = tracePoint.x+distance*cos(angle*2*PI/360);
            newtracePoint.y = tracePoint.y+distance*sin(angle*2*PI/360);
            if(newtracePoint.x < 0 || newtracePoint.x > ofGetWidth() || newtracePoint.y < 0 || newtracePoint.y > ofGetHeight()){
                newtracePoint.x = ofRandom(50,ofGetWidth()-50);
                newtracePoint.y = ofRandom(50,ofGetHeight()-50);
                angle=ofRandom(0,360);
            }
            if(Direction){ //TRUE=LEFT, FALSE =RIGHT
                //cout << "flagTrace 3" << endl;
                newTrace.setup(newtracePoint.x+cos((angle+10)*2*PI/360),newtracePoint.y+sin((angle+10)*2*PI/360), angle, true);
                Direction =!Direction;
            }else{
                newTrace.setup(newtracePoint.x+cos((angle-10)*2*PI/360),newtracePoint.y+sin((angle-10)*2*PI/360), angle, false);
                Direction =!Direction;
            }
            traceArray.push_back(newTrace);
            tracePoint.x = newtracePoint.x;
            tracePoint.y = newtracePoint.y;
        }
    }
    
    //**Update trace
    for(int i=0; i<traceArray.size();i++){
       // cout << "traceArray update" << endl;
        traceArray[i].update();
    }
    
    //**When trace and door meet, trace generation is stop.
    if(STATE == 0){ //random generate
        if(ofDist(tracePoint.x,tracePoint.y,centerPoint.x,centerPoint.y)<doorRadius)
        {
            flagTrace = false;
            STATE = 1;
        }
    }else if(STATE  == 1){ //meet
        if(flagDoorUp){
            cout << "flagAbsorb" << endl;
            STATE = 2;
        }
    }else if(STATE == 2){ //absorb
        if(flagDoorDown){
            angle = ofRandom(0,360);
            num = 0;
            tracePoint.x = centerPoint.x + distance*cos(angle*2*PI/360);
            tracePoint.y = centerPoint.y + distance*sin(angle*2*PI/360);
            flagTrace=true;
            STATE = 3;
            cout << "flagExit" << endl;
        }
    }else if(STATE == 3){ //Exit
        if(flagDoorUp){
            centerPoint.set(HIDDEN_POINT,HIDDEN_POINT);
            STATE = 0;
            cout << "flagInitial" << endl;
        }
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    //**door graphic
    if(flagDoorDown){
        ofSetColor(255);
        ofNoFill();
        ofDrawCircle(centerPoint, doorRadius);
    }
    //**trace graphic
    for(int i=0; i<traceArray.size();i++){
        traceArray[i].draw();
    }
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    flagDoorUp = false;
    //**When there is door...
    //cout << touch.numTouches << endl;
    //cout << " id: " << touch.id << endl;
    if(touch.id == 0){
        touchPoint0.x = touch.x;
        touchPoint0.y = touch.y;
    }
    if(touch.id == 1){
        touchPoint1.x = touch.x;
        touchPoint1.y = touch.y;
    }
    if(touch.numTouches==2){
        flagDoorDown = true;
    }else{
        flagDoorDown = false;
    }
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    flagDoorDown = false;
    flagDoorUp = true;
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}

