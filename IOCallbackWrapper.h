/*
 *  Part of The TCMP Matroska CDL, and Matroska Shell Extension
 *
 *  Copyright (C) Jory Stone - June 2003
 *
 *  The TCMP Matroska CDL is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  The TCMP Matroska CDL is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with The TCMP Matroska CDL; see the file COPYING.  If not, write to
 *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#ifndef IO_CALLBACK_WRAPPER_H
#define IO_CALLBACK_WRAPPER_H

#include "ebml/IOCallback.h"
#include "ebml/StdIOCallback.h"
#include "ebml/EbmlTypes.h"

// WinIOCallback (support for 4GB+ files)
#ifdef WIN32
#include "WinIOCallback.h"
#endif // WIN32

using namespace LIBEBML_NAMESPACE;

class FileIOCallback : public IOCallback
{
	public:
	FileIOCallback(const char *Path, const open_mode Mode) {		
#ifdef WIN32
		m_fileHandle = new WinIOCallback(Path, Mode);
#else // Under Linux?
		m_fileHandle = new StdIOCallback(Path, Mode);
#endif
	};
	FileIOCallback(const wchar_t *Path, const open_mode Mode) {		
#ifdef WIN32
#ifdef _UNICODE		
		m_fileHandle = new WinIOCallback(Path, Mode);
#else
		//I have to convert the file name to ANSI
		m_fileHandle = new WinIOCallback(Path, Mode);
#endif // _UNICODE
#else // Under Linux?
		m_fileHandle = new StdIOCallback(Path, Mode);
#endif		
	};
	~FileIOCallback() {
		delete m_fileHandle; 
	};

	uint32 read(void *Buffer, size_t Size) {
		return m_fileHandle->read(Buffer, Size);
	};
	size_t write(const void *Buffer, size_t Size) {
		return m_fileHandle->write(Buffer, Size);
	};
	void setFilePointer(int64 Offset, seek_mode Mode=seek_beginning) {
		m_fileHandle->setFilePointer(Offset, Mode);
	};
	uint64 getFilePointer() {
		return m_fileHandle->getFilePointer();
	};
	void close() {
		m_fileHandle->close();
	};

	protected:
	IOCallback *m_fileHandle;
};

#endif // IO_CALLBACK_WRAPPER_H
