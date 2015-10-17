//
//  Joke.m
//  AreYouJoking
//
//  Created by Егор Данилов on 17.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "Joke.h"

@implementation Joke

+ (Joke *)jokeFromDictionary:(NSDictionary *)info {
    
    Joke *aJoke = [Joke new];
    
    aJoke.url = info[@"link"];
    aJoke.sourceSite = info[@"desc"];
    aJoke.html = info[@"elementPureHtml"];
    
    return  aJoke;
}

@end
