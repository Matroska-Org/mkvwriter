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

#ifndef _MKV_WRITER_H_
#define _MKV_WRITER_H_

#include "unkimp.h"
#include "ihxtbase.h"
#include "hxtconfigagent.h"
#include "utstring.h"
#include "MatroskaMuxer.h"
#include <vector>
#include <string>

class CAssembler
{
public:
	class Packet
	{
	public:
		Packet();
		virtual ~Packet();

		HXT_TIME rtStart, rtStop;
		virtual void *GetData() = 0;
		virtual UINT32 GetDataSize() = 0;
	};

	class VectorPacket : public Packet
	{
	public:
		virtual void *GetData() { return &pData[0]; };
		virtual UINT32 GetDataSize() { return pData.size(); };

		std::vector<UINT8> pData;
	};

	class PointerPacket : public Packet
	{
	public:
		PointerPacket();

		virtual void *GetData() { return data; };
		virtual UINT32 GetDataSize() { return dataSize; };

		UINT8 *data;
		UINT32 dataSize;
	};

	virtual HX_RESULT FeedPacket(Packet* p) = 0;
	virtual HX_RESULT PacketReady(Packet **p) = 0;
};

class CNullAssembler : public CAssembler
{
public:
	CNullAssembler();

	HX_RESULT FeedPacket(Packet* p);
	HX_RESULT PacketReady(Packet **p);
protected:
	Packet *m_lastPacket;
};

class CRealVideoAssembler : public CAssembler
{
public:
	CRealVideoAssembler();

	HX_RESULT FeedPacket(Packet* p);
	HX_RESULT PacketReady(Packet **p);

protected:
	typedef struct {std::vector<UINT8> data; UINT32 offset;} segment;

	class CSegments : public std::vector<segment *>
	{
	public:
		CSegments();
		~CSegments();
		HXT_TIME rtStart; 
		bool fMerged;
		void Clear();
	} m_segments;

	bool m_bPacketReady;
	VectorPacket m_CompletePacket;

	HX_RESULT DeliverSegments();

};

class CRealAACAssembler : public CAssembler
{
public:
	CRealAACAssembler(UINT8 _channels, UINT32 _sampleRate);

	HX_RESULT FeedPacket(Packet* p);
	HX_RESULT PacketReady(Packet **p);

protected:
	std::queue<Packet *> splitPackets;
	UINT8 channels;
	UINT32 sampleRate;
};

class HelixTrack {
public:
	HelixTrack(CAssembler *myAssembler = NULL);
	~HelixTrack();

	CAssembler *assembler;
};

