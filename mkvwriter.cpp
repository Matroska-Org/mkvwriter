/* ***** BEGIN LICENSE BLOCK ***** 
* Version: RCSL 1.0/RPSL 1.0 
*  
* Copyright (C) 2003-2004, Jory Stone <jcsston @ toughguy.net>
*	Portions Copyright (c) 2003-2004 Gabest. http://www.gabest.org
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

#ifdef _WIN32
#pragma warning ( disable : 4786 4530 )
#endif

#include "hxcom.h"
#include "hxtmkvwriter.h"
#include "mkvwriter.h"

#include "ihxtconstants.h"

#include "hxtasmconnectprop.h"

#include "rmfftype.h"
#include "netbyte.h"
#include "hxmime.h"

#include "chxdataf.h"
#include <fcntl.h>

#include "chxpckts.h"  // For CHXHeader
#include "ihxteventcodes.h"

#include "hxtlogutil.h"

// For heap checking
#include "hxheap.h"
#ifdef _DEBUG
#undef HX_THIS_FILE		
static char HX_THIS_FILE[] = __FILE__;
#endif


HXT_MAKE_SMART_PTR(IUnknown);

/*!

\todo IHXFileFormatObject looks a mp3\fileformat for example
\todo Do I need the IHXFileWriter interface?
\todo IHXStreamDescription looks good for a matroska reader
*/

// Implements basic IUnknown functionality
BEGIN_INTERFACE_LIST(CMkvWriter)
	INTERFACE_LIST_ENTRY_SIMPLE(IHXTOutputFilter)
	INTERFACE_LIST_ENTRY_SIMPLE(IHXTConfigurationAgent)
	INTERFACE_LIST_ENTRY_SIMPLE(IHXTConnectionAgent)
	INTERFACE_LIST_ENTRY_SIMPLE(IHXTFilter)
END_INTERFACE_LIST

//////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::CMkvWriter
// Purpose:
//	Constructor.  
CMkvWriter::CMkvWriter() :
m_ulInputCount(0)
{

}


//////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::~CMkvWriter
// Purpose:
//	Destructor
CMkvWriter::~CMkvWriter()
{
	size_t t;

	for (t = 0; t < m_Tracks.size(); t++)
		delete m_Tracks[t];	
}


/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::OnInitialize
// Purpose:
//	Handle properties that can only be set during initialization.
STDMETHODIMP CMkvWriter::OnInitialize( IHXTPropertyBag* pInitPropBag, IHXTPropertyBag* pConsumedPropBag, IHXTPropertyBag* pErrorBag )
{
	HXTrace("CMkvWriter::OnInitialize");

	HX_RESULT res = HXR_OK;

	// Set real-time property 
	GetActualPropertyBag().SetBool(kPropIsRealTime, FALSE);
	GetActualPropertyBag().SetString(kPropPluginName, kValuePluginNameFileDestMkv);
	
	IHXTPropertyBag *pMatroskaBag;
	res = pInitPropBag->GetPropertyBag("matroskaSettings", &pMatroskaBag);
	
	if (SUCCEEDED(res)) {
		IHXTPropertyEnumerator *pMatroskaPropEnum;
		res = pMatroskaBag->GetPropertyEnumerator(&pMatroskaPropEnum);
		
		while (SUCCEEDED(res)) {
			IHXTProperty *pMatroskaPropEntry;
			res = pMatroskaPropEnum->Next(&pMatroskaPropEntry);
			
			if (FAILED(res) || res == HXR_ELEMENT_NOT_FOUND)
				break;

			if (!stricmp(pMatroskaPropEntry->GetKey(), "matroskaTag")) {
				const char *tag;
				res = pMatroskaPropEntry->GetString(&tag);

				if (SUCCEEDED(res) && tag != NULL) {
					std::string tagSplit;
					tagSplit = tag;
					
					if (strchr(tagSplit.c_str(), '=') != NULL) {
						
						tagSplit[strchr(tagSplit.c_str(), '=')-tagSplit.c_str()] = 0;
					

						m_Muxer.Set_Tag(0, tagSplit.c_str(), strlen(tagSplit.c_str())+tagSplit.c_str()+1);
					}
				}
			} else if (!stricmp(pMatroskaPropEntry->GetKey(), "matroskaTrack")) {

			}
		}
		
		res = pInitPropBag->Remove("matroskaSettings");
	}

	return HXR_OK;
}


