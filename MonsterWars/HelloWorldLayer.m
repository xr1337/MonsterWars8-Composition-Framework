//
//  HelloWorldLayer.m
//  MonsterWars
//
//  Created by Ray Wenderlich on 10/27/12.
//  Copyright Razeware LLC 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer {
    CCLabelBMFont * _coin1Label;
    CCLabelBMFont * _coin2Label;
    CCLabelBMFont * _stateLabel;
    CCSpriteBatchNode * _batchNode;
    BOOL _gameOver;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (void)basicSetup {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    float MARGIN = 26 / CC_CONTENT_SCALE_FACTOR();
    
    // Create batch node
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sprites.plist"];
    _batchNode = [CCSpriteBatchNode batchNodeWithFile:@"Sprites.pvr.ccz"];
    [self addChild:_batchNode];
    
    // Sounds
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Latin_Industries.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"bigHit.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"boom.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"pew.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"pew2.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"smallHit.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"attack.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"defend.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"spawn.wav"];
    
    // Rest of UI
    
    CCSprite * background = [CCSprite spriteWithFile:@"background.png"];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:background z:-1];
    
    CCMenuItemSprite * quirkButton = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"button_sel.png"] target:self selector:@selector(quirkButtonTapped:)];
    CCMenuItemSprite * zapButton = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"button_sel.png"]target:self selector:@selector(zapButtonTapped:)];
    CCMenuItemSprite * munchButton = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"button_sel.png"]target:self selector:@selector(munchButtonTapped:)];
    
    zapButton.position = ccp(winSize.width/2, MARGIN + zapButton.contentSize.height/2);
    quirkButton.position = ccp(zapButton.position.x - zapButton.contentSize.width/2 - MARGIN - quirkButton.contentSize.width/2, MARGIN + zapButton.contentSize.height/2);
    munchButton.position = ccp(zapButton.position.x + zapButton.contentSize.width/2 + MARGIN + munchButton.contentSize.width/2, MARGIN + munchButton.contentSize.height/2);
    
    CCSprite * quirk = [CCSprite spriteWithSpriteFrameName:@"quirk1.png"];
    quirk.position = ccp(quirkButton.contentSize.width * 0.25, quirkButton.contentSize.height/2);
    [quirkButton addChild:quirk];
    
    CCSprite * zap = [CCSprite spriteWithSpriteFrameName:@"zap1.png"];
    zap.position = ccp(zapButton.contentSize.width * 0.25, zapButton.contentSize.height/2);
    [zapButton addChild:zap];
    
    CCSprite * munch = [CCSprite spriteWithSpriteFrameName:@"munch1.png"];
    munch.position = ccp(munchButton.contentSize.width * 0.25, munchButton.contentSize.height/2);
    [munchButton addChild:munch];
    
    CCLabelBMFont * quirkLabel = [CCLabelBMFont labelWithString:@"10" fntFile:@"Courier.fnt"];
    quirkLabel.position = ccp(quirkButton.contentSize.width * 0.75, MARGIN*2.1);
    [quirkButton addChild:quirkLabel];
    
    CCLabelBMFont * zapLabel = [CCLabelBMFont labelWithString:@"25" fntFile:@"Courier.fnt"];
    zapLabel.position = ccp(zapButton.contentSize.width * 0.75, MARGIN*2.1);
    [zapButton addChild:zapLabel];
    
    CCLabelBMFont * munchLabel = [CCLabelBMFont labelWithString:@"50" fntFile:@"Courier.fnt"];
    munchLabel.position = ccp(munchButton.contentSize.width * 0.75, MARGIN*2.1);
    [munchButton addChild:munchLabel];
    
    _stateLabel = [CCLabelBMFont labelWithString:@"Idle" fntFile:@"Courier.fnt"];
    _stateLabel.position = ccp(winSize.width/2, winSize.height * 0.25);
    [self addChild:_stateLabel];
    
    CCMenu * menu = [CCMenu menuWithItems:quirkButton, zapButton, munchButton, nil];
    menu.position = CGPointZero;
    [self addChild:menu];
    
    CCSprite * coin1 = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coin1.position = ccp(MARGIN + coin1.contentSize.width/2, winSize.height - MARGIN - coin1.contentSize.height/2);
    [self addChild:coin1];
    
    CCSprite * coin2 = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coin2.position = ccp(winSize.width - MARGIN - coin2.contentSize.width/2, winSize.height - MARGIN - coin2.contentSize.height/2);
    [self addChild:coin2];
    
    _coin1Label = [CCLabelBMFont labelWithString:@"10" fntFile:@"Courier.fnt" width:winSize.width * 0.25 alignment:kCCTextAlignmentLeft];
    _coin1Label.position = ccp(coin1.position.x + coin1.contentSize.width/2 + MARGIN/2 + _coin1Label.contentSize.width/2, winSize.height - MARGIN*1.6);
    [self addChild:_coin1Label];
    
    _coin2Label = [CCLabelBMFont labelWithString:@"10" fntFile:@"Courier.fnt" width:winSize.width * 0.25 alignment:kCCTextAlignmentRight];
    _coin2Label.position = ccp(coin2.position.x - coin1.contentSize.width/2 - MARGIN/2 - _coin2Label.contentSize.width/2, winSize.height - MARGIN*1.6);
    [self addChild:_coin2Label];
    
    self.isTouchEnabled = YES;
    [self scheduleUpdate];
}

- (void)addPlayers {
    
}

-(id) init
{
    if( (self=[super init]) ) {
        
        [self basicSetup];
        [self addPlayers];
        
    }
    return self;
}

- (void)showRestartMenu:(BOOL)won {
    
    if (_gameOver) return;
    _gameOver = YES;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    NSString *message;
    if (won) {
        message = @"You win!";
    } else {
        message = @"You lose!";
    }
    
    CCLabelBMFont *label;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        label = [CCLabelBMFont labelWithString:message fntFile:@"Courier-hd.fnt"];
    } else {
        label = [CCLabelBMFont labelWithString:message fntFile:@"Courier.fnt"];
    }
    label.scale = 0.1;
    label.position = ccp(winSize.width/2, winSize.height * 0.6);
    [self addChild:label];
    
    CCLabelBMFont *restartLabel;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        restartLabel = [CCLabelBMFont labelWithString:@"Restart" fntFile:@"Courier-hd.fnt"];
    } else {
        restartLabel = [CCLabelBMFont labelWithString:@"Restart" fntFile:@"Courier.fnt"];
    }
    
    CCMenuItemLabel *restartItem = [CCMenuItemLabel itemWithLabel:restartLabel target:self selector:@selector(restartTapped:)];
    restartItem.scale = 0.1;
    restartItem.position = ccp(winSize.width/2, winSize.height * 0.4);
    
    CCMenu *menu = [CCMenu menuWithItems:restartItem, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:10];
    
    [restartItem runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
    [label runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
    
}

- (void)restartTapped:(id)sender {
    
    // Reload the current scene
    CCScene *scene = [HelloWorldLayer scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipX transitionWithDuration:0.5 scene:scene]];
    
}

- (void)registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)update:(ccTime)dt {
    
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [self convertTouchToNodeSpace:touch];
    NSLog(@"Touch at: %@", NSStringFromCGPoint(touchPoint));
    
    return YES;
}

- (void)quirkButtonTapped:(id)sender {
    NSLog(@"Quirk button tapped!");
}

- (void)zapButtonTapped:(id)sender {
    NSLog(@"Zap button tapped!");
}

- (void)munchButtonTapped:(id)sender {
    NSLog(@"Munch button tapped!");
}

@end
