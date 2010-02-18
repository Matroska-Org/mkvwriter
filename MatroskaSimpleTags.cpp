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
	\version $Id: MatroskaSimpleTags.cpp,v 1.1 2004/03/24 05:46:51 jcsston Exp $
	\author Jory Stone           <jcsston @ toughguy.net>
 	\brief

 	\par CVS Log
  	$Log: MatroskaSimpleTags.cpp,v $
  	Revision 1.1  2004/03/24 05:46:51  jcsston
  	Initial Commit

  	Revision 1.1  2004/01/04 01:07:31  jcsston
  	Finally some matroska muxing code
  	

*/

#include "MatroskaSimpleTags.h"

MatroskaSimpleTag::MatroskaSimpleTag()
{
	name = L"";
	value = L"";
};

MatroskaTagInfo::MatroskaTagInfo()
{
	targetTrackUID = 0;
	targetChapterUID = 0;
	targetAttachmentUID = 0;
};

void MatroskaTagInfo::SetTagValue(const char *name, const char *value)
{
	for (size_t s = 0; s < tags.size(); s++) {
		MatroskaSimpleTag &currentSimpleTag = tags.at(s);
		if (!strcmpi(currentSimpleTag.name.GetUTF8().c_str(), name)) {
			currentSimpleTag.value.SetUTF8(value);
			return;
		}
	}
	// If we are here then we didn't find this tag in the vector already
	MatroskaSimpleTag newSimpleTag;
	newSimpleTag.name.SetUTF8(name);
	newSimpleTag.value.SetUTF8(value);
	tags.push_back(newSimpleTag);
};

MatroskaTagInfo *MatroskaTagVector::FindTagWithTrackUID(uint64 trackUID) 
{
	MatroskaTagInfo *foundTag = NULL;

	for (size_t t = 0; t < size(); t++) {
		MatroskaTagInfo &currentTag = at(t);	
		if (currentTag.targetTrackUID == trackUID) {
			foundTag = &currentTag;
			break;
		}
	}

	return foundTag;
}

MatroskaTagInfo *MatroskaTagVector::FindTagWithChapterUID(uint64 chapterUID, uint64 trackUID)
{
	MatroskaTagInfo *foundTag = NULL;

	for (size_t t = 0; t < size(); t++) {
		MatroskaTagInfo &currentTag = at(t);	
		if (currentTag.targetChapterUID == chapterUID) {
			if (trackUID != 0) {
				if (currentTag.targetTrackUID != trackUID)
					continue;
			}
			foundTag = &currentTag;
			break;
		}
	}

	return foundTag;
};
