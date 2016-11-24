//
//  AES.h
//  bochk
//
//  Created by Algebra Lo on 28/09/2010.
//  Copyright 2010 MTel Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableData (AES) 

- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128DecryptWithKey:(NSString *)key;

@end
