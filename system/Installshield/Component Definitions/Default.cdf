[Components]
component0=Supplemental Fonts
component1=Program Files
component2=Sample Programs
component3=Documentation

[TopComponents]
component0=Program Files
component1=Documentation
component2=Sample Programs
component3=Supplemental Fonts

[SetupType]
setuptype0=Compact
setuptype1=Typical
setuptype2=Custom

[SetupTypeItem-Compact]
Comment=
item0=Program Files
Descrip=
DisplayText=

[Program Files]
SELECTED=Yes
FILENEED=STANDARD
HTTPLOCATION=
STATUS=Copying program files...
UNINSTALLABLE=Yes
TARGET=<TARGETDIR>
FTPLOCATION=
VISIBLE=Yes
DESCRIPTION=EasyCRT and EasyGDI source and library files
DISPLAYTEXT=
IMAGE=
DEFSELECTION=Yes
filegroup0=Program Files
COMMENT=
INCLUDEINBUILD=Yes
INSTALLATION=ALWAYSOVERWRITE
COMPRESSIFSEPARATE=No
MISC=
ENCRYPT=No
DISK=ANYDISK
TARGETDIRCDROM=
PASSWORD=
TARGETHIDDEN=General Application Destination

[Supplemental Fonts]
SELECTED=Yes
FILENEED=STANDARD
HTTPLOCATION=
STATUS=Copying fonts...
UNINSTALLABLE=Yes
TARGET=<WINDIR>\Fonts
FTPLOCATION=
VISIBLE=Yes
DESCRIPTION=Supplemental fonts used by EasyCRT and sample programs
DISPLAYTEXT=
IMAGE=
DEFSELECTION=Yes
filegroup0=Supplemental Fonts
COMMENT=
INCLUDEINBUILD=Yes
INSTALLATION=NEVEROVERWRITE
COMPRESSIFSEPARATE=No
MISC=
ENCRYPT=No
DISK=ANYDISK
TARGETDIRCDROM=
PASSWORD=
TARGETHIDDEN=Windows Operating System\Fonts

[SetupTypeItem-Custom]
Comment=
item0=Supplemental Fonts
item1=Program Files
item2=Sample Programs
item3=Documentation
Descrip=
DisplayText=

[Sample Programs]
SELECTED=Yes
FILENEED=STANDARD
HTTPLOCATION=
STATUS=Copying sample programs...
UNINSTALLABLE=Yes
TARGET=<TARGETDIR>
FTPLOCATION=
VISIBLE=Yes
DESCRIPTION=Sample programs using EasyCRT and EasyGDI
DISPLAYTEXT=
IMAGE=
DEFSELECTION=Yes
filegroup0=Sample Programs
COMMENT=
INCLUDEINBUILD=Yes
INSTALLATION=ALWAYSOVERWRITE
COMPRESSIFSEPARATE=No
MISC=
ENCRYPT=No
DISK=ANYDISK
TARGETDIRCDROM=
PASSWORD=
TARGETHIDDEN=General Application Destination

[Info]
Type=CompDef
Version=1.00.000
Name=

[SetupTypeItem-Typical]
Comment=
item0=Supplemental Fonts
item1=Program Files
item2=Sample Programs
item3=Documentation
Descrip=
DisplayText=

[Documentation]
SELECTED=Yes
FILENEED=STANDARD
HTTPLOCATION=
STATUS=Copying documentation...
UNINSTALLABLE=Yes
TARGET=<TARGETDIR>
FTPLOCATION=
VISIBLE=Yes
DESCRIPTION=Online Command Documentation
DISPLAYTEXT=
IMAGE=
DEFSELECTION=Yes
filegroup0=Documentation
COMMENT=
INCLUDEINBUILD=Yes
INSTALLATION=ALWAYSOVERWRITE
COMPRESSIFSEPARATE=No
MISC=
ENCRYPT=No
DISK=ANYDISK
TARGETDIRCDROM=
PASSWORD=
TARGETHIDDEN=General Application Destination