//////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::SetFileHeader
// Purpose:
//	Sets the output file header.  Init must have been 
//	successfully called first.  Must be called exactly
//	once.
STDMETHODIMP CMkvWriter::SetFileHeader(THIS_ IHXValues* pFileHeader)
{
	HX_RESULT res = HXR_OK;

	// Validate params, state
	if (!pFileHeader)
	{
		HX_ASSERT(FALSE);
		return HXR_POINTER;
	}
	const char *test = NULL;
	IHXBuffer *pValueBuffer = NULL;
	
	res = pFileHeader->GetPropertyCString("title", pValueBuffer);
	if (SUCCEEDED(res)) 
	{
		test = (const char*)pValueBuffer->GetBuffer();
	}

	res = pFileHeader->GetPropertyCString("encoded_by", pValueBuffer);
	if (SUCCEEDED(res)) 
	{
		test = (const char*)pValueBuffer->GetBuffer();
	}

	// Get the total number of streams
	res = pFileHeader->GetPropertyULONG32("StreamCount", m_ulInputCount);

	// Sanity check num streams -- only 254 input streams are supported ;P
	if (SUCCEEDED(res)) 
	{
		//	Stream Count Verification
		if(m_ulInputCount > 254)
		{
			HXTLOG_APPROVED(LC_APP_ERROR,FILEOUT,"Invalid number of streams %d provided to the mkv file writer.", m_ulInputCount);
			HX_ASSERT(FALSE);
			res = HXR_FAIL;
		}
	}


	return res;
}

