#pragma once

#include "global.h"

// LAST_USED_BALL
u32 CanThrowBall(void);
//
void __attribute__((long_call)) SetUpItemUseCallback(u8 taskId);
void __attribute__((long_call)) sub_80A103C(u8 taskId);
void __attribute__((long_call)) PrintNotTheTimeToUseThat(u8 taskId, bool8 inField);

extern void (*sItemUseOnFieldCB)(u8 taskId);
