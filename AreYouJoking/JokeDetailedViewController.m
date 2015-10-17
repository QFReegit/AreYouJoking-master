//
//  JokeDetailedViewController.m
//  AreYouJoking
//
//  Created by Егор Данилов on 17.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "JokeDetailedViewController.h"

@interface JokeDetailedViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JokeDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.joke.html;
    
}

@end
