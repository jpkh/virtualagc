### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	DOWNLINK_LISTS.agc
## Purpose:	Part of the source code for Colossus, build 249.
##		It is part of the source code for the Command Module's (CM)
##		Apollo Guidance Computer (AGC), for Apollo 9.
## Assembler:	yaYUL
## Reference:	pp. 166-176
## Contact:	Ron Burkey <info@sandroid.org>.
## Website:	www.ibiblio.org/apollo.
## Mod history:	08/07/04 RSB.	Adapted from similar Luminary 131 file.
##		2017-01-05 RSB	Page numbers now agree with those on the
##				original harcopy, as opposed to the PDF page
##				numbers in 1701.pdf.
##		2017-01-08 RSB	Cross-diff'd comment text (not whitespace)
##				vs the already-proofed corresponding Colossus
##				237 and Comanche 55 source-code files
##				and corrected errors found.
##
## The contents of the "Colossus249" files, in general, are transcribed 
## from a scanned copy of the program listing.  Notations on this
## document read, in part:
##
##	Assemble revision 249 of AGC program Colossus by NASA
##	2021111-041.  October 28, 1968.  
##
##	This AGC program shall also be referred to as
##				Colossus 1A
##
##	Prepared by
##			Massachusetts Institute of Technology
##			75 Cambridge Parkway
##			Cambridge, Massachusetts
##	under NASA contract NAS 9-4065.
##
## Refer directly to the online document mentioned above for further information.
## Please report any errors (relative to the scanned pages) to info@sandroid.org.
##
## In some cases, where the source code for Luminary 131 overlaps that of 
## Colossus 249, this code is instead copied from the corresponding Luminary 131
## source file, and then is proofed to incorporate any changes.

## Page 166
		BANK	22
		SETLOC	DOWNTELM
		BANK

		EBANK=	DNTMBUFF

# SPECIAL DOWNLINK OP CODES
#	OP CODE		ADDRESS (EXAMPLE)	  SENDS..		BIT 15		BITS 14-12	BITS 11
#													     -0
#	------	       -----------		----------		------		----------	-------
#													     --
#	1DNADR		TIME2			(2 AGC WDS)		0		0		ECADR
#	2DNADR		TEPHEM			(4 AGC WDS)		0		1		ECADR
#	3DNADR		VGBODY			(6 AGC WDS)		0		2		ECADR
#	4DNADR		STATE			(8 AGC WDS)		0		3		ECADR
#	5DNADR		UPBUFF			(10 AGC WDS)		0		4		ECADR
#	6DNADR		DSPTAB			(12 AGC WDS)		0		5		ECADR
#	DNCHAN		30			CHANNELS		0		7		CHANNEL
#													ADDRESS
#	DNPTR		NEXTLIST		POINTS TO NEXT		0		6		ADRES
#						LIST.
#
# DOWNLIST FORMAT DEFINITIONS AND RULES-
# 1. END OF A LIST = -XDNADR (X = 1 TO 6), -DNPTR, OR -DNCHAN.
# 2. SNAPSHOT SUBLIST = LIST WHICH STARTS WITH A -1DNADR.
# 3. SNAPSHOT SUBLIST CAN ONLY CONTAIN 1DNADRS.
# 4. TIME2 1DNADR MUST BE LOCATED IN THE CONTROL LIST OF A DOWNLIST.
# 5. ERASABLE DOWN TELEMETRY WORDS SHOULD BE GROUPED IN SEQUENTIAL
#    LOCATIONS AS MUCH AS POSSIBLE TO SAVE STORAGE USED BY DOWNLINK LISTS.
# 6. THE DOWNLINK LISTS (INCLUDING SUBLISTS) ARE ORGANIZED SUCH THAT THE ITEMS LISTED FIRST (IN FRONT OF FBANK) ARE
#    SENT FIRST.  EXCEPTION--- SNAPSHOT SUBLISTS.  IN THE SNAPSHOT SUBLISTS THE DATA REPRESENTED BY THE FIRST
#    11 1DNADRS IS PRESERVED (IN ORDER) IN DNTMBUFF AND SENT BY THE NEXT 11 DOWNRUPTS.  THE DATA REPRESENTED BY THE
#    LIST IS SENT IMMEDIATELY.

		COUNT	05/DLIST
