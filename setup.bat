@echo off
copy a:\easycrt\*.* c:\tpw\doc
copy a:\easycrt\system\*.* c:\windows < a:\easycrt\setup.scp
copy a:\easycrt\system\*.* c:\tpw     < a:\easycrt\setup.scp

echo.
echo EasyCRT has been installed.