//////////////////////////////////////////////////////////
// Method:
//	CHXTFFOutputBase::SetStreamHeader
// Purpose:
//	Must be called exactly once per logical stream.  FileHeaderReady
//	must have already been called.
STDMETHODIMP CMkvWriter::SetStreamHeader(THIS_ UINT32 ulStreamNumber, IHXValues* pStreamHeader)
{
	HX_RESULT res = HXR_OK;

	if (pStreamHeader != NULL)
	{
		IHXBuffer* pBufMimeType = NULL;
		res = pStreamHeader->GetPropertyCString("MimeType", pBufMimeType);
		//	MimeType Verification
		if(SUCCEEDED(res))
		{
			const char *streamMimeType = (const char*)pBufMimeType->GetBuffer();
			
			if(!stricmp(streamMimeType, "video/x-pn-realvideo")) {
				// Get the opaque data
				IHXBuffer* pBuffer = NULL;
				res = pStreamHeader->GetPropertyBuffer("OpaqueData", pBuffer);
				
				if (SUCCEEDED(res)) {
						UINT8* pCursor = pBuffer->GetBuffer();
						UINT32 ulSize = pBuffer->GetSize();
						
						MultiStreamHeader multiHeader;
						VideoTypeSpecificData videoHeader;
						UINT8 *unpacked = multiHeader.unpack(pCursor, ulSize);																		
						videoHeader.unpack(unpacked+4, ulSize);

						m_Muxer.Set_Track_CodecPrivate(ulStreamNumber+1, (binary *)unpacked+4, ulSize);
						
						char fourcc[6];
						memset(fourcc, 0, 5);
						memcpy(fourcc, &videoHeader.submoftag, 4);

						std::string codecID = "V_REAL/RV00";
						codecID[9] = fourcc[1];

						m_Muxer.Set_Track_CodecID(ulStreamNumber+1, codecID);

						m_Muxer.Set_Track_Video(ulStreamNumber+1, videoHeader.uiWidth, videoHeader.uiHeight);

						m_Tracks.push_back(new HelixTrack(new CRealVideoAssembler()));
				} else {
					HXTLOG_APPROVED(LC_SDK_ERROR,FILEOUT,"Failure to retrieve Opaque Data from the stream header.");
				}

#if 0
			} else if(!stricmp(streamMimeType, VORBISAUDIO_MIME_TYPE)) {
				// Get the opaque data
				IHXBuffer* pBuffer = NULL;
				res = pStreamHeader->GetPropertyBuffer("OpaqueData", pBuffer);
				
				if (SUCCEEDED(res)) {
						UINT8* pCursor = pBuffer->GetBuffer();
						UINT32 ulSize = pBuffer->GetSize();
						
						m_Muxer.Set_Track_CodecPrivate(ulStreamNumber+1, (binary *)pCursor, ulSize);
				}

			} else if(!stricmp(streamMimeType, "audio/x-ralf-mpeg4-generic")) {
				
				// Get the opaque data
				IHXBuffer* pBuffer = NULL;
				res = pStreamHeader->GetPropertyBuffer("OpaqueData", pBuffer);

				if (SUCCEEDED(res)) {
						UINT8* pCursor = pBuffer->GetBuffer();
						UINT32 ulSize = pBuffer->GetSize();

						MultiStreamHeader multiHeader;
						UINT8 *unpacked = multiHeader.unpack(pCursor, ulSize);												
												
						std::string codecID = "A_REAL/";
						char fourcc[6];
						memset(fourcc, 0, 5);
						UINT8 *extra = (UINT8 *)unpacked;						
						float sample_rate = 0;

				}
#endif

			} else if(!stricmp(streamMimeType, "audio/x-pn-realaudio")) {

				// Get the opaque data
				IHXBuffer* pBuffer = NULL;
				res = pStreamHeader->GetPropertyBuffer("OpaqueData", pBuffer);
				
				if (SUCCEEDED(res)) {					
						UINT8* pCursor = pBuffer->GetBuffer();
						UINT32 ulSize = pBuffer->GetSize();
						
						MultiStreamHeader multiHeader;
						UINT8 *unpacked = multiHeader.unpack(pCursor, ulSize);												
												
						std::string codecID = "A_REAL/";
						char fourcc[6];
						memset(fourcc, 0, 5);
						UINT8 *extra = (UINT8 *)unpacked;						
						float sample_rate = 0;

						std::vector<BYTE> audioHeaderBuffer;
						audioHeaderBuffer.resize(ulSize);
						memcpy(&audioHeaderBuffer[0], unpacked+4, ulSize);
						
						rainfo *audioTest = (rainfo *)(&audioHeaderBuffer[0]);
						audioTest->bswap();
						ulSize = audioTest->header_size + 16;
						if (audioTest->version1 == 4) {
							rainfo4 *audioHeader = (rainfo4 *)audioTest;
							audioHeader->bswap();
					
							
							char* p = (char*)((rainfo4*)audioTest+1);
							int len = *p++; 
							p += len; 
							len = *p++; 
							HX_ASSERT(len == 4);
							if(len == 4) {
								memcpy(fourcc, p, 4);
								strupr(fourcc);
								codecID += fourcc;
							} else {
								HXTLOG_APPROVED(LC_APP_WARN,FILEOUT, "Unknown audio type for track %i provided to the mkv file writer.", ulStreamNumber);
							}							
							extra = (UINT8 *)p + len + 3;

							sample_rate = audioHeader->sample_rate;
							m_Muxer.Set_Track_Audio(ulStreamNumber+1, audioHeader->channels, sample_rate, audioHeader->sample_size);

						} else if (audioTest->version1 == 5) {
							rainfo5 *audioHeader = (rainfo5 *)audioTest;
							audioHeader->bswap();
							
							extra = (UINT8 *)&audioHeaderBuffer[0] + sizeof(rainfo5) + 4;

							memcpy(fourcc, &audioHeader->fourcc3, 4);
							strupr(fourcc);							
							codecID += fourcc;

							sample_rate = audioHeader->sample_rate;
							m_Muxer.Set_Track_Audio(ulStreamNumber+1, audioHeader->channels, sample_rate, audioHeader->sample_size);

						} else {
							// Error unknown version
							HXTLOG_APPROVED(LC_APP_ERROR,FILEOUT,"Unknown audio codec version specified for the mkv file writer.");
							res = HXR_FAIL;
							return res;
						}

						// If we have gotten this far, it looks like smooth sailing from here :)
						HelixTrack *newTrack = new HelixTrack();

						if (!stricmp(fourcc, "DNET")) {
							codecID = "A_AC3";

						} else if (!stricmp(fourcc, "RAAC") || !stricmp(fourcc, "RACP")) {																							
							UINT32 extralen = RMUnpackUINT32(extra);

							HX_ASSERT(*extra == 2); // always 2? why? what does it mean?
							extra++; 
							extralen--;						
														
							//m_Muxer.Set_Track_CodecPrivate(ulStreamNumber+1, (binary *)extra, extralen);						

							int profile = (extra[0]>>3)-1;
							int	rate1 = ((extra[0]&7)<<1)|(extra[1]>>7);
							int channels = ((extra[1]>>3)&15);
							int exttype = 0;
							int rate2 = rate1;

							if(extralen >= 5)
							{
								profile = 4;

								exttype = (extra[2]<<3)|(extra[3]>>5);
								HX_ASSERT(exttype == 0x2B7);
								HX_ASSERT((extra[3]&31) == 5);
								HX_ASSERT((extra[4]>>7) == 1);
								rate2 = ((extra[4]>>3)&15);

								if(rate2 < rate1)
								{
									m_Muxer.Set_Track_Audio(ulStreamNumber+1, 0, sample_rate/2, 0, sample_rate);
								}
							}

							switch(profile)
							{
								default:
								case 0: codecID = "A_AAC/MPEG2/MAIN"; break;
								case 1: codecID = "A_AAC/MPEG2/LC"; break;
								case 2: codecID = "A_AAC/MPEG2/SSR"; break;
								case 3: codecID = "A_AAC/MPEG4/LTP"; break;
								case 4: codecID = "A_AAC/MPEG4/LC/SBR"; break;
							}
							newTrack->assembler = new CRealAACAssembler(channels, sample_rate);
						} else {
							m_Muxer.Set_Track_CodecPrivate(ulStreamNumber+1, (binary *)unpacked+4, ulSize);						
						}

						m_Muxer.Set_Track_CodecID(ulStreamNumber+1, codecID);
						m_Muxer.Set_Track_Lacing(ulStreamNumber+1, false);
						
						m_Tracks.push_back(newTrack);
				} else {
					HXTLOG_APPROVED(LC_SDK_ERROR,FILEOUT,"Failure to retrieve Opaque Data from the stream header.");
				}

			} else {
				res = HXR_FAIL;
				HXTLOG_APPROVED(LC_APP_ERROR,FILEOUT,"Invalid codec specified for the mkv file writer.");
			}
		}
	}
	else
	{
		res = HXR_POINTER;
		HXTLOG_APPROVED(LC_SDK_ERROR,FILEOUT,"Invalid pointer passed in as a stream header.");
	}

	HX_ASSERT(SUCCEEDED(res));

	return res;
}



