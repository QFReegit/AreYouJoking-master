//
//  JokesViewController.m
//  AreYouJoking
//
//  Created by Oleg Tverdokhleb on 17.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "JokesViewController.h"
#import "Joke.h"
#import "JokeDetailedViewController.h"

@interface JokesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *jokes;

@end

@implementation JokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

- (void) prepareForSeque:(UIStoryboardSegue *)seque sender:(id)sender {
    
    if ([seque.destinationViewController isKindOfClass:[JokeDetailedViewController class]]) {
        JokeDetailedViewController *jvc = seque.destinationViewController;
        
        UITableViewCell *aCell = sender;
        NSIndexPath *cellIndex = [self.tableView indexPathForCell:aCell];
        Joke *joke = self.jokes[cellIndex.row];
        jvc.joke = joke;
    }
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.jokes.count == 0){
        [self updateData];
    }
    
}

//Загрузка данных из сети
- (void) updateData{
    NSString *urlString =  @"http://www.umori.li/api/get?site=bash.im&name=bash&num=5";
    
    NSURLSessionConfiguration *configutarion = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configutarion];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id parsedData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:nil];
        NSLog(@"%@", parsedData);
        [self parseData:parsedData];
    }] resume];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jokes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    Joke *joke = self.jokes[indexPath.row];
    
    cell.textLabel.text = joke.html;
    
    return cell;
}

- (void) parseData:(NSArray *)jokes {
    NSMutableArray *parsedJokes = [NSMutableArray new];
    
    for (NSDictionary *info in jokes) {
        Joke *aJoke = [Joke jokeFromDictionary:info];
        [parsedJokes addObject:aJoke];
    }
    
    self.jokes = parsedJokes;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    [self.tableView reloadData];
     }];
}

@end
