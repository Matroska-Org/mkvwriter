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

#ifndef _HXT_MKV_WRITER_GUID_H_
#define _HXT_MKV_WRITER_GUID_H_


static const char kValuePluginNameFileDestMkv[] =			"rn-file-mkv";					/* string */

// {DE22A473-C3AE-4601-A903-25C072D7B19E}
DEFINE_GUID(CLSID_RSMAOutputMkvWriter,
	    0xde22a473, 0xc3ae, 0x4601, 0xa9, 0x3, 0x25, 0xc0, 0x72, 0xd7, 0xb1, 0x9e);

#define VORBISAUDIO_MIME_TYPE		"audio/x-rn-ogg"


#endif // _HXT_MKV_WRITER_GUID_H_