/////////////////////////////////////////////////////////////////////////
// Method:
//	COggWriter::ReceiveSample
// Purpose:
//	Receives samples from input pin.  Expects each sample to have HXT_FIELD_LOGICAL_STREAM_ID, 
//	RS_FIELD_ASM_RULE. and HXT_FIELD_ASM_FLAGS fields set.
STDMETHODIMP CMkvWriter::ReceiveSample(UINT32 uInputStreamID, IHXTMediaSample* pSample)
{
#ifdef _DEBUG
	static FILE *debug = fopen("D:\\debug.log", "w");
#endif
	HX_RESULT res = HXR_OK;

#ifdef _DEBUG
	UINT32 sampleField = 0;
	for (int i = 0; i < 9; i++) {
		pSample->GetSampleField(i, &sampleField);
		sampleField;
		fprintf(debug, "GetSampleField(), i = %i , sampleField = %i\n", i, sampleField);
	}
#endif

	pSample->GetSampleField(HXT_FIELD_LOGICAL_STREAM_ID, &uInputStreamID);
	
	HX_ASSERT(uInputStreamID < m_ulInputCount+1);
	
	if (pSample->GetDataSize() > 0) {
		HXT_TIME htStart = 0;
		HXT_TIME htEnd = 0;

		pSample->GetTime(&htStart, &htEnd);

	#ifdef _DEBUG	
		fprintf(debug, "CMkvWriter::ReceiveSample(), uInputStreamID = %i, htStart = %i, htEnd = %i, size = %i\n", uInputStreamID, (long)htStart, (long)htEnd, (long)pSample->GetDataSize());
	#endif


		UINT32 field;
		pSample->GetSampleField(HXT_FIELD_ASM_RULE, &field);
		if (field == 2) {
			// Dup packets ?
			return res;
		}

		int32 reference = 0;
		if (!(pSample->GetSampleFlags() & HXT_SAMPLE_KEYFRAME))
			reference = MatroskaMuxer::REFERENCE_PREV_FRAME;
		
		HelixTrack *track = m_Tracks.at(uInputStreamID);		

		// Lots of streams need to be packeted			
		m_PointerPacket.rtStart = htStart;
		m_PointerPacket.rtStop = htEnd;
		m_PointerPacket.data = (UINT8 *)pSample->GetDataStartForReading();
		m_PointerPacket.dataSize = pSample->GetDataSize();

		track->assembler->FeedPacket(&m_PointerPacket);

		CAssembler::Packet *p = NULL;
		
		track->assembler->PacketReady(&p);
		
		while (p != NULL) {
			res = m_Muxer.AddFrame(uInputStreamID+1, p->rtStart, (p->rtStop-p->rtStart), (binary *)p->GetData(), p->GetDataSize(), reference);

			track->assembler->PacketReady(&p);
		} 
		

	}
	if (res) {
		res = HXR_FAIL;
		HXTLOG_APPROVED(LC_APP_ERROR,FILEOUT,"MatroskaMuxer::AddFrame() call in mkv file writer failed.");
	}
	// Check for end-of-stream
	if (pSample->GetSampleFlags() & HXT_SAMPLE_ENDOFSTREAM)
	{
		UINT32 ulStreamId = 0;
		m_spEventSink->HandleEvent( eEventOutputFilterStreamDone, &ulStreamId, NULL, CUnknownIMP::GetUnknown() );
		//m_Muxer.CloseFile();
	}

	return res;
}




