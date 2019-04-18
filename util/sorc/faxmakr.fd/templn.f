      SUBROUTINE TEMPLN(Z,IMAX,JMAX,SCALE,A,B,M,LPLMI,IFF)
C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C                .      .    .                                       .
C SUBPROGRAM:    TEMPLN      PUT A BOX AROUND THE TEMPERATURE.
C   PRGMMR: KRISHNA KUMAR         ORG: W/NP12   DATE: 1999-08-01
C
C ABSTRACT: PUT A BOX AROUND THE TEMPERATURE..
C
C PROGRAM HISTORY LOG:
C   ??-??-??  DICK SCHURR
C   93-04-07  LILLY CONVERT SUBROUTINE TO FORTRAN 77
C   96-10-30  LIN   CONVERT SUBROUTINE TO FORTRAN CFT77
C 1999-08-01  KRISHNA KUMAR CONVERTED THIS CODE FROM CRAY TO IBM RS/6000.
C
C USAGE:    CALL TEMPLN( Z, IMAX, JMAX, SCALE, A, B, M, LPLMI, IFF )
C   INPUT ARGUMENT LIST:
C     INARG1   - GENERIC DESCRIPTION, INCLUDING CONTENT, UNITS,
C     INARG2   - TYPE.  EXPLAIN FUNCTION IF CONTROL VARIABLE.
C
C   OUTPUT ARGUMENT LIST:      (INCLUDING WORK ARRAYS)
C     WRKARG   - GENERIC DESCRIPTION, ETC., AS ABOVE.
C     OUTARG1  - EXPLAIN COMPLETELY IF ERROR RETURN
C     ERRFLAG  - EVEN IF MANY LINES ARE NEEDED
C
C   INPUT FILES:   (DELETE IF NO INPUT FILES IN SUBPROGRAM)
C     DDNAME1  - GENERIC NAME & CONTENT
C
C   OUTPUT FILES:  (DELETE IF NO OUTPUT FILES IN SUBPROGRAM)
C     DDNAME2  - GENERIC NAME & CONTENT AS ABOVE
C     FT06F001 - INCLUDE IF ANY PRINTOUT
C
C REMARKS: LIST CAVEATS, OTHER HELPFUL HINTS OR INFORMATION
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE: IBM 
C
C$$$
C     ...GIVEN TEMPS IN Z(IMAX,JMAX)
C        AND MULTIPLICATIVE AND ADDITIVE CONSTANTS
C     ...TO READY FOR DIAMOND TEMPS GRIDPRINT IN LABEL ARRAY
      COMMON/PUTARG/PUTHGT,PUTANG,IPRPUT(2),ITAPUT
      COMMON/ADJ3/IRTCOR,IUPCOR
C
      DIMENSION ITEXT(3),JTEXT(3)
      CHARACTER*8 IFF(5)
      DIMENSION Z(IMAX,JMAX)
C
      CHARACTER*12  LTEXT
      CHARACTER*12  MTEXT
      CHARACTER*4   LPLMI
      CHARACTER*2   IBOX
      INTEGER       M(2)
C
      REAL   INDEF,IDEF
      INTEGER  IPRT(2)
C
C     DATA JLOB/2/,JHIB/50/
C     DATA ILHS/2/,IRHS/46/
C     DATA ILHSB/4/,IRHSB/44/
      DATA JLOB/9/,JHIB/57/
      DATA ILHS/11/,IRHS/55/
      DATA ILHSB/13/,IRHSB/53/
      DATA INDEF   /1.0E307 /
      DATA ITEXT/3*0/
      DATA IBOX/')$'/
      DATA NN/2/
      DATA HT/10.0/
      DATA IPRT/0,1/
      DATA IKCIR/1/
      DATA JKCIR/-9/
C  ...WHERE IKCIR AND JKCIR IS DISPLACEMENT FROM PRINT TO BOX
      DATA IDELTA  / 0 /
      DATA JDELTA  / 0 /
C
C     EQUIVALENCE(LTEXT,ITEXT(1))
C     EQUIVALENCE(MTEXT,JTEXT(1))
C
      INDENT = 0
C     ...WHERE INDENT IS ALTERNATING SWITCH FOR INDENTING A ROW OR NOT.
      DO 450 J=JLOB,JHIB,2
          IF(INDENT) 430,434,430
 430      INDENT=0
          IF(J.EQ.4+07.OR.J.EQ.48+07) GO TO 431
          IF(J.EQ.8+07.OR.J.EQ.44+07) GO TO 432
          IF(J.EQ.12+07.OR.J.EQ.40+07) GO TO 433
          I = ILHSB
          I2 = IRHSB
          GO TO 440
 431      I=ILHSB+3*4
          I2=IRHSB-3*4
          GO TO 440
 432      I=ILHSB+2*4
          I2=IRHSB-2*4
          GO TO 440
 433      I=ILHSB+4
          I2=IRHSB-4
          GO TO 440
  434     INDENT = 1
          IF(J.EQ.2+07.OR.J.EQ.50+07) GO TO 435
          IF(J.EQ.6+07.OR.J.EQ.46+07) GO TO 436
          IF(J.EQ.10+07.OR.J.EQ.42+07) GO TO 437
          I = ILHS
          I2 = IRHS
          GO TO 440
 435      I=ILHS+3*4
          I2=IRHS-3*4
          GO TO 440
 436      I=ILHS+2*4
          I2=IRHS-2*4
          GO TO 440
 437      I=ILHS+4
          I2=IRHS-4
          GO TO 440
C     ...PERFORM OPERATION ON TEMP PT(I,J)
  440     CONTINUE
          IDEF=Z(I,J)
          IF(IDEF.EQ.INDEF) GO TO 445
          XJ=J-1
          JCAL=SCALE*XJ+0.5
          JCAL=JCAL+IUPCOR + JDELTA
          JLLCIR=JCAL+JKCIR
          XI=I-1
          ICAL=SCALE*XI+0.5
          ICAL=ICAL+IRTCOR + IDELTA
          ILLCIR=ICAL+IKCIR
          XVAL=Z(I,J)
          HOLD=B*(XVAL+A)
          ITEXT(1)=SIGN((ABS(HOLD)+0.05),HOLD)
          INTG=ITEXT(1)
          NCHAR=M(2)
C
C     FORMAT TEMPERATURE VALUE
C
          CALL BIN2EB(INTG,MTEXT,NCHAR,LPLMI)
          N=12
          WRITE(LTEXT,FMT=IFF)MTEXT
C         WRITE(LTEXT,FMT=IFF)JTEXT(1)
C
C     PUT TEMPERATURE IN LABEL ARRAY
C
          CALL PUTLAB(ICAL,JCAL,PUTHGT,LTEXT,PUTANG,N,IPRT,0)
C
C     PUT BOX IN LABEL ARRAY
C
          CALL PUTLAB(ILLCIR,JLLCIR,HT,IBOX,PUTANG,NN,IPRPUT,0)
 445      CONTINUE
          I=I+4
          IF(I .LE. I2) GO TO 440
C     ...WHEN IT FALLS THRU HERE,THIS ROW IS FINISHED.  GO NEXT J
  450 CONTINUE
      RETURN
      END
