#!/bin/sh
swift package clean
swift test
swift build -c release
cp .build/release/Chroma /usr/local/bin/chroma
