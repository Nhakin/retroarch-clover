@echo off
set moddir=retroarch.hmod
set modname=retroarch.hmod
set outdir=output
set path=%path%;C:\Program Files (x86)\7-Zip
for %%x in (%*) do set outdir=%1
echo "%outdir%"

cd %moddir%
if not ERRORLEVEL 0 goto error
if EXIST "%modname%" del /F /Q "%modname%"
rem tar -czvf "%modname%" *
7z -ttar a * -so | 7z -si a -tgzip "%modname%"
if ERRORLEVEL 9009 goto notar
if NOT ERRORLEVEL 0 goto error
cd ..
if NOT EXIST "%outdir%" md "%outdir%"
if NOT ERRORLEVEL 0 goto error
if EXIST "%outdir%\%modname%" del /F /S /Q "%outdir%\%modname%"
if NOT ERRORLEVEL 0 goto error
move /Y "%moddir%\%modname%" "%outdir%"
if not ERRORLEVEL 0 goto error
echo Done!
goto end

:notar
echo Error %ERRORLEVEL%. Maybe you have not tar?
goto end

:error
echo Error %ERRORLEVEL%
goto end

:end