/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::Prime
// Purpose:
//	Notification that the filter is about to receive data
STDMETHODIMP CMkvWriter::Prime( UINT32 ulInputStreamID )
{
	HX_RESULT res = HXR_OK;
	
	// Validate params
	if(ulInputStreamID == 0)
	{
		// Open the output file for writing			
		res = m_Muxer.Set_OutputFilename(m_strOutputPathname);
		m_Muxer.Set_WritingApp(L"Helix Producer MKV Output Plugin");
		
		// Process file/stream headers
		if (SUCCEEDED(res))
		{
			// Get the connecting ASM header source
			IUnknownPtr spConnectingProp;
			res = m_spConnectedInputFormat->GetUnknown(kPropAsmHeaders, spConnectingProp.Adopt());
			
			IHXTAsmHeaderSourcePtr spConnectingAsmHeaderSource;
			if (SUCCEEDED(res))
			{
				res = spConnectingAsmHeaderSource.Query(spConnectingProp);
			}
			
			// Propagate the file/stream headers
			if (SUCCEEDED(res))
			{
				IHXValues* pFileHeader = NULL;
				res = spConnectingAsmHeaderSource->GetFileHeader(&pFileHeader);
				
				if (SUCCEEDED(res))
				{
					res = SetFileHeader(pFileHeader);
				}
				
				HX_RELEASE(pFileHeader);
				
				m_Tracks.reserve(m_ulInputCount);
				// Get the stream headers		
				for (UINT32 i=0; i < m_ulInputCount && SUCCEEDED(res); i++)
				{
					IHXValues* pStreamHeader = NULL;
					res = spConnectingAsmHeaderSource->GetStreamHeader(i, &pStreamHeader);			
					
					if (SUCCEEDED(res))
					{
						res = SetStreamHeader(i, pStreamHeader);
					}
					
					HX_RELEASE(pStreamHeader);
				}
				m_Muxer.WriteHeaders();
			}
			
		}
		else
		{
			HXTLOG_APPROVED(LC_APP_ERROR,FILEOUT,"Failure to open output file %s in the mkv file writer.", m_strOutputPathname.c_str());
		}
	}
	else
	{
			res =  HXR_INVALID_PARAMETER;
			HXTLOG_APPROVED(LC_APP_ERROR,FILEOUT,"Invalid stream id %d sent to mkv file writer.", ulInputStreamID);
	}

	return res;
}

/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::Teardown
// Purpose:
//	Notification that the filter should flush any buffered data, if possible
STDMETHODIMP CMkvWriter::Teardown( UINT32 ulInputStreamID )
{
	HX_RESULT res = HXR_OK;
	
	res = m_Muxer.CloseFile();

	return res;
}


/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::SetEventSink
// Purpose:
//	Sets the filter-graph event sink
STDMETHODIMP CMkvWriter::SetGraphServices( IHXTServiceBroker *pServiceBroker )
{
	HX_RESULT res = pServiceBroker->GetService( IID_IHXTEventSink, m_spEventSink.AdoptUnknown() );
	HX_ASSERT( SUCCEEDED( res ) );
	return res;
}




/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::GetInputCount
// Purpose:
//	Gets the total number of input streams
STDMETHODIMP_(UINT32) CMkvWriter::GetInputStreamCount ()
{
	// Only a single input
	return 1;
}