class CMkvWriter:
	public CUnknownIMP
	,public IHXTConnectionAgent
	,public IHXTOutputFilter
	,public CHXTConfigurationAgent
{
	// Declares IUnknown methods
	DECLARE_UNKNOWN(CMkvWriter)

public:

	// CHXTConfigurationAgent methods
	STDMETHOD( OnSetString )( const char* szName, const char* szValue );
	STDMETHOD(OnInitialize)( IHXTPropertyBag* pPropBag, IHXTPropertyBag* pConsumedPropBag, IHXTPropertyBag* pErrorBag );

	// IHXTConnectionAgent methods
	STDMETHOD_( UINT32, GetInputStreamCount ) ();
	STDMETHOD ( GetSupportedInputFormat ) ( UINT32 ulStreamID, IHXTPropertyBag** ppSupportedFormats );
	STDMETHOD_( UINT32, GetOutputStreamCount) ();	
	STDMETHOD ( GetSupportedOutputFormat ) ( UINT32 ulStreamID, IHXTPropertyBag** ppSupportedFormats );	
	STDMETHOD ( SetNegotiatedInputFormat ) ( UINT32 ulStreamID, IHXTPropertyBag* pConnectedFormat );
	STDMETHOD ( SetNegotiatedOutputFormat ) ( UINT32 ulStreamID, IHXTPropertyBag* pConnectedFormat );
	STDMETHOD ( GetPreferredInputFormat ) ( THIS_ UINT32 uIndex, UINT32 uPrefRank, IHXTPropertyBag** ppPreferredFormat ) {return HXR_FAIL;}
	STDMETHOD ( GetPreferredOutputFormat ) ( THIS_ UINT32 uIndex, UINT32 uPrefRank, IHXTPropertyBag** ppPreferredFormat ) {return HXR_FAIL;}	
	STDMETHOD ( GetNegotiatedInputFormat ) ( THIS_ UINT32 uIndex, IHXTPropertyBag** pSupportedFormats ) {return HXR_FAIL;}
	STDMETHOD ( GetNegotiatedOutputFormat ) ( THIS_ UINT32 uIndex, IHXTPropertyBag** pSupportedFormats ) {return HXR_FAIL;}

	// IHXTFilter methods
	STDMETHOD( Prime )( UINT32 ulOutputStreamID );
	STDMETHOD( Teardown )( UINT32 ulOutputStreamID );
	STDMETHOD( SetGraphServices )( IHXTServiceBroker *pServiceBroker );
	STDMETHOD( SetFactory ) ( THIS_ IHXCommonClassFactory* pCCF );
	STDMETHOD( DiscardCachedSamples )( THIS_ UINT32 uStream ) {return HXR_OK;}

	// IHXTOutputFilter methods
	STDMETHOD( ReceiveSample )( UINT32 ulInputStreamID, IHXTMediaSample* pSample );

	// IHXTAsmHeaderSink methods
	STDMETHOD(SetFileHeader) (THIS_ IHXValues* pFileHeader);
	STDMETHOD(SetStreamHeader) (THIS_ UINT32 ulStreamNumber, IHXValues* pStreamHeader);

	// XXXLY - For now
	CMkvWriter();

private:
	virtual ~CMkvWriter();

	MatroskaMuxer m_Muxer;

	IHXTPropertyBagPtr	m_spSupportedInputFormat;
	UINT32 m_ulInputCount;
	IHXTPropertyBagPtr m_spConnectedInputFormat;
	std::vector<HelixTrack *> m_Tracks;
	CAssembler::PointerPacket m_PointerPacket;

	std::string m_strOutputPathname;

	IHXTEventSinkPtr m_spEventSink;

	HXT_MAKE_SMART_PTR(IHXCommonClassFactory);
	IHXCommonClassFactoryPtr m_spFactory;
};


struct rainfo
{
	UINT32 fourcc1;             // '.', 'r', 'a', 0xfd
	UINT16 version1;            // 4 or 5
	UINT16 unknown1;            // 00 000
	UINT32 fourcc2;             // .ra4 or .ra5
	UINT32 unknown2;            // ???
	UINT16 version2;            // 4 or 5
	UINT32 header_size;         // == 0x4e
	UINT16 flavor;              // codec flavor id
	UINT32 coded_frame_size;    // coded frame size
	UINT32 unknown3;            // big number
	UINT32 unknown4;            // bigger number
	UINT32 unknown5;            // yet another number
	UINT16 sub_packet_h;
	UINT16 frame_size;
	UINT16 sub_packet_size;
	UINT16 unknown6;            // 00 00
	void bswap();
};

struct rainfo4 : rainfo
{
	UINT16 sample_rate;
	UINT16 unknown8;            // 0
	UINT16 sample_size;
	UINT16 channels;
	void bswap();
};

struct rainfo5 : rainfo
{
	UINT8 unknown7[6];          // 0, srate, 0
	UINT16 sample_rate;
	UINT16 unknown8;            // 0
	UINT16 sample_size;
	UINT16 channels;
	UINT32 genr;                // "genr"
	UINT32 fourcc3;             // fourcc
	void bswap();
};

#endif // _MKV_WRITER_H_