ERASZERO	EQUALS	7
SPARE		EQUALS	ERASZERO			# USE SPARE TO INDICATE AVAILABLE SPACE
LOWIDCOD	OCT	77340				# LOW ID CODE
NOMDNLST	EQUALS	CMCSTADL			# FRESH START AND POST P27 DOWNLIST
UPDNLIST	EQUALS	CMENTRDL			# UPDATE PROGRAM (P27) DOWNLIST

## Page 167
# CSM POWERED FLIGHT DOWNLIST
#
# --------------------------CONTROL LIST----------------------------------

CMPOWEDL	EQUALS
		DNPTR	CMPOWE01			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMPOWE02			# COLLECT SECOND SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMPOWE03			# COMMON DATA
		1DNADR	TIG				# TIG,+1
		1DNADR	DELLT4				# DELLT4,+1
		3DNADR	RTARG				# RTARG,+1,+2,...+5
		1DNADR	TGO				# TGO,+1
		1DNADR	PIPTIME1			# PIPTIME1,+1
		3DNADR	DELV				# DELV,+1,...+4,+5
		1DNADR	PACTOFF				# PACTOFF,YACTOFF
		1DNADR	PCMD				# PCMD,YCMD
		1DNADR	CSTEER				# CSTEER,+1
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	SPARE
		6DNADR	REFSMMAT			# REFSMMAT,+1,...+10,+11
		DNPTR	CMPOWE04			# COMMON DATA
		1DNADR	TIME2				# TIME2,TIME1
		DNPTR	CMPOWE05			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMPOWE02			# COLLECT SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMPOWE03			#
		DNPTR	CMPOWE06			# COMMON DATA
		1DNADR	ELEV				# ELEV,+1
		1DNADR	CENTANG				# CENTANG,+1
		1DNADR	DELTAR				# DELTAR,+1
		1DNADR	STATE	+10D			# FALGWRDS 10 AND 11
		1DNADR	TEVENT				# TEVENT,+1
		1DNADR	PCMD				# PCMD,YCMD
		1DNADR	OPTMODES			# OPTMODES,HOLDFLAG
		DNPTR	CMPOWE07			# COMMON DATA
		3DNADR	VGTIG				# VGTIG,+1,...+4,+5
		1DNADR	SPARE
		1DNADR	SPARE
		-1DNADR	SPARE

# ---------------------------SUB LISTS------------------------------------

CMPOWE01	-1DNADR	RN	+2			# RN +2,+3			SNAPSHOT DATA
		1DNADR	RN	+4			# RN +4,+5
		1DNADR	VN				# VN, +1
		1DNADR	VN	+2			# VN +2,+3
## Page 168
		1DNADR	VN	+4			# VN +4,+5
		1DNADR	PIPTIME				# PIPTIME, +1
		-1DNADR	RN				# RN, +1

CMPOWE02	-1DNADR	CDUZ				# CDUZ,CDUT			SNAPSHOT DATA
		1DNADR	ADOT				# ADOT,+1/OGARATE,+1
		1DNADR	ADOT	+2			# ADOT+2,+3/OMEGAB+2,+3
		1DNADR	ADOT	+4			# ADOT+4,+5/OMEGAB+4,+5
		-1DNADR	CDUX				# CDUX,CDUY

CMPOWE03	2DNADR	AK				# AK,AK1,AK2,RCSFLAGS		COMMON DATA
		-2DNADR	THETADX				# THETADX,THETADY,THETADZ,GARBAGE

CMPOWE04	5DNADR	STATE				# FLAGWRD0 THRU FLAGWRD9	COMMON DATA
		-6DNADR	DSPTAB				# DISPLAY TABLES

CMPOWE05	-1DNADR	R-OTHER	+2			# R-OTHER+2,+3			SNAPSHOT DATA
		1DNADR	R-OTHER	+4			# R-OTHER+4,+5
		1DNADR	V-OTHER				# V-OTHER,+1
		1DNADR	V-OTHER	+2			# V-OTHER+2,+3
		1DNADR	V-OTHER	+4			# V-OTHER+4,+5
		1DNADR	T-OTHER				# T-OTHER,+1
		-1DNADR	R-OTHER				# R-OTHER,+1

CMPOWE06	1DNADR	RSBBQ				# RSBBQ,+1			COMMON DATA
		3DNADR	CADRFLSH			# CADRFLSH,+1,+2,FAILREG,+1,+2
		-2DNADR	CDUS				# CDUS,PIPAX,PIPAY,PIPAZ

