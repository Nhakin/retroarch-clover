@echo off
Cls

set releasedir=release

if EXIST "%releasedir%" rd /s/q %releasedir%

md release\cores
md release\extra_cores

set path=%path%;C:\Program Files (x86)\7-Zip

zip -rq release/libretro_core_template.zip libretro_core_template.hmod/*
zip -rq release/CloverApp.zip CloverApp

cd retroarch.hmod 
7z a -ttar * -so -bd | 7z a -tgzip -si -bd "..\release\retroarch.hmod" > nul

cd ../core_modules
for /d %%d in (*.hmod) do (
  cd %%d
  7z a -ttar -bd * -so | 7z a -tgzip -si -bd ..\..\release\cores\%%d > nul
  cd..
)

cd ../core_modules_extra
for /d %%d in (*.hmod) do (
  cd %%d
  7z a -ttar -bd * -so | 7z a -tgzip -si -bd ..\..\release\extra_cores\%%d > nul
  cd..
)
