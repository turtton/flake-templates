#!/usr/bin/env bash

wineprefix cjkfonts
cd "./オトメ＊ドメイン/オトメドメインＤＬ版・期間限定コラボセット/オトメドメイン/"
mv オトメドメイン.exe オトメドメイン-old.exe
dd bs=1 skip=229376 if=オトメドメイン-old.exe of=オトメドメイン.exe