CMPOWE07	1DNADR	LEMMASS				# LEMMASS,CSMMASS		COMMON DATA
		1DNADR	DAPDATR1			# DAPDATR1,DAPDATR2
		2DNADR	ERRORX				# ERRORX,ERRORY,ERRORZ,GARBAGE
		3DNADR	WBODY				# WBODY,...+5/OMEGAC,...+5
		2DNADR	REDOCTR				# REDOCTR,THETAD,+1,+2
		1DNADR	IMODES30			# IMODES30,IMODES33
		DNCHAN	11				# CHANNELS 11,12
		DNCHAN	13				# CHANNELS 13,14
		DNCHAN	30				# CHANNELS 30,31
		-DNCHAN	32				# CHANNELS 32,33

# ------------------------------------------------------------------------
## Page 169
# CSM COAST AND ALIGNMENT DOWNLIST

# ------------------------------CONTROL LIST------------------------------

CMCSTADL	EQUALS					# SEND ID BY SPECIAL CODING
		DNPTR	CMCSTA01			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMCSTA02			# COLLECT SECOND SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMCSTA03			# COMMON DATA
		1DNADR	TIG				# TIG,+1
		1DNADR	BESTI				# BESTI,BESTJ
		4DNADR	MARKDOWN			# MARKDOWN,+1...+5,+6,GARBAGE
		4DNADR	MARK2DWN			# MARK2DWN,+1...+5,+6
		2DNADR	HAPO				# HAPO,+1,HPER,+1
		1DNADR	RSP-RREC			# RSP-RREC,+1
		3DNADR	VGTIG				# VGTIG,...+5
		6DNADR	REFSMMAT			# REFSMMAT,+1,...+10,+11
		DNPTR	CMCSTA04			# COMMON DATA
		1DNADR	TIME2				# TIME2,TIME1
		DNPTR	CMCSTA05			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMCSTA02			# COLLECT SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMCSTA03			# COMMON DATA
		DNPTR	CMCSTA06			# COMMON DATA
		3DNADR	OGC				# OGC,+1,IGC,+1,MGC,+1
		1DNADR	STATE	+10D			# FALGWRDS 10 AND 11
		1DNADR	TEVENT				# TEVENT,+1
		1DNADR	LAUNCHAZ			# LAUNCHAZ,+1
		1DNADR	OPTMODES			# OPTMODES,HOLDFLAG
		DNPTR	CMCSTA07			# COMMON DATA
		-6DNADR	DSPTAB				# DISPLAY TABLES

# --------------------------SUB LISTS-------------------------------------

CMCSTA01	EQUALS	CMPOWE01			# COMMON DOWNLIST DATA

CMCSTA02	EQUALS	CMPOWE02			# COMMON DOWNLIST DATA

CMCSTA03	EQUALS	CMPOWE03			# COMMON DOWNLIST DATA

CMCSTA04	EQUALS	CMPOWE04			# COMMON DOWNLIST DATA

CMCSTA05	EQUALS	CMPOWE05			# COMMON DOWNLIST DATA

CMCSTA06	EQUALS	CMPOWE06			# COMMON DOWNLIST DATA

CMCSTA07	EQUALS	CMPOWE07			# COMMON DOWNLIST DATA

## Page 170
# ------------------------------------------------------------------------
## Page 171
# CSM RENDEZVOUS AND PRETHRUST LIST

# ----------------------------CONTROL LIST--------------------------------

