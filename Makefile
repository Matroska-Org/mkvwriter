RM=rm -rf

RM_DIR=rm -rf

MAKE_DEP=

MAKE_DEP_FLAGS=$(INCLUDES) $(DEFINES)

LD=

LDFLAGS=

CP=copy

MAKE=nmake

RC=rc

RCFLAGS=/l 0x409 /d"_DEBUG" /d"DEBUG"  $(INCLUDES) /D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT

CC=cl

CCFLAGS=/nologo /Zp1 /Zm200 /W3 /GX- /Od  $(INCLUDES) $(DEFINES)

MC=mc

MCFLAGS=$(INCLUDES) $(DEFINES)

CC=cl

CCFLAGS=/nologo /Zp1 /Zm200 /W3 /GX- /Od  $(INCLUDES) $(DEFINES)

SRCS=platform\win\mkvwriter.rc guids.cpp mkvwriter.cpp MatroskaMuxer.cpp MatroskaSimpleTags.cpp mkv_plugin.cpp

OBJS=$(COMPILED_OBJS) $(SOURCE_OBJS)

COMPILED_OBJS=dbg32\obj\platform\win\mkvwriter.res dbg32\obj\guids.obj dbg32\obj\mkvwriter.obj dbg32\obj\MatroskaMuxer.obj dbg32\obj\MatroskaSimpleTags.obj dbg32\obj\mkv_plugin.obj

SOURCE_OBJS=

INCLUDES=/I. /I.\win /I.\pub /I.\pub\win /I..\..\..\..\common\runtime\pub /I..\..\..\..\common\include /I..\..\..\..\common\container\pub /I..\..\..\..\common\dbgtool\pub /I..\..\..\..\common\fileio\pub /I..\..\..\..\common\system\pub /I..\..\..\..\common\util\pub /I..\..\..\..\datatype\rm\include /I..\..\..\..\producersdk\include /I..\..\..\..\producersdk\common\include /I..\..\..\..\producersdk\common\container\pub /I..\..\..\..\producersdk\plugins\util\pub /I..\..\..\..\datatype\mkv\fileformat\libebml /I..\..\..\..\datatype\mkv\fileformat\libmatroska /I..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /I..\..\..\..\producersdk\common\system\pub

DEFINES=/D_WINDOWS /DSTRICT /DWIN32 /D_WIN32 /D_DEBUG /DDEBUG /DTHREADS_SUPPORTED /D_M_IX86 /D_LITTLE_ENDIAN /D_WIN32_USE_INTERLOCKED_INCREMENT

STATIC_LIBS=..\..\..\..\common\container\dbg32\contlib.lib ..\..\..\..\common\dbgtool\dbg32\debuglib.lib ..\..\..\..\common\fileio\dbg32\fileiolib.lib ..\..\..\..\common\runtime\dbg32\runtlib.lib ..\..\..\..\common\system\dbg32\syslib.lib ..\..\..\..\common\util\dbg32\utillib.lib ..\..\..\..\producersdk\plugins\util\dbg32\pluginutillib.lib ..\..\..\..\producersdk\common\logutil\dbg32\prodlogutillib.lib ..\..\..\..\producersdk\common\system\dbg32\prodsyslib.lib ..\..\..\..\datatype\mkv\fileformat\libebml\make\helix\dbg32\libebml.lib ..\..\..\..\datatype\mkv\fileformat\libmatroska\make\helix\dbg32\libmatroska.lib

DYNAMIC_LIBS=version.lib wsock32.lib kernel32.lib user32.lib advapi32.lib gdi32.lib ole32.lib comctl32.lib uuid.lib winmm.lib