/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::GetSupportedInputProperties
// Purpose:
//	Gets the supported input connection properties for a particular stream
STDMETHODIMP CMkvWriter::GetSupportedInputFormat ( UINT32 ulInputStreamID, IHXTPropertyBag** ppSupportedFormats )
{
	HX_RESULT res = HXR_OK;

	// Validate params
	if(!ppSupportedFormats)
	{
		res = HXR_POINTER;
	}


	if(!m_spFactory)
	{
		res = HXR_FAIL;
	}

	if(SUCCEEDED(res))
	{
		// Set supported input properties -- only takes ASM packetized streams
		if(!m_spSupportedInputFormat)
		{
			res = m_spFactory->CreateInstance(IID_IHXTPropertyBag, (void**)m_spSupportedInputFormat.AdoptUnknown());

			if (SUCCEEDED(res))
			{
				res = m_spSupportedInputFormat->SetString(kPropMediaFormat, kValueMediaFormatAsmPacketized);
			}

			// Use custom ASM connection prop 
			IHXTAsmConnectionPropertyPtr spConnectionProp = (IHXTAsmConnectionPropertyPtr) new CHXTAsmConnectionProperty();
			if (SUCCEEDED(res))
			{
				res = spConnectionProp->SetAsmHeaderSource(NULL);
			}

			if (SUCCEEDED(res))
			{
				m_spSupportedInputFormat->SetUnknown(kPropAsmHeaders, spConnectionProp);
			}
		}

		if (SUCCEEDED(res))
		{
			*ppSupportedFormats = m_spSupportedInputFormat;
			(*ppSupportedFormats)->AddRef();
		}
	}

	HX_ASSERT(SUCCEEDED(res));

	return res;		
}


/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::GetOutputCount
// Purpose:
//	Gets the total number of output streams
STDMETHODIMP_(UINT32) CMkvWriter::GetOutputStreamCount ()
{
	// No outputs
	HX_ASSERT(FALSE);	
	return 0;
}

/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::GetSupportedOutputProperties
// Purpose:
//	Gets the supported output connection properties for a particular stream
STDMETHODIMP CMkvWriter::GetSupportedOutputFormat ( UINT32 ulOutputStreamID, IHXTPropertyBag** ppSupportedFormats )
{
	HX_ASSERT(FALSE);	
	return HXR_FAIL;		
}


/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::ConnectInput
// Purpose:
//	Notification of the input format for a particular stream
STDMETHODIMP CMkvWriter::SetNegotiatedInputFormat ( UINT32 ulInputStreamID, IHXTPropertyBag* pConnectedFormat )
{
	HX_RESULT res = HXR_OK;
	
	// Validate params -- this filter will only ever have a single output
	if (ulInputStreamID != 0 || pConnectedFormat == NULL)	
	{
		res = HXR_INVALID_PARAMETER;
		HXTLOG_APPROVED(LC_APP_ERROR,FILEOUT,"Invalid stream id %d or NULL Connection Format sent to mkv file writer.", ulInputStreamID);
		HX_ASSERT(FALSE);
	}
	else
	{
		m_spConnectedInputFormat = pConnectedFormat;
	}
	
	return res;	
}



/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::ConnectOutput
// Purpose:
//	Notification of the output format for a particular stream
STDMETHODIMP CMkvWriter::SetNegotiatedOutputFormat ( UINT32 ulOutputStreamID, IHXTPropertyBag* pConnectedFormat )
{
	HX_ASSERT(FALSE);	
	return HXR_FAIL;		
}


/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::OnSetString
// Purpose:
//	Handle string-based configuration properties.  Returning a success code
//	means that the value will be added to the property bag.
STDMETHODIMP CMkvWriter::OnSetString( const char* szName, const char* szValue )
{
	HX_RESULT res = HXR_OK;

	// Validate params
	if (!szName || !szValue)
	{
		res = HXR_POINTER;
	}
	else
	{
		// Grab all known properties (don't need to do any validation)
		string strName = szName;
		if (strName == kPropOutputPathname)
		{
			m_strOutputPathname = szValue;
		}
		// Ignore temp path and plugin type
		else if (strName == kPropPluginType || strName == kPropTempDirPath)
		{
		}
		else
		{
			HXTLOG_APPROVED(LC_APP_WARN,FILEOUT,"Unrecognized property %s provided to the mkv file writer.", szName);
		}
	}

	HX_ASSERT(SUCCEEDED(res));
	return res;
}


/////////////////////////////////////////////////////////////////////////
// Method:
//	CMkvWriter::SetFactory
// Purpose:
//	Sets class factory
STDMETHODIMP CMkvWriter::SetFactory( IHXCommonClassFactory* pCCF )
{
	m_spFactory = pCCF;

	return init(pCCF);
}

CRealVideoAssembler::CRealVideoAssembler()
{
	m_bPacketReady = false;
}

