//
//  Joke.h
//  AreYouJoking
//
//  Created by Егор Данилов on 17.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Joke : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic,strong) NSString *html;
@property (nonatomic, strong) NSString *sourceSite;

+ (Joke *)jokeFromDictionary:(NSDictionary *)info;

@end