RCINCLUDES=/i. /i.\win /i.\pub /i.\pub\win /i..\..\..\..\common\runtime\pub /i..\..\..\..\common\include /i..\..\..\..\common\container\pub /i..\..\..\..\common\dbgtool\pub /i..\..\..\..\common\fileio\pub /i..\..\..\..\common\system\pub /i..\..\..\..\common\util\pub /i..\..\..\..\datatype\rm\include /i..\..\..\..\producersdk\include /i..\..\..\..\producersdk\common\include /i..\..\..\..\producersdk\common\container\pub /i..\..\..\..\producersdk\plugins\util\pub /i..\..\..\..\datatype\mkv\fileformat\libebml /i..\..\..\..\datatype\mkv\fileformat\libmatroska /i..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32 /i..\..\..\..\producersdk\common\system\pub

.rc.res: 
	$(RC) $(RCFLAGS) /fo $@ $<

.c.obj: 
	$(CC) $(CCFLAGS)  /MDd /Z7 /Fo$@ /c  $<

.mc.rc: 
	$(MC) $<

.cpp.obj: 
	$(CC) $(CCFLAGS)  /MDd /Z7 /Fo$@ /c  $<

all: dbg32\obj dbg32\mkvwriter.dll

dbg32\obj: 
	-@if NOT exist "dbg32" mkdir "dbg32"
	-@if NOT exist "dbg32\obj" mkdir "dbg32\obj"

dbg32\mkvwriter.dll: $(OBJS) $(STATIC_LIBS)
	-@if NOT exist "dbg32" mkdir "dbg32"
	python c:\DOCUME~1\JORY~2.JCS\MYDOCU~1\VISUAL~1\MATROSKA\HELIX_~1\ribosome\build\bin\pylink -basefile:..\..\..\..\debug\rebase.lst -basedir:producersdk\plugins\output\mkvwriter /base:0x60000000 /DLL /NOLOGO /INCREMENTAL:no /MACHINE:i386 /SUBSYSTEM:windows /debug /IMPLIB:dbg32\mkvwriter.lib /DEF:mkvwriter.def /PDB:NONE /OUT:dbg32\mkvwriter.dll $(OBJS) $(STATIC_LIBS) $(DYNAMIC_LIBS)

dbg32\obj\platform\win\mkvwriter.res: platform\win\mkvwriter.rc
	-@if NOT exist "dbg32" mkdir "dbg32"
	-@if NOT exist "dbg32\obj" mkdir "dbg32\obj"
	-@if NOT exist "dbg32\obj\platform" mkdir "dbg32\obj\platform"
	-@if NOT exist "dbg32\obj\platform\win" mkdir "dbg32\obj\platform\win"
	$(RC) $(RCFLAGS) /fo dbg32\obj\platform\win\mkvwriter.res platform\win\mkvwriter.rc

dbg32\obj\guids.obj: guids.cpp
	-@if NOT exist "dbg32" mkdir "dbg32"
	-@if NOT exist "dbg32\obj" mkdir "dbg32\obj"
	$(CC) $(CCFLAGS)  /MDd /Z7 /Fodbg32\obj\guids.obj /c  guids.cpp

dbg32\obj\mkvwriter.obj: mkvwriter.cpp
	-@if NOT exist "dbg32" mkdir "dbg32"
	-@if NOT exist "dbg32\obj" mkdir "dbg32\obj"
	$(CC) $(CCFLAGS)  /MDd /Z7 /Fodbg32\obj\mkvwriter.obj /c  mkvwriter.cpp

dbg32\obj\MatroskaMuxer.obj: MatroskaMuxer.cpp
	-@if NOT exist "dbg32" mkdir "dbg32"
	-@if NOT exist "dbg32\obj" mkdir "dbg32\obj"
	$(CC) $(CCFLAGS)  /MDd /Z7 /Fodbg32\obj\MatroskaMuxer.obj /c  MatroskaMuxer.cpp

dbg32\obj\MatroskaSimpleTags.obj: MatroskaSimpleTags.cpp
	-@if NOT exist "dbg32" mkdir "dbg32"
	-@if NOT exist "dbg32\obj" mkdir "dbg32\obj"
	$(CC) $(CCFLAGS)  /MDd /Z7 /Fodbg32\obj\MatroskaSimpleTags.obj /c  MatroskaSimpleTags.cpp