HX_RESULT CRealVideoAssembler::DeliverSegments()
{
	HX_RESULT hr;
	size_t sg = 0;
	
	if(m_segments.size() == 0)
	{
		m_segments.Clear();
		return HXR_OK;
	}
	
	VectorPacket* p = &m_CompletePacket;
	
	p->rtStart = m_segments.rtStart;
	p->rtStop = m_segments.rtStart+1;
	
	UINT32 len = 0, total = 0;
	
	for (sg = 0; sg < m_segments.size(); sg++)
	{
		segment* s = m_segments.at(sg);
		len = max(len, s->offset + s->data.size());
		total += s->data.size();
	}
	HX_ASSERT(len == total);
	len += 1 + 2*4*(!m_segments.fMerged ? m_segments.size() : 1);
	
	p->pData.resize(len);
	
	UINT8* pData = &p->pData[0];
	
	*pData++ = m_segments.fMerged ? 0 : m_segments.size()-1;
	
	if(m_segments.fMerged)
	{
		*((UINT32*)pData) = 1; pData += 4;
		*((UINT32*)pData) = 0; pData += 4;
	}
	else
	{
		for (sg = 0; sg < m_segments.size(); sg++)
		{
			*((UINT32*)pData) = 1; pData += 4;
			*((UINT32*)pData) = m_segments.at(sg)->offset; pData += 4;
		}
	}
	
	for (sg = 0; sg < m_segments.size(); sg++)
	{
		segment* s = m_segments.at(sg);
		memcpy(pData + s->offset, &s->data[0], s->data.size());
	}
	
	// Quick packet copy
	/*m_CompletePacket.rtStart = p->rtStart;
	m_CompletePacket.rtStop = p->rtStop;	
	if (m_CompletePacket.pData.size() < p->pData.size())
		m_CompletePacket.pData.resize(p->pData.size()+1);
	memcpy(&m_CompletePacket.pData[0], &p->pData[0], p->pData.size());*/
	
	m_bPacketReady = true;
	
	m_segments.Clear();
	
	return hr;
}

HX_RESULT CRealVideoAssembler::FeedPacket(Packet* p)
{
	HX_RESULT hr = HXR_OK;
	
	HX_ASSERT(p->rtStart <= p->rtStop);
	
	
		int len = p->GetDataSize();
		UINT8* pIn = (UINT8 *)p->GetData();
		UINT8* pInOrg = pIn;
		
		if(m_segments.rtStart != p->rtStart)
		{
			if(HXR_OK != (hr = DeliverSegments()))
				return hr;
		}
		
		m_segments.rtStart = p->rtStart;
		
		while(pIn - pInOrg < len)
		{
			UINT8 hdr = *pIn++, subseq = 0, seqnum = 0;
			UINT32 packetlen = 0, packetoffset = 0;
			
			if((hdr&0xc0) == 0x40)
			{
				pIn++;
				packetlen = len - (pIn - pInOrg);
			}
			else
			{
				if((hdr&0x40) == 0)
					subseq = (*pIn++)&0x7f;
				
#define GetWORD(var) \
	var = (var<<8)|(*pIn++); \
	var = (var<<8)|(*pIn++); \
	
				GetWORD(packetlen);
				if(packetlen&0x8000) m_segments.fMerged = true;
				if((packetlen&0x4000) == 0) {GetWORD(packetlen); packetlen &= 0x3fffffff;}
				else packetlen &= 0x3fff;
				
				GetWORD(packetoffset);
				if((packetoffset&0x4000) == 0) {GetWORD(packetoffset); packetoffset &= 0x3fffffff;}
				else packetoffset &= 0x3fff;
				
#undef GetWORD
				
				if((hdr&0xc0) == 0xc0)
					// m_segments.rtStart = 10000i64*packetoffset - m_rtStart, packetoffset = 0;
					m_segments.rtStart = 10000i64*packetoffset, packetoffset = 0;
				else if((hdr&0xc0) == 0x80)
					packetoffset = packetlen - packetoffset;
				
				seqnum = *pIn++;
			}
			
			int len2 = min(len - (pIn - pInOrg), packetlen - packetoffset);
			
			segment *s = new segment;
			s->offset = packetoffset;
			s->data.resize(len2);
			memcpy(&s->data[0], pIn, len2);
			m_segments.push_back(s);
			
			pIn += len2;
			
			if((hdr&0x80) || packetoffset+len2 >= packetlen)
			{
				if(HXR_OK != (hr = DeliverSegments()))
					return hr;
			}
		}
		
		return hr;
}

