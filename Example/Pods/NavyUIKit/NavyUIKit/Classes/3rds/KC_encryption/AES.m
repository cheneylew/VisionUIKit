//
//  AES.m
//  bochk
//
//  Created by Algebra Lo on 28/09/2010.
//  Copyright 2010 MTel Limited. All rights reserved.
//

#import "AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSMutableData(AES)

@class NSString;

- (NSData *)AES128EncryptWithKey:(NSString *)key {
	char keyPtr[kCCKeySizeAES128+1];
	bzero(keyPtr, sizeof(keyPtr));
	
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [self length];
	
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
										  kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr, kCCBlockSizeAES128,
										  NULL,
										  [self bytes], dataLength,
										  buffer, bufferSize,
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
	free(buffer);
	return nil;
}

- (NSData *)AES128DecryptWithKey:(NSString *)key {
	char keyPtr[kCCKeySizeAES128+1];
	bzero(keyPtr, sizeof(keyPtr));
	
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [self length];
	
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
										  kCCOptionPKCS7Padding | kCCOptionECBMode,
										  keyPtr, kCCBlockSizeAES128,
										  NULL,
										  [self bytes], dataLength,
										  buffer, bufferSize,
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	free(buffer);
	return nil;
}
@end