CMRENDDL	EQUALS					# SEND ID BY SPECIAL CODING
		DNPTR	CMREND01			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMREND02			# COLLECT SECOND SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMREND03			# COMMON DATA
		1DNADR	TIG				# TIG,+1
		1DNADR	DELLT4				# DELLT4,+1
		3DNADR	RTARG				# RTARG,+1...+4,+5
		1DNADR	VHFTIME				# VHFTIME,+1
		4DNADR	MARKDOWN			# MARKTIME(DP),YCDU,SCDU,ZCDU,TCDU,XCDU,RM
		1DNADR	VHFCNT				# VHFCNT,+1
		1DNADR	TTPI				# TTPI,+1
		1DNADR	ECSTEER				# ECSTEER,+1
		1DNADR	DELVTPF				# DELVTPF,+1
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	TPASS4				# TPASS4,+1
		3DNADR	DELVSLV				# DELVSLV,+1...+4,+5
		2DNADR	RANGE				# RANGE,+1,RRATE,+1
		DNPTR	CMREND04			# COMMON DATA
		1DNADR	TIME2				# TIME2,TIME1
		DNPTR	CMREND05			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMREND02			# COLLECT SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMREND03			# COMMON DATA
		DNPTR	CMREND06			# COMMON DATA
		1DNADR	ELEV				# ELEV,+1
		1DNADR	CENTANG				# CENTANG,+1
		1DNADR	DELTAR				# DELTAR,+1
		3DNADR	DELVEET3			# DELVEET3,+1,...+4,+5
		1DNADR	OPTMODES			# OPTMODES,HOLDFLAG
		DNPTR	CMREND07			# COMMON DATA
		1DNADR	RTHETA				# RTHETA,+1
		2DNADR	LAT(SPL)			# LAT(SPL),LNG(SPL),+1
		2DNADR	VPRED				# VPRED,+1,GAMMAEI,+1
		-1DNADR	STATE	+10D			# FALGWRDS 10 AND 11

# ----------------------------SUB LISTS-----------------------------------

CMREND01	EQUALS	CMPOWE01			# COMMON DOWNLIST DATA

CMREND02	EQUALS	CMPOWE02			# COMMON DOWNLIST DATA

CMREND03	EQUALS	CMPOWE03			# COMMON DOWNLIST DATA
## Page 172
CMREND04	EQUALS	CMPOWE04			# COMMON DOWNLIST DATA

CMREND05	EQUALS	CMPOWE05			# COMMON DOWNLIST DATA

CMREND06	EQUALS	CMPOWE06			# COMMON DOWNLIST DATA

CMREND07	EQUALS	CMPOWE07			# COMMON DOWNLIST DATA

# ------------------------------------------------------------------------

## Page 173
# CSM ENTRY AND UPDATE DOWNLIST
# ---------------------------CONTROL LIST---------------------------------

CMENTRDL	EQUALS					# SEND ID BY SPECIAL CODING
		DNPTR	CMENTR01			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMENTR02			# COLLECT SECOND SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMENTR03			# COMMON DATA
		2DNADR	CMDAPMOD			# CMDAPMOD,PREL,QREL,RREL
		1DNADR	L/D1				# L/D1,+1
		6DNADR	UPBUFF				# UPBUFF,+1...+10,+11
		4DNADR	UPBUFF	+12D			# UPBUFF+12,13...+18,19D
		2DNADR	COMPNUMB			# COMPNUMB,UPOLDMOD,UPVERB,UPCOUNT
		1DNADR	PAXERR1				# PAXERR1,ROLLTM
		3DNADR	LATANG				# LATANG,+1,RDOT,+1,THETAH,+1
		2DNADR	LAT(SPL)			# LAT(SPL),+1,LNG(SPL),+1
		1DNADR	ALFA/180			# ALFA/180,BETA/180
		DNPTR	CMENTR04			# COMMON DATA
		1DNADR	TIME2				# TIME2,TIME1
		DNPTR	CMENTR05			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMENTR02			# COLLECT SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		2DNADR	AK				# AK,AK1,AK2,RCSFLAGS
		3DNADR	ERRORX				# ERRORX/Y/Z,THETADX/Y/Z
		2DNADR	CMDAPMOD			# CMDAPMOD,PREL,QREL,RREL
		6DNADR	UPBUFF				# UPBUFF+0,+1...+10,+11D
		4DNADR	UPBUFF	+12D			# UPBUFF+12,+13...+18,+19D
		1DNADR	LEMMASS				# LEMMASS,CSMMASS
		1DNADR	DAPDATR1			# DAPDATR1,DAPDATR2
		1DNADR	ROLLTM				# ROLLTM,ROLLC
		1DNADR	OPTMODES			# OPTMODES,HOLDFLAG
		3DNADR	WBODY				# WBODY,...+5/OMEGAC,...+5
		2DNADR	REDOCTR				# REDOCTR,THETAD+0,+1,+2
		1DNADR	IMODES30			# IMODES30,IMODES33
		DNCHAN	11				# CHANNELS 11,12
		DNCHAN	13				# CHANNELS 13,14
		DNCHAN	30				# CHANNELS 30,31
		DNCHAN	32				# CHANNELS 32,33
		1DNADR	RSBBQ				# RSBBQ,+1
		3DNADR	CADRFLSH			# CADRFLSH,+1,+2,FAILREG,+1,+2
		1DNADR	STATE	+10D			# FALGWRDS 10 AND 11
		-1DNADR	GAMMAEI				# GAMMAEI,+1

