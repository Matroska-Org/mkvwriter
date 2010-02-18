# Microsoft Developer Studio Project File - Name="producersdk_plugins_output_mkvwriter" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=producersdk_plugins_output_mkvwriter - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "producersdk_plugins_output_mkvwriter.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "producersdk_plugins_output_mkvwriter.mak" CFG="producersdk_plugins_output_mkvwriter - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "producersdk_plugins_output_mkvwriter - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "producersdk_plugins_output_mkvwriter - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 1
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl
MTL=midl.exe
RSC=rc

!IF  "$(CFG)" == "producersdk_plugins_output_mkvwriter - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "dbg32"
# PROP BASE Intermediate_Dir "dbg32\obj"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "dbg32"
# PROP Intermediate_Dir "dbg32\obj"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /Zm200 /W3 /GX- /Od  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT  /MDd /Z7 /c 
# ADD CPP /nologo /Zp1 /Zm200 /W3 /GX- /Od  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT  /MDd /Z7 /c 
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x409 /d"_DEBUG" /d"DEBUG"  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT
# ADD RSC /l 0x409 /d"_DEBUG" /d"DEBUG"  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo 
LINK32=python c:\DOCUME~1\JORY~2.JCS\MYDOCU~1\VISUAL~1\MATROSKA\HELIX_~1\ribosome\build\bin\pylink -basefile:..\..\..\..\debug\rebase.lst -basedir:producersdk\plugins\output\mkvwriter
# ADD BASE LINK32 
# ADD LINK32 /base:0x60000000 /DLL /NOLOGO /INCREMENTAL:no /MACHINE:i386 /SUBSYSTEM:windows /debug /IMPLIB:dbg32\mkvwriter.lib /DEF:mkvwriter.def /PDB:NONE /OUT:dbg32\mkvwriter.dll  ..\..\..\..\common\container\dbg32\contlib.lib ..\..\..\..\common\dbgtool\dbg32\debuglib.lib ..\..\..\..\common\fileio\dbg32\fileiolib.lib ..\..\..\..\common\runtime\dbg32\runtlib.lib ..\..\..\..\common\system\dbg32\syslib.lib ..\..\..\..\common\util\dbg32\utillib.lib ..\..\..\..\producersdk\plugins\util\dbg32\pluginutillib.lib ..\..\..\..\producersdk\common\logutil\dbg32\prodlogutillib.lib ..\..\..\..\producersdk\common\system\dbg32\prodsyslib.lib ..\..\..\..\datatype\mkv\fileformat\libebml\make\helix\dbg32\libebml.lib ..\..\..\..\datatype\mkv\fileformat\libmatroska\make\helix\dbg32\libmatroska.lib version.lib wsock32.lib kernel32.lib user32.lib advapi32.lib gdi32.lib ole32.lib comctl32.lib uuid.lib winmm.lib

!ELSEIF  "$(CFG)" == "producersdk_plugins_output_mkvwriter - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "dbg32"
# PROP BASE Intermediate_Dir "dbg32\obj"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "dbg32"
# PROP Intermediate_Dir "dbg32\obj"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /Zm200 /W3 /GX- /Od  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT  /MDd /Z7 /c 
# ADD CPP /nologo /Zp1 /Zm200 /W3 /GX- /Od  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT  /MDd /Z7 /c 
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x409 /d"_DEBUG" /d"DEBUG"  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT
# ADD RSC /l 0x409 /d"_DEBUG" /d"DEBUG"  /I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo 
LINK32=python c:\DOCUME~1\JORY~2.JCS\MYDOCU~1\VISUAL~1\MATROSKA\HELIX_~1\ribosome\build\bin\pylink -basefile:..\..\..\..\debug\rebase.lst -basedir:producersdk\plugins\output\mkvwriter
# ADD BASE LINK32 
# ADD LINK32 /base:0x60000000 /DLL /NOLOGO /INCREMENTAL:no /MACHINE:i386 /SUBSYSTEM:windows /debug /IMPLIB:dbg32\mkvwriter.lib /DEF:mkvwriter.def /PDB:NONE /OUT:dbg32\mkvwriter.dll  ..\..\..\..\common\container\dbg32\contlib.lib ..\..\..\..\common\dbgtool\dbg32\debuglib.lib ..\..\..\..\common\fileio\dbg32\fileiolib.lib ..\..\..\..\common\runtime\dbg32\runtlib.lib ..\..\..\..\common\system\dbg32\syslib.lib ..\..\..\..\common\util\dbg32\utillib.lib ..\..\..\..\producersdk\plugins\util\dbg32\pluginutillib.lib ..\..\..\..\producersdk\common\logutil\dbg32\prodlogutillib.lib ..\..\..\..\producersdk\common\system\dbg32\prodsyslib.lib ..\..\..\..\datatype\mkv\fileformat\libebml\make\helix\dbg32\libebml.lib ..\..\..\..\datatype\mkv\fileformat\libmatroska\make\helix\dbg32\libmatroska.lib version.lib wsock32.lib kernel32.lib user32.lib advapi32.lib gdi32.lib ole32.lib comctl32.lib uuid.lib winmm.lib

!ENDIF

# Begin Target

# Name "producersdk_plugins_output_mkvwriter - Win32 Release"
# Name "producersdk_plugins_output_mkvwriter - Win32 Debug"
# Begin Group "Source Files"
# Begin Source File

SOURCE=platform\win\mkvwriter.rc
# End Source File
# Begin Source File

SOURCE=guids.cpp
# End Source File
# Begin Source File

SOURCE=mkvwriter.cpp
# End Source File
# Begin Source File

SOURCE=MatroskaMuxer.cpp
# End Source File
# Begin Source File

SOURCE=MatroskaSimpleTags.cpp
# End Source File
# Begin Source File

SOURCE=mkv_plugin.cpp
# End Source File
# End Group
# Begin Group "Header Files"
# Begin Source File

SOURCE=.\IOCallbackWrapper.h
# End Source File
# Begin Source File

SOURCE=.\MatroskaMuxer.h
# End Source File
# Begin Source File

SOURCE=.\MatroskaSimpleTags.h
# End Source File
# Begin Source File

SOURCE=.\mkvwriter.h
# End Source File
# Begin Source File

SOURCE=.\pub\hxtmkvwriter.h
# End Source File
# Begin Source File

SOURCE=.\copy\mkvwriter\IOCallbackWrapper.h
# End Source File
# Begin Source File

SOURCE=.\copy\mkvwriter\MatroskaMuxer.h
# End Source File
# Begin Source File

SOURCE=.\copy\mkvwriter\MatroskaSimpleTags.h
# End Source File
# Begin Source File

SOURCE=.\copy\mkvwriter\mkvwriter.h
# End Source File
# End Group
# End Target
# End Project
