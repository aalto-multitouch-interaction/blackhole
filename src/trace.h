#pragma once
#include "ofxiOS.h"
#define BACKGROUND_COLOR 0

class trace{
public:
    void setup(float posX, float posY, float a, bool LR){
        position.x = posX;
        position.y = posY;
        state=0;
        alpha=0;
        counter=0;
        alphaUpSpeed = 20;
        alphaDownSpeed = 2;
        counterMax=180;//3 seconds at 60 fps
        size=20;
        Left=LR;
        footL.load("footL2.png");
        footR.load("footR2.png");
        footAngle = a;
        footL.resize(99,94);
        footR.resize(99,94);
    }
    void update(){
        //cout << "state: " << state << endl;
        if(state==0){ //left foot appear
            if(alpha<250){
                //cout << "alphaUp" << alpha << endl;
                alpha+=alphaUpSpeed;
            }else{
                state=1;
            }
        }else if(state==1){ //left foot remain && right foot appear
            if(counter<counterMax){
                counter++;
                //cout << "counter" << counter << endl;
            }else{
                counter=0;
                state=2;
            }
        }else if(state==2){ // left foot disappear
            if(alpha>0){
                //cout << "alphaDown" << alpha << endl;
                alpha-=alphaDownSpeed;
            }else{
                state=3;
            }
        }
    }
    void draw(){
        ofSetRectMode(OF_RECTMODE_CENTER);
        if(Left){
            ofSetColor(255,alpha);
            ofFill();//according to the LeftRight, image should be changed.
//            ofDrawCircle(position.x,position.y,size);
            ofPushMatrix();
            ofTranslate(position.x, position.y);
            ofRotateDeg(footAngle-90);
            footL.draw(0, 0);
            ofPopMatrix();
        }else{
            ofSetColor(255,alpha);
            ofFill();//according to the LeftRight, image should be changed.
//            ofDrawCircle(position.x,position.y,size);
            ofPushMatrix();
            ofTranslate(position.x, position.y);
            ofRotateDeg(footAngle-90);
            footR.draw(0, 0);
            ofPopMatrix();
        }
    }
    ofVec2f position;
    int state;
    float alpha;
    int counter;
    float alphaUpSpeed;
    float alphaDownSpeed;
    float counterMax;//3 seconds at 60 fps
    float size;
    bool Left;
    ofImage footL;
    ofImage footR;
    float footAngle;
};
