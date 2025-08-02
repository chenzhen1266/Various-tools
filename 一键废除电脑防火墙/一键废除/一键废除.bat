@ECHO OFF
title 默认以管理员权限运行批处理
setlocal EnableDelayedExpansion
 
PUSHD %~DP0 & cd /d "%~dp0"
%1 %2
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :runas","","runas",1)(window.close)&goto :eof
:runas

NSudoL -U:T -P:E Disable.bat