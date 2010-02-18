/*
 *  General Matroska Muxer Interface
 *
 *  Copyright (C) 2003-2004, Jory Stone <jcsston @ toughguy.net>
 *
 *  SOMa is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  SOMa is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with SOMa; see the file COPYING.  If not, write to
 *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

/*!
	\version $Id: MatroskaSimpleTags.h,v 1.1 2004/03/24 05:46:51 jcsston Exp $
	\author Jory Stone           <jcsston @ toughguy.net>
 	\brief

 	\par CVS Log
  	$Log: MatroskaSimpleTags.h,v $
  	Revision 1.1  2004/03/24 05:46:51  jcsston
  	Initial Commit

  	Revision 1.1  2004/01/04 01:07:31  jcsston
  	Finally some matroska muxing code
  	

*/

#include <vector>
#include "ebml/EbmlTypes.h"
#include "ebml/EbmlString.h"
#include "ebml/EbmlUnicodeString.h"

using namespace LIBEBML_NAMESPACE;

class MatroskaSimpleTag {
public:
	MatroskaSimpleTag();

	UTFstring name;
	UTFstring value;
};

class MatroskaTagInfo {
public:
	MatroskaTagInfo();
	void SetTagValue(const char *name, const char *value);

	uint64 targetTrackUID;
	uint64 targetChapterUID;
	uint64 targetAttachmentUID;

	std::vector<MatroskaSimpleTag> tags;
};

class MatroskaTagVector : public std::vector<MatroskaTagInfo>
{
public:
	MatroskaTagInfo *FindTagWithTrackUID(uint64 trackUID);
	MatroskaTagInfo *FindTagWithChapterUID(uint64 chapterUID, uint64 trackUID = 0);
};
