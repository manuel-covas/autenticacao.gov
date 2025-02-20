/* ****************************************************************************

 * eID Middleware Project.
 * Copyright (C) 2008-2009 FedICT.
 * Copyright (C) 2019 Caixa Magica Software.
 * Copyright (C) 2011 Vasco Silva - <vasco.silva@caixamagica.pt>
 * Copyright (C) 2011, 2016-2017 André Guerreiro - <aguerreiro1985@gmail.com>
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License version
 * 3.0 as published by the Free Software Foundation.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this software; if not, see
 * http://www.gnu.org/licenses/.

**************************************************************************** */
#ifndef __SMARTCARD_H__
#define __SMARTCARD_H__


#pragma pack(1)
typedef struct _PIN_VERIFY_STRUCTURE
{
	BYTE bTimeOut; // timeout in seconds (00 means use default timeout)
	BYTE bTimeOut2; // timeout in seconds after first key stroke
	BYTE bmFormatString; // formatting options
	BYTE bmPINBlockString; 
		// bits 7-4 bit size of PIN length in APDU, bits 3-0 PIN
		// block size in bytes after justification and formatting
	BYTE bmPINLengthFormat; 
		// bits 7-5 RFU, bit 4 set if system units are bytes 
		// clear if system units are bits,
		// bits 3-0 PIN length position in system units
	USHORT wPINMaxExtraDigit; 
		// XXYY, where XX is minimum PIN size in digits,
		// YY is maximum
	BYTE bEntryValidationCondition; 
		// Conditions under which PIN entry should be
		// considered complete
	BYTE bNumberMessage; // Number of messages to display for PIN verification
	USHORT wLangId; // Language for messages
	BYTE bMsgIndex; // Message index (should be 00)
	BYTE bTeoPrologue[3]; // T=1 I-block prologue field to use (fill with 00)
	ULONG ulDataLength; // length of Data to be sent to the ICC
	BYTE abData[13]; // Data to send to the ICC
} PIN_VERIFY_STRUCTURE, *PPIN_VERIFY_STRUCTURE;
#pragma pack()

#define FEATURE_VERIFY_PIN_START         0x01 
#define FEATURE_VERIFY_PIN_FINISH        0x02 
#define FEATURE_MODIFY_PIN_START         0x03 
#define FEATURE_MODIFY_PIN_FINISH        0x04 
#define FEATURE_GET_KEY_PRESSED          0x05 
#define FEATURE_VERIFY_PIN_DIRECT        0x06 
#define FEATURE_MODIFY_PIN_DIRECT        0x07 
#define FEATURE_MCT_READERDIRECT         0x08 
#define FEATURE_MCT_UNIVERSAL            0x09 
#define FEATURE_IFD_PIN_PROPERTIES       0x0A 
#define FEATURE_ABORT                    0x0B

#define SHA1_LEN   20
#define SHA256_LEN 32
#define SHA384_LEN 48
#define SHA512_LEN 64

typedef struct _FEATURES
{
	DWORD VERIFY_PIN_START;
	DWORD VERIFY_PIN_FINISH;
	DWORD VERIFY_PIN_DIRECT;
	DWORD MODIFY_PIN_START;
	DWORD MODIFY_PIN_FINISH;
	DWORD MODIFY_PIN_DIRECT;
	DWORD ABORT;
	DWORD GET_KEY_PRESSED;
} FEATURES, *PFEATURES;

extern DWORD PteidReadPrKDF(PCARD_DATA pCardData,
							DWORD *out_len,
							PBYTE *data);

extern DWORD PteidParsePrKDF(PCARD_DATA pCardData, 
							 DWORD *cbStream, 
							 BYTE *pbStream,
							 WORD *cbKeySize);

extern DWORD PteidReadFile
			(
				PCARD_DATA  pCardData, 
				DWORD dwOffset, 
				DWORD *cbStream, 
				PBYTE pbStream
			);

extern DWORD   PteidAuthenticateExternal
               (
                  PCARD_DATA     pCardData, 
                  PDWORD         pcAttemptsRemaining,
				  BOOL			 bSilent,
				  DWORD			PinId
  
               );

extern DWORD  PteidSelectApplet(PCARD_DATA     pCardData);

extern DWORD CCIDfindFeature
				(
					BYTE featureTag, 
					BYTE* features, 
					DWORD featuresLength
				);

extern DWORD CCIDgetFeatures
				( 
					PFEATURES pFeatures,
					SCARDHANDLE hCard
				);

extern DWORD createVerifyCommand
				(
					PPIN_VERIFY_STRUCTURE pVerifyCommand,
					unsigned int pin_ref
				);
extern DWORD createVerifyCommandGemPC
				(
					PPIN_VERIFY_STRUCTURE pVerifyCommand,
					unsigned int pin_ref
				);
extern DWORD createVerifyCommandACR83
				(
					PPIN_VERIFY_STRUCTURE pVerifyCommand, 
					unsigned int pin_ref
				);
#endif