# ----------------------------SUB LISTS-----------------------------------

CMENTR01	EQUALS	CMPOWE01			# COMMON DOWNLIST DATA
## Page 174
CMENTR02	EQUALS	CMPOWE02			# COMMON DOWNLIST DATA

CMENTR03	EQUALS	CMPOWE03			# COMMON DOWNLIST DATA

CMENTR04	EQUALS	CMPOWE04			# COMMON DOWNLIST DATA

CMENTR05	-1DNADR	DELV				# DELV,+1			SNAPSHOT DATA
		1DNADR	DELV	+2			# DELV+2,+3
		1DNADR	DELV	+4			# DELV+4,+5
		1DNADR	TTE				# TTE,+1
		1DNADR	VIO				# VIO,+1
		1DNADR	VPRED				# VPRED,+1
		-1DNADR	PIPTIME1			# PIPTIME1,+1

CMENTR06	EQUALS	CMPOWE06			# COMMON DOWNLIST DATA

CMENTR07	EQUALS	CMPOWE07			# COMMON DOWNLIST DATA

# ------------------------------------------------------------------------

## Page 175
# P22 DOWNLISTS

# ----------------------------CONTROL LIST--------------------------------

CMPG22DL	EQUALS					# SEND ID BY SPECIAL CODING
		DNPTR	CMPG2201			# COLLECT SNAPSHOT
		6DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMPG2202			# COLLECT SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMPG2203			# COMMON DATA
		6DNADR	SVMRKDAT			# LANDING SITE MARK DATA
		6DNADR	SVMRKDAT +12D			# SVMRKDAT+0...+34
		6DNADR	SVMRKDAT +24D			# LANDING SITE MARK DATA
		1DNADR	LANDMARK			# LANDMARK,GARBAGE
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	SPARE
		DNPTR	CMPG2204			# COMMON DATA
		1DNADR	TIME2				# TIME2,TIME1
		DNPTR	CMPG2205			# COLLECT SNAPSHOT
		2DNADR	DNTMBUFF			# SEND SNAPSHOT
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	SPARE
		DNPTR	CMPG2202			# COLLECT SNAPSHOT
		4DNADR	DNTMBUFF			# SEND SNAPSHOT
		DNPTR	CMPG2203			# COMMON DATA
		DNPTR	CMPG2206			# COMMON DATA
		1DNADR	8NN				# 8NN,GARBAGE
		1DNADR	STATE	+10D			# FALGWRDS 10 AND 11
		3DNADR	RLS				# RLS,+1,...+4,+5
		1DNADR	SPARE
		1DNADR	OPTMODES			# OPTMODES,HOLDFLAG
		DNPTR	CMPG2207			# COMMON DATA
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	SPARE
		1DNADR	SPARE
		-1DNADR	SPARE

# -----------------------------SUB LISTS----------------------------------

CMPG2201	EQUALS	CMPOWE01			# COMMON DOWNLIST DATA

CMPG2202	EQUALS	CMPOWE02			# COMMON DOWNLIST DATA

CMPG2203	EQUALS	CMPOWE03			# COMMON DOWNLIST DATA
## Page 176
CMPG2204	EQUALS	CMPOWE04			# COMMON DOWNLIST DATA

CMPG2205	-1DNADR	LONG				# LONG,+1			SNAPSHOT DATA
		1DNADR	ALT				# ALT,+1
		-1DNADR	LAT				# LAT,+1

CMPG2206	EQUALS	CMPOWE06			# COMMON DOWNLIST DATA

CMPG2207	EQUALS	CMPOWE07			# COMMON DOWNLIST DATA

# ------------------------------------------------------------------------

DNTABLE		GENADR	CMCSTADL
		GENADR	CMENTRDL
		GENADR	CMRENDDL
		GENADR	CMPOWEDL
		GENADR	CMPG22DL

# ------------------------------------------------------------------------


