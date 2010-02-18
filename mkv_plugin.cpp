/* ***** BEGIN LICENSE BLOCK ***** 
* Version: RCSL 1.0/RPSL 1.0 
*  
* Copyright (C) 2004, Jory Stone <jcsston @ toughguy.net>
* Portions Copyright (c) 1995-2002 RealNetworks, Inc. All Rights Reserved. 
*      
* The contents of this file, and the files included with this file, are 
* subject to the current version of the RealNetworks Public Source License 
* Version 1.0 (the "RPSL") available at 
* http://www.helixcommunity.org/content/rpsl unless you have licensed 
* the file under the RealNetworks Community Source License Version 1.0 
* (the "RCSL") available at http://www.helixcommunity.org/content/rcsl, 
* in which case the RCSL will apply. You may also obtain the license terms 
* directly from RealNetworks.  You may not use this file except in 
* compliance with the RPSL or, if you have a valid RCSL with RealNetworks 
* applicable to this file, the RCSL.  Please see the applicable RPSL or 
* RCSL for the rights, obligations and limitations governing use of the 
* contents of the file.  
*  
* This file is part of the Helix DNA Technology. RealNetworks is the 
* developer of the Original Code and owns the copyrights in the portions 
* it created. 
*  
* This file, and the files included with this file, is distributed and made 
* available on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER 
* EXPRESS OR IMPLIED, AND REALNETWORKS HEREBY DISCLAIMS ALL SUCH WARRANTIES, 
* INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS 
* FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. 
* 
* Technology Compatibility Kit Test Suite(s) Location: 
*    http://www.helixcommunity.org/content/tck 
* 
* Contributor(s): 
*  
* ***** END LICENSE BLOCK ***** */ 

#include "ihxtbase.h"					// abstract base pin and filter interfaces

#include "unkimp.h"
#include "ihxtconstants.h"

// rma plugin includes
#include "hxcomm.h"	
#include "hxplugn.h"	
#include "hxplgns.h"	
#include "ihxpckts.h"	

// other plugin includes
#include "hxasvect.h"
#include "hxbuffer.h"
#include "chxpckts.h"
#include "ihxtplugininfobase.h"

#include "hxtmkvwriter.h"
#include "mkvwriter.h"

/////////////////////////////////////////////////////////////////////////
//
//	STEP 1	Fill in name of the base class agent used by this plugin 
//			this typedef will be passed into the helper template classe 
typedef CMkvWriter BASECLASSAGENT;

/////////////////////////////////////////////////////////////////////////
//
//	STEP 1b	Fill in a unique string for the ENABLE_DLLACCESS_PATHS macro below
//		
#include "dllpath.h"						
ENABLE_DLLACCESS_PATHS( MkvWriter );



/////////////////////////////////////////////////////////////////////////
//
//	STEP 2  Fill in your plugin description and other strings and values
//			used by the template helper
//

static const char kValueDescription[]  =		"Writes Matroska files";
static const char kValueRealCopyright[]   =		"(c) 2003-2004 Jory Stone (jcsston@toughguy.net) Portions (c) 2001 RealNetworks, All rights reserved";
static const char kValueGenericMoreInfoURL[] =	"http://www.matroska.org";
static const INT32 kDefaultPluginVersion =	0;


/////////////////////////////////////////////////////////////////////////
// Plugin Property Table ( Change to fit this type of plugin) 
//	table that maps strings, uints and buffers to searchable values by pluginhandler
//
CHXTExternalPluginHelper< BASECLASSAGENT >::SValueEntry 
CHXTExternalPluginHelper< BASECLASSAGENT >::s_pPluginInfo[] =
{	
    //	STEP 3) fill in appropriate string categories for this type of plugin
    { eStringType,	kPropComponentName,		(void*) kValuePluginNameFileDestMkv,			NULL },
    { eStringType,	kPropPluginName,		(void*) kValuePluginNameFileDestMkv,			NULL },
    { eStringType,	kPropPluginType,		(void*) kValuePluginTypeDestinationFile,NULL },
    { eStringType,	kPropPluginCategory,	(void*) kValuePluginCategoryDestinationFile,	NULL },
    
    { eStringType,	kPropPluginLongName,	(void*) "Helix Mkv Writer",			NULL },
    
    //  STEP 4) fill in the use preference field
    { eStringType,	kPropFileExtensions,	(void*) ".MKA:80,.MKV:80,",					NULL	},
    
    //  STEP 5) fill in the clsid for this plugin
    { eBufferType,	kPropComponentCLSID,	(void*) &CLSID_RSMAOutputMkvWriter,		sizeof(CLSID)	},
    
    { eEndType,		NULL,					(void*) NULL,								NULL	}
};

/////////////////////////////////////////////////////////////////////////
// Method:
//	HXCREATEINSTANCE
// Purpose:
//	creates a new instance of this class using the template helper.
STDAPI HXCREATEINSTANCE(IUnknown** ppAnyUnknown )
{
    *ppAnyUnknown = (IUnknown*)(IHXPlugin*) new CHXTExternalPluginHelper< BASECLASSAGENT >;
    if (*ppAnyUnknown != NULL)
    {
	(*ppAnyUnknown)->AddRef();
	return HXR_OK;
    }
    return HXR_OUTOFMEMORY;
}

/////////////////////////////////////////////////////////////////////////
// Method:
//	HXSHUTDOWN
// Purpose:
//	DLL Entry point for shutdown 
STDAPI HXSHUTDOWN(void)
{
    return HXR_OK;
}