HX_RESULT CRealVideoAssembler::PacketReady(Packet **p)
{
	HX_RESULT hr = HXR_FAIL;

	*p = NULL;

	if (m_bPacketReady) {
		*p = &m_CompletePacket;
		m_bPacketReady = false;
		hr = HXR_OK;
	}

	return hr;
}

CAssembler::Packet::Packet()
{
	rtStart = 0;
	rtStop = 0;
}

CAssembler::Packet::~Packet()
{

}

CAssembler::PointerPacket::PointerPacket()
{
	data = NULL;
	dataSize = 0;
}

CNullAssembler::CNullAssembler()
{
	m_lastPacket = NULL;
}

HX_RESULT CNullAssembler::FeedPacket(Packet* p)
{
	m_lastPacket = p;
	
	return HXR_OK;
}

HX_RESULT CNullAssembler::PacketReady(Packet **p)
{

	if (m_lastPacket != NULL) {
		*p = m_lastPacket;
		m_lastPacket = NULL;
		
		return HXR_OK;
	}
	
	*p = NULL;

	return HXR_FAIL;
}


CRealVideoAssembler::CSegments::CSegments() 
{
	rtStart = 0;
	fMerged = false;
};

CRealVideoAssembler::CSegments::~CSegments() 
{
	Clear();
};

void CRealVideoAssembler::CSegments::Clear() 
{
	rtStart = 0;
	//fDiscontinuity = fSyncPoint = false;
	fMerged = false;
	
	for (size_t sg = 0; sg < size(); sg++)
		delete at(sg);
	
	clear();
};

CRealAACAssembler::CRealAACAssembler(UINT8 _channels, UINT32 _sampleRate)
{
	channels = _channels;
	sampleRate = _sampleRate;
}

HX_RESULT CRealAACAssembler::FeedPacket(Packet* p)
{
	UINT8* ptr = (UINT8 *)p->GetData()+2;

	std::vector<UINT16> sizes;
	int total = 0;
	int remaining = p->GetDataSize()-2;
	int expected = *(ptr-1)>>4;

	while(total < remaining)
	{
		int size = (ptr[0]<<8)|(ptr[1]);
		sizes.push_back(size);
		total += size;
		ptr += 2;
		remaining -= 2;
		expected--;
	}

	HX_ASSERT(total == remaining);
	HX_ASSERT(expected == 0);

	HXT_TIME rtDur = 2048000 / (channels*sampleRate); // 2048 samples per sec (but always?)
	HXT_TIME rtStart = p->rtStart;

	for (size_t pos = 0; pos < sizes.size(); pos++)
	{
		PointerPacket *p2 = new PointerPacket();
		
		p2->rtStart = rtStart;
		p2->rtStop = rtStart + rtDur;
		p2->data = ptr;
		p2->dataSize = sizes.at(pos);		
		ptr += p2->dataSize;
		rtStart = p2->rtStop;
		
		splitPackets.push(p2);
	}

	return HXR_OK;
}

HX_RESULT CRealAACAssembler::PacketReady(Packet **p)
{
	if (!splitPackets.empty()) {
		*p = splitPackets.front();
		splitPackets.pop();

		return HXR_OK;
	}
	
	*p = NULL;

	return HXR_FAIL;
}

HelixTrack::HelixTrack(CAssembler *myAssembler)
{
	
	if (myAssembler != NULL)
		assembler = myAssembler;
	else
		assembler = new CNullAssembler();	
}

HelixTrack::~HelixTrack()
{
	if (assembler != NULL) {
		delete assembler;
		assembler = NULL;
	}
}

template<typename T>
static void bswap(T& var)
{
	UINT8* s = (UINT8*)&var;
	for(UINT8* d = s + sizeof(var)-1; s < d; s++, d--)
		*s ^= *d, *d ^= *s, *s ^= *d;
}

void rainfo::bswap()
{
	::bswap(version1);
	::bswap(version2);
	::bswap(header_size);
	::bswap(flavor);
	::bswap(coded_frame_size);
	::bswap(sub_packet_h);
	::bswap(frame_size);
	::bswap(sub_packet_size);
}

void rainfo4::bswap()
{	
	::bswap(sample_rate);
	::bswap(sample_size);
	::bswap(channels);
}

void rainfo5::bswap()
{
	::bswap(sample_rate);
	::bswap(sample_size);
	::bswap(channels);
}
