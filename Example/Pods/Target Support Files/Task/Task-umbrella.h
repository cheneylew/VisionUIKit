#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

//#import "Task.h"
//#import "TaskErrors.h"
//#import "TSKBlockTask.h"
//#import "TSKExternalConditionTask.h"
//#import "TSKSelectorTask.h"
//#import "TSKSubworkflowTask.h"
//#import "TSKTask+WorkflowInterface.h"
//#import "TSKTask.h"
//#import "TSKWorkflow+TaskInterface.h"
//#import "TSKWorkflow.h"

FOUNDATION_EXPORT double TaskVersionNumber;
FOUNDATION_EXPORT const unsigned char TaskVersionString[];

