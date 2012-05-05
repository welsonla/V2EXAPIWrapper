# V2EX API Wrapper for iOS / MacOS

An unofflical Objective-C API wrapper for [Project Babel 2](https://github.com/livid/v2ex). 

**Now compatible with Project Babel 3.**

__Lightweight fork comming soon…__


## Features

* Singleton. `[V2EXAPIWrapper shared]`
* Block based instance methods.
* CoreData powered presistent requests for offline cache.


## Dependences & Requirements

* [CocoaPods](https://github.com/CocoaPods/CocoaPods). Make sure to run `pod install` before compiling. After that RestKit 0.10.0 would be installed.
* iOS 4.3+ / Mac OS X 10.6+ 
* XCode 4+


## Usage

`#import "V2EXAPIWrapper.h"`

Dumping all nodes asynchronously is very easy:

    [[V2EXAPIWrapper shared] loadNodes:^(NSError *error, NSArray *nodes) {
        NSMutableArray *nodesArray = [NSMutableArray array];
        for (V2EXNode *node in nodes) {
            [nodesArray addObject:node.title];
        }
        NSLog(@"Nodes: %@", [nodesArray componentsJoinedByString:@","]);
    }];

See also *V2EXAPIWrapper.h* for more methods.


## License
Copyright (c) 2012, Lex Tang
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the LexTang.com nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.