dbg32\obj\mkv_plugin.obj: mkv_plugin.cpp
	-@if NOT exist "dbg32" mkdir "dbg32"
	-@if NOT exist "dbg32\obj" mkdir "dbg32\obj"
	$(CC) $(CCFLAGS)  /MDd /Z7 /Fodbg32\obj\mkv_plugin.obj /c  mkv_plugin.cpp

clean: 
	$(RM)  dbg32\mkvwriter.dll $(COMPILED_OBJS)

..\..\..\..\debug\mkvwriter.dll: dbg32\mkvwriter.dll
	-@if NOT exist "..\..\..\..\debug" mkdir "..\..\..\..\debug"
	rm -rf "..\..\..\..\debug\mkvwriter.dll"
	copy "dbg32\mkvwriter.dll" "..\..\..\..\debug\mkvwriter.dll"

copy: ..\..\..\..\debug\mkvwriter.dll

depend: 
	python c:\DOCUME~1\JORY~2.JCS\MYDOCU~1\VISUAL~1\MATROSKA\HELIX_~1\ribosome\build\bin\mkdepend /tdbg32\obj /mMakefile $(DEFINES) $(INCLUDES) $(SRCS)

# DO NOT DELETE -- mkdepend depends on this line
dbg32\obj\platform\win\mkvwriter.res: "platform\win\mkvwriter.rc"
dbg32\obj\platform\win\mkvwriter.res: "..\..\..\..\common\include\hxver.h"
dbg32\obj\platform\win\mkvwriter.res: "..\..\..\..\common\include\rnver.h"
dbg32\obj\platform\win\mkvwriter.res: "..\..\..\..\producersdk\include\prodver.ver"
dbg32\obj\guids.obj: "guids.cpp"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxtbase.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxtpropertybag.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxcom.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxtypes.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxbastsd.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxresult.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxiids.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxpiids.h"
dbg32\obj\guids.obj: "..\..\..\..\common\runtime\pub\hlxclib/string.h"
dbg32\obj\guids.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_stdc.h"
dbg32\obj\guids.obj: "..\..\..\..\common\runtime\pub\hlxclib/stdlib.h"
dbg32\obj\guids.obj: "..\..\..\..\common\runtime\pub\hlxclib/memory.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\atomicbase.h"
dbg32\obj\guids.obj: "..\..\..\..\common\system\pub\microsleep.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxmutexlock.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxengin.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\common\include\hxtsmartpointer.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxccf.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxteventcodes.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxtconstants.h"
dbg32\obj\guids.obj: "..\..\..\..\common\include\hxevtype.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxtaudioformat.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxtbaseinternal.h"
dbg32\obj\guids.obj: ".\pub\hxtmkvwriter.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxtlogsystem.h"
dbg32\obj\guids.obj: "..\..\..\..\producersdk\include\ihxtlogsystemcontext.h"
dbg32\obj\mkvwriter.obj: "mkvwriter.cpp"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxcom.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxtypes.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxbastsd.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxresult.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxiids.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxpiids.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/string.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_stdc.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/stdlib.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/memory.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\atomicbase.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\system\pub\microsleep.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxmutexlock.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxengin.h"
dbg32\obj\mkvwriter.obj: ".\pub\hxtmkvwriter.h"
dbg32\obj\mkvwriter.obj: ".\mkvwriter.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\unkimp.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\dbgtool\pub\hxassert.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/assert.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_debug.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/limits.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/stdio.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_fs.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/sys/types.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/time.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_timeutil.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxclib/windows.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\hlxosstr.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\runtime\pub\platform/wince/get_disk_free.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\util\pub\platform/mac/maclibrary.h"
dbg32\obj\mkvwriter.obj: "C:\PROGRA~1\MICROS~3\VC98\INCLUDE\windows.h"
dbg32\obj\mkvwriter.obj: "C:\PROGRA~1\MICROS~3\VC98\INCLUDE\signal.h"
dbg32\obj\mkvwriter.obj: "C:\PROGRA~1\MICROS~3\VC98\INCLUDE\stdlib.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\fileio\pub\chxdataf.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\fileio\pub\chxdataf_stdio.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\ihxfgbuf.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\fileio\pub\chxdataf_virtual.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\hxstring.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\system\pub\globals/hxglobalchxstring.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\system\pub\hxglobalmgr.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\ihxiunknowntracker.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\include\ihxtbase.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\include\ihxtpropertybag.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\common\include\hxtsmartpointer.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxccf.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\include\ihxteventcodes.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\include\ihxtconstants.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxevtype.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\include\ihxtaudioformat.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\include\ihxtbaseinternal.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\plugins\util\pub\hxtconfigagent.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\common\container\pub\utstring.h"
dbg32\obj\mkvwriter.obj: ".\MatroskaMuxer.h"
dbg32\obj\mkvwriter.obj: ".\MatroskaSimpleTags.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlTypes.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/c/libebml_t.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlConfig.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlString.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlUnicodeString.h"
dbg32\obj\mkvwriter.obj: ".\IOCallbackWrapper.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/IOCallback.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/StdIOCallback.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32\WinIOCallback.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlHead.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlVoid.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlCrc32.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlSubHead.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlStream.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlBinary.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlContexts.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlVersion.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxConfig.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxBlock.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTypes.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/c/libmatroska_t.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlMaster.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTracks.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlUInteger.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackEntryData.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlFloat.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxBlockData.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlSInteger.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxSegment.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxContexts.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlElement.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxSeekHead.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxInfo.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxInfoData.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlDate.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTags.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTag.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTagMulti.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCluster.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCues.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxClusterData.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackAudio.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackVideo.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCuesData.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxAttachments.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxAttached.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxVersion.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\plugins\util\pub\hxtasmconnectprop.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\rmfftype.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\rule2flg.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxinline.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\util\pub\netbyte.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\datatype\rm\include\hxmime.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\chxpckts.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxcppflags.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\old_hxpckts.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\hxmap.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\chxmapptrtoptr.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\carray.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\hxmaputils.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\chxmapbuckets.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\chxmapstringtoob.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\chxmapstringtostring.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\chxmaplongtoobj.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\ihxpckts.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxvalue.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\hxbuffer.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\container\pub\assocvector.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\common\include\hxtlogutil.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\producersdk\include\ihxtlogsystem.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxheap.h"
dbg32\obj\mkvwriter.obj: "..\..\..\..\common\include\hxhpbase.h"
dbg32\obj\MatroskaMuxer.obj: "MatroskaMuxer.cpp"
dbg32\obj\MatroskaMuxer.obj: ".\MatroskaMuxer.h"
dbg32\obj\MatroskaMuxer.obj: ".\MatroskaSimpleTags.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlTypes.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/c/libebml_t.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlConfig.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlString.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlUnicodeString.h"
dbg32\obj\MatroskaMuxer.obj: ".\IOCallbackWrapper.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/IOCallback.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/StdIOCallback.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32\WinIOCallback.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlHead.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlVoid.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlCrc32.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlSubHead.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlStream.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlBinary.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlContexts.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlVersion.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxConfig.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxBlock.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTypes.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/c/libmatroska_t.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlMaster.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTracks.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlUInteger.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackEntryData.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlFloat.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxBlockData.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlSInteger.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxSegment.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxContexts.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlElement.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxSeekHead.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxInfo.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxInfoData.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlDate.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTags.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTag.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTagMulti.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCluster.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCues.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxClusterData.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackAudio.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackVideo.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCuesData.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxAttachments.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxAttached.h"
dbg32\obj\MatroskaMuxer.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxVersion.h"
dbg32\obj\MatroskaSimpleTags.obj: "MatroskaSimpleTags.cpp"
dbg32\obj\MatroskaSimpleTags.obj: ".\MatroskaSimpleTags.h"
dbg32\obj\mkv_plugin.obj: "mkv_plugin.cpp"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\include\ihxtbase.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\include\ihxtpropertybag.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxcom.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxtypes.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxbastsd.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxresult.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxiids.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxpiids.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/string.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_stdc.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/stdlib.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/memory.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\atomicbase.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\system\pub\microsleep.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxmutexlock.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxengin.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\common\include\hxtsmartpointer.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxccf.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\include\ihxteventcodes.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\include\ihxtconstants.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxevtype.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\include\ihxtaudioformat.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\include\ihxtbaseinternal.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\unkimp.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\dbgtool\pub\hxassert.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/assert.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_debug.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/limits.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/stdio.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_fs.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/sys/types.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/time.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\platform/openwave/hx_op_timeutil.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxclib/windows.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\hlxosstr.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\runtime\pub\platform/wince/get_disk_free.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\util\pub\platform/mac/maclibrary.h"
dbg32\obj\mkv_plugin.obj: "C:\PROGRA~1\MICROS~3\VC98\INCLUDE\windows.h"
dbg32\obj\mkv_plugin.obj: "C:\PROGRA~1\MICROS~3\VC98\INCLUDE\signal.h"
dbg32\obj\mkv_plugin.obj: "C:\PROGRA~1\MICROS~3\VC98\INCLUDE\stdlib.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\fileio\pub\chxdataf.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\fileio\pub\chxdataf_stdio.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\ihxfgbuf.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\fileio\pub\chxdataf_virtual.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\hxstring.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\system\pub\globals/hxglobalchxstring.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\system\pub\hxglobalmgr.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\ihxiunknowntracker.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxcomm.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxplugn.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxplugncompat.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxplgns.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\ihxpckts.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxvalue.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\hxasvect.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\include\hxcppflags.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\assocvector.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\hxmap.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\chxmapptrtoptr.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\carray.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\hxmaputils.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\chxmapbuckets.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\chxmapstringtoob.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\chxmapstringtostring.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\chxmaplongtoobj.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\hxguidmap.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\chxmapguidtoobj.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\hxguid.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\hxbuffer.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\chxpckts.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\container\pub\old_hxpckts.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\include\ihxtplugininfobase.h"
dbg32\obj\mkv_plugin.obj: ".\pub\hxtmkvwriter.h"
dbg32\obj\mkv_plugin.obj: ".\mkvwriter.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\plugins\util\pub\hxtconfigagent.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\producersdk\common\container\pub\utstring.h"
dbg32\obj\mkv_plugin.obj: ".\MatroskaMuxer.h"
dbg32\obj\mkv_plugin.obj: ".\MatroskaSimpleTags.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlTypes.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/c/libebml_t.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlConfig.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlString.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlUnicodeString.h"
dbg32\obj\mkv_plugin.obj: ".\IOCallbackWrapper.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/IOCallback.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/StdIOCallback.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\src\platform\win32\WinIOCallback.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlHead.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlVoid.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlCrc32.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlSubHead.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlStream.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlBinary.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlContexts.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlVersion.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxConfig.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxBlock.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTypes.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/c/libmatroska_t.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlMaster.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTracks.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlUInteger.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackEntryData.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlFloat.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxBlockData.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlSInteger.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxSegment.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxContexts.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlElement.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxSeekHead.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxInfo.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxInfoData.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libebml\ebml/EbmlDate.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTags.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTag.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTagMulti.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCluster.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCues.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxClusterData.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackAudio.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxTrackVideo.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxCuesData.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxAttachments.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxAttached.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\datatype\mkv\fileformat\libmatroska\matroska/KaxVersion.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\system\pub\dllpath.h"
dbg32\obj\mkv_plugin.obj: "..\..\..\..\common\system\pub\globals/hxglobals.h"
