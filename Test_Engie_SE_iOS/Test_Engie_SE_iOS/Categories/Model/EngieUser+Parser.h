//
//  EngieUser+Parser.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "EngieUser.h"

@interface EngieUser (Parser)

+ (BOOL)parseObject:(NSArray *)inObjects error:(NSError **)outError;